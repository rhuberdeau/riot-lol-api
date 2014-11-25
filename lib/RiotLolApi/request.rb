module RiotLolApi
  class Request
  	def self.get(path, parameters ={})
  	  request = Request.new(path, parameters)
  	  Response.new(request.get)
  	end

  	def initialize(resource_path, parameters = {})
  	  parameters = parameters.dup
  	  @region = "/" + (parameters.delete(:region) || 'na')
  	  @version = parameters.delete(:version)
      @id = parameters.delete(:id)
      @resource_path = resource_path
      @base_path = parameters.delete(:base_path)
  	  raise("version is required") if @version.nil?
      raise("base_path is required") if @base_path.nil?
  	  parameters = parameters.merge(:api_key => RiotLolApi.api_key)
  	  @parameters = parameters
    end

    def parameters
      @parameters
    end

    def region
      @region
    end

    def version
      @version
    end

    def base_path
      @base_path
    end

    def resource_path
      @resource_path
    end

    def id
      @id
    end

    def get
      client.get(endpoint_url)
    end

    def endpoint_url
      "#{base_path}#{region}#{version}#{resource_path}/#{id}" + "?api_key=#{parameters[:api_key]}"
    end

    def client 
      @client ||= BasicClient.new
    end
  end
end