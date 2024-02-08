require "rubygems"
require "net/https"
require "uri"
require "json"

module BxBlockSms
  module Providers
    class TextLocal
      class << self
        def send_sms(full_phone_number, text_content)
          send_text_local_api(full_phone_number, text_content)
        end

        private

        def send_text_local_api(full_phone_number, text_content)
          uri = URI.parse(textlocal_message_url)
          http = Net::HTTP.start(uri.host, uri.port)
          request = Net::HTTP::Get.new(uri.request_uri)
           
          res = Net::HTTP.post_form(uri, 'apikey' => ENV["TEXT_LOCAL_API"], 'message' => text_content, 'sender' => 'WTBOOK', 'numbers' => full_phone_number)
          response = JSON.parse(res.body)
        end

        def textlocal_message_url
          'https://api.textlocal.in/send/'
        end
      end
    end
  end
end
