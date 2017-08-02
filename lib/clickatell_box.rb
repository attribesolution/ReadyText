require 'rest_client'

class ClickatellBox
  def initialize
    @headers = {"Content-Type"=> "application/json","Accept"=> "application/json","Authorization"=> ENV['CLICKATELL_API_ID']}
    @url = "https://platform.clickatell.com/messages"
  end

  ######################################
  ## send message method
  ## @params:
  ## recipents = ["+923314946924"]
  ## content = "test message"
  ######################################
  def send_sms recipents,content
    begin
      payload = {content: content ,to: recipents}.to_json
      response = RestClient.post(@url, payload, @headers)
      response = {error: false,data: response}
    rescue Exception => e
      response = {error: true, message: e.message}
    end
    response
  end
end