window.App ||= {}
class App.Reservations extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    App.applyDatePicker($('.datepicker'))
    App.applyTimePicker($('.timepicker'))
    App.applyIntlInput($("#reservation_phone"))
    
    $reservationForm = $("#reservation_form")

    $.validator.addMethod 'validTimeCheck', ((time, element) ->
      date = $(".datepicker").val()
      time = new Date("#{date} #{time}")
      time > new Date()
    ), 'Please enter a valid future time.'

    $(document).on "click",".reset_form_btn", (event) ->
      event.preventDefault()
      App.resetForm($reservationForm[0])
      
    $reservationForm.submit (event) ->
      $($reservationForm).validate
        focusInvalid: false
        errorClass: 'invalid'
        validClass: 'valid'
        invalidHandler: (form, validator) ->
          return  unless validator.numberOfInvalids()
          $("html, body").animate
            scrollTop: $(validator.errorList[0].element).offset().top
          , 200

        errorPlacement: (error, element) ->
          error.insertAfter $(element)

        rules:
          "reservation[booking_date]":
            required: true
          "reservation[booking_time]":
            required: true
            validTimeCheck: true
          "reservation[party_name]":
            required: true
          "reservation[size]":
            required: true
            number: true
          "reservation[phone]":
            required: true
            phoneCheck: true
      if $($reservationForm).valid()
        $(".submit_btn").attr("disabled",true)
        return true
      
      # Prevent the form from being submitted:
      false
    
    initBookingTime = ->
      # current time + 1 hour
      time = new Date().getTime() + 60*60*1000
      time = new Date(time)
      hours = parseInt(time.getHours())
      minutes = parseInt(time.getMinutes())
      seconds = parseInt(time.getSeconds())
      if hours < 10
        hours = "0#{hours}"
      if minutes < 10
        minutes = "0#{minutes}"
      if seconds < 10
        seconds = "0#{seconds}"
      time = "#{hours}:#{minutes}:#{seconds}"
      $("#reservation_booking_time").val(time)

    initBookingTime()
    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return

  # update form validation
  updateReservationFormValidator: ->
    $updateReservationForm = $("#reservation_update_form")

    $.validator.addMethod 'validUpdateTimeCheck', ((time, element) ->
      date = $("#edit_reservation_datepicker").val()
      time = new Date("#{date} #{time}")
      time > new Date()
    ), 'Please enter a valid future time.'
    
    $updateReservationForm.submit (event) ->
      $($updateReservationForm).validate
        focusInvalid: false
        errorClass: 'invalid'
        validClass: 'valid'
        errorPlacement: (error, element) ->
          error.insertAfter $(element)

        rules:
          "reservation[booking_date]":
            required: true
          "reservation[booking_time]":
            required: true
            validUpdateTimeCheck: true
          "reservation[party_name]":
            required: true
          "reservation[size]":
            required: true
            number: true
          "reservation[phone]":
            required: true
            phoneCheck: true
      if $($updateReservationForm).valid()
        return true
      # Prevent the form from being submitted:
      false
    return

  import: =>
    $importCsvForm = $("#import_csv_form")
    $importCsvForm.submit (event) ->
      $($importCsvForm).validate
        focusInvalid: false
        errorClass: 'text-danger'
        validClass: 'valid'
        errorPlacement: (error, element) ->
          error.insertAfter $(element)

        rules:
          "csv_file":
            required: true
        messages:
          "csv_file":
            required: "CSV file is required."
      if $($importCsvForm).valid()
        return true
      # Prevent the form from being submitted:
      false
    return

