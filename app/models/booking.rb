class Booking < ApplicationRecord
  acts_as_paranoid
  enum status: [ :seated,:no_show,:cancelled]
  belongs_to :restaurant
  belongs_to :customer,optional: true

  scope :by_restaurant, -> (restaurant) {where(restaurant: restaurant)}
  scope :created, -> {where(status: nil)}
  scope :new_bookings, ->{where(status: nil)}
  validates :booking_date,:booking_time,:size,:party_name,:restaurant_id,presence: true

  after_save :stop_sequence
  after_create :set_customer
  

  def booking_time
    "#{self.booking_date} #{super}".to_datetime
  end
  def set_checkin flag=true
    wait_time = self.calculate_wait_time
    self.update(checkin: flag,wait_in_minutes: wait_time)
  end

  def calculate_wait_time
    time1 = self.booking_time.utc
    time2 = Time.now.utc
    wait_time = 0
    if time2 < time1
      # calculate wait time in minutes
      wait_time = (time1 - time2)/60
    end
    wait_time
  end

  def booked_by
    self.restaurant.user
  end

  def auto_no_show
    if self.is_noshow_markable?
      self.notes = "#{self.notes}\nAutomarked no-show by system"
      self.no_show!
      ActionCable.server.broadcast 'bookings',
        booking: self
    else
      self.set_job_broadcast
    end
    true
  end

  def set_noshow_job
    if self.saved_change_to_attribute?(:booking_date) or self.saved_change_to_attribute?(:booking_time)
      set_job_broadcast
    end
  end

  def created_hour
    self.created_at.strftime('%H')
  end




  
  # returns true/false
  # true if booking time + threshold is less than current time, otherwise false
  def is_noshow_markable?
    return true if self.no_show? # already marked as no_show
    user = self.booked_by
    threshold = user.no_show_threshold.to_i
    date = self.booking_date.strftime("%Y-%m-%d")
    time = self.booking_time.strftime("%H:%M")
    # booking time with threshold margin in user time zone
    bt = "#{date} #{time}".in_time_zone(user.time_zone) + threshold.minutes
    # current time in user time zone
    ct = Time.now.in_time_zone(user.time_zone)
    return bt < ct
  end

  def set_job_broadcast
    user = self.booked_by
    threshold = user.no_show_threshold.to_i
    date = self.booking_date.strftime("%Y-%m-%d")
    time = self.booking_time.strftime("%H:%M")
    # booking time with threshold margin in user time zone
    bt = "#{date} #{time}".in_time_zone(user.time_zone) + threshold.minutes
    puts "in set_job_broadcast: bt: #{bt} ct: #{Time.now}"
    self.delay(run_at: bt).auto_no_show
    #BookingBroadcastJob.set(wait_until: bt).perform_later(self)
  end

  ##########################################
  ## Send message to customer, and schedule
  ## next message, if next template exists
  ## @params: message_template
  ##########################################
  def send_message message_template
    # return if sequence in progress is false
    return {error: false,message: "Message Sequence is stopped by user."} unless self.sequence_in_progress
    
    next_template = MessageTemplate.next_template(message_template)
    recipents = [self.phone]
    content = message_template.template
    response = Message.send_sms(recipents,content,self.restaurant,'text_ready')
    if next_template.present? and !response[:error]
      # schedule next message, if next template exists
      next_scheduled_time = Time.now + next_template.next_delay.to_i.minutes
      self.delay(run_at: next_scheduled_time).send_message(next_template)
    else
      self.broadcast_stop_sequence
    end
    response
  end


  
  # stop message sequence if status is changed from nil
  # reset sequence in progress and broadcast stop sequence
  def stop_sequence
    if self.sequence_in_progress and self.status != nil
      broadcast_stop_sequence
    end

  end

  #broadcast message sequence stop
  def broadcast_stop_sequence
    self.update(sequence_in_progress: false)
    ActionCable.server.broadcast 'message_sequence',
      booking_id: self.id,html_template: ApplicationController.render(
        partial: 'walk_ins/walk_in',locals: { booking: self }
      )
  end

  def set_customer
    customer = Customer.find_or_create_by(phone: self.phone,restaurant: self.restaurant)
    update(customer: customer)
  end


end
