require 'RiotLolApi/request'

module RiotLolApi
  describe Request do 
  	it "should be able to retrieve a response" do
  	  http_response = double
  	  response      = double

  	  allow(Response).to receive(:new).with(http_response).and_return(response)
  	  request = double
  	  allow(request).to receive(:get).with(any_args).and_return(http_response)
  	  allow(Request).to receive(:new).with('/user', :one => 'two').and_return(request)
  	  expect(Request.get('/user', :one => 'two')).to eq(response)
  	end
  end

  describe  "An instance of the Request class" do
  	it "requires a version" do
  	  allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
  	  expect{Request.new('/user', {:limit => 1, :base_path => "/api/lol" })}.to raise_error('version is required')
  	end

    it "requires a base_path" do
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      expect{Request.new('/user', {:limit => 1, :version => 1.2 })}.to raise_error('base_path is required')
    end
  	
    it "appends the api_key to the parameters" do 
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      r = Request.new('/user', {:limit => 1, :version => 1.2, :base_path => "/api/lol"})
      expect(r.parameters).to eq(:limit => 1, :api_key => 'key')
    end

    it "has a default region of na" do
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      r = Request.new('/user', {:limit => 1, :version => 1.2, :base_path => "/api/lol"})
      expect(r.region).to eq('/na')
      expect(r.parameters).to eq(:limit => 1, :api_key => 'key')
    end

    it "can be assigned a region" do
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      r = Request.new('/user', {:limit => 1, :region => 'foo', :version => 1.2, :base_path => "/api/lol"})
      expect(r.region).to eq('/foo')
      expect(r.parameters).to eq(:limit => 1, :api_key => 'key')
    end

    it "can be assigned a version" do
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      r = Request.new('/user', {:limit => 1, :version => 1.2, :base_path => "/api/lol"})
      expect(r.version).to eq(1.2)
      expect(r.parameters).to eq(:limit => 1, :api_key => 'key')
    end

    it "can be assigned an id" do
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      r = Request.new('/user', {:limit => 1, :version => 1.2, :base_path => "/api/lol", :id => '14'})
      expect(r.id).to eq('14')
    end

    it "has an endpoint_url" do
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      r = Request.new('/champion', {:version => "/v1.2", :base_path => "/api/lol", :id => '14'})
      expect(r.endpoint_url).to eq("/api/lol/na/v1.2/champion/14?api_key=key")
    end
  end
end