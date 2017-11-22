require 'rest_client'

class UfoneSmsBox
  def initialize
    @url = "http://bsms.ufone.com/bsms_app5/sendapi-0.3.jsp"
  end

  ######################################
  ## send message method
  ## @params:
  ## recipents = ["+923314946924"]
  ## content = "test message"
  ######################################
  def send_sms recipents,content
    begin
      payload = {id: ENV['UFONE_BSMS_API_ID'],
        message: content,
        shortcode: "B-SMS",
        lang:"English",
        password: ENV['UFONE_BSMS_API_PASSWORD'],
        messagetype: "Transactional"
      }
      messages = []
      recipents.each do |recipent|
        payload[:mobilenum] = recipent.split('+').last
        response = RestClient.post(@url,payload)
        response = parse_response(response,recipent)
        messages << response
      end
      response = {error: false,data: {messages: messages}.to_json}
    rescue Exception => e
      response = {error: true, message: e.message}
    end
    response
  end

  private
    def parse_response response,recipent
      #<response_to_browser><response_id>0</response_id><response_text>Successful:13239674</response_text></response_to_browser>
      response = Hash.from_xml(response)
      response = response['response_to_browser']
      if response['response_id'].to_i == 0
        # successfull
        # parse msg id from response_text
        msg_id = response['response_text'].split(":")[1]
        response = {error: false,apiMessageId: msg_id,to: recipent}
      else
        response = {error: true,message: response['response_text']}
      end
      response
    end
end