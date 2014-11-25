require 'RiotLolApi/basic_client'

module RiotLolApi
  describe BasicClient do 
  	it "should be able to contruct a client" do
  	  allow(RiotLolApi).to receive(:host).and_return('example.com')
  	  allow(RiotLolApi).to receive(:protocol).and_return('http')
  	  allow(Net::HTTP).to receive(:new).with('example.com', 80).and_return('client')
  	  client = BasicClient.new

  	  expect(client.client).to eq('client')
  	end

  	it "should be able to perform a GET request" do
      http_client = double
      allow(http_client).to receive(:get).with(any_args).and_return('response')

      client = BasicClient.new
      allow(client).to receive(:client).and_return(http_client)

      expect(client.get('endpoint')).to eq('response')
  	end
  end
end