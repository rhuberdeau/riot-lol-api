require 'RiotLolApi'

describe RiotLolApi do
  it "should be able to set and retrieve the api key" do
    RiotLolApi.api_key = 'key'
    expect(RiotLolApi.api_key).to eq('key')
  end

  it "should use the https protocol by default" do
  	expect(RiotLolApi.protocol).to eq("https")
  end

  it "should be able to set the protocol to a valid value" do
  	RiotLolApi.protocol = 'http'
  	expect(RiotLolApi.protocol).to eq('http')
  end

  it "should raise an exception when an invalid protocol is set" do
    expect{RiotLolApi.protocol = "invalid"}.to raise_error(ArgumentError, "protocol must be set to either 'http' or 'https'")
  end

  it "should know the host" do
    expect(RiotLolApi.host).to eq("na.api.pvp.net")
  end
end