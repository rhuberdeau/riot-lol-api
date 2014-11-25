
module RiotLolApi
	class RiotLolApiJSONInvalid < StandardError; end
	class ExceededRateLimit < StandardError; end

  attr_reader :code, :data
  def initialize(args)
    @code = args[:code]
    @data = args[:data]
  end

  class Response

  	def initialize(raw_response)
      @raw_response = raw_response
    end

    def body
      @raw_response.body
    end

    def code
      @raw_response.code
    end

  	def to_hash
  	  validate!
      @hash ||= json
    end

    def success?
      (200..300).include?(code)
    end

    private

    def data
      @raw_response.body
    end

    def json
      @hash ||= JSON.parse(data)
    end

    def validate!
      raise ExceededRateLimit         if exceeded_rate_limit?
      raise RiotLolApiJSONInvalid.new({:code => code, :data => data}) unless valid_json?
      true
    end

    def valid_json?
      json
      return true
    rescue JSON::ParserError
      return false
    end

    def exceeded_rate_limit?
      data =~ /Rate Limit Exceeded/
    end
  end
end