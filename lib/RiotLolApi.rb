require "/Users/rhuberdeau/projects/rails4/RiotLolApi/lib/RiotLolApi/version"
require "/Users/rhuberdeau/projects/rails4/RiotLolApi/lib/RiotLolApi/basic_client"
require "/Users/rhuberdeau/projects/rails4/RiotLolApi/lib/RiotLolApi/request"
require "/Users/rhuberdeau/projects/rails4/RiotLolApi/lib/RiotLolApi/response"
require "/Users/rhuberdeau/projects/rails4/RiotLolApi/lib/RiotLolApi/champion"
require 'net/http'
require 'json'

module RiotLolApi
  class Error < RuntimeError; end
  #class ArgumentError < StandardError; end

  def self.api_key
  	@api_key
  end

  def self.api_key=(key)
    @api_key ||= key
  end

  def self.protocol
  	@protocol || "https"
  end

  def self.protocol=(protocol)
  	unless ["http", "https"].include?(protocol.to_s)
      raise(ArgumentError, "protocol must be set to either 'http' or 'https'")
    end
    @protocol = protocol.to_s
  end

  def self.host
  	'na.api.pvp.net'
  end
end
