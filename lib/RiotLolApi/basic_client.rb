module RiotLolApi
  class BasicClient

  	def initialize
      @host = RiotLolApi.host
    end


  	def client # :nodoc:
      if @client
        return @client
      else
        @client = Net::HTTP.new(@host, RiotLolApi.protocol == "http" ? 80 : 443)
        @client.use_ssl = true if RiotLolApi.protocol == "https"
        return @client
      end
    end

    def get(endpoint)
      client.get(endpoint)
    end
  end
end