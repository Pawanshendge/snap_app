# spec/support/api_helper.rb
module ApiHelper
  module JsonHelpers
    def json_response
      @json ||= JSON.parse(response.body, symbolize_names: true)
      puts @json
      @json
    end
  end
end
