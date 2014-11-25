require 'RiotLolApi/response'

module RiotLolApi
  describe Response do
    describe  "an instance of the Response class" do
      it "should be able to decode JSON to a hash" do
      	data = double
      	allow(data).to receive(:body).and_return('{ "foo":"bar" }')
        r = Response.new(data)
        expect(r.to_hash).to eq({'foo' => 'bar'})
      end

      it "should provide the complete raw body" do
        data = double
      	allow(data).to receive(:body).and_return('I am not JSON')
      	r = Response.new(data)

      	expect(r.body).to eq('I am not JSON')
      end

      it "should raise invalid JSON exception if the response is not json" do
        data = double
      	allow(data).to receive(:body).and_return('I am not JSON')
      	allow(data).to receive(:code).and_return(500)
      	r = Response.new(data)

      	expect{r.to_hash}.to raise_error(RiotLolApi::RiotLolApiJSONInvalid)
      end

      it "should raise ExceededRateLimit" do
        data = double
      	allow(data).to receive(:body).and_return("something Rate Limit Exceeded something")
      	allow(data).to receive(:code).and_return(200)
      	r = Response.new(data)

      	expect{r.to_hash}.to raise_error(RiotLolApi::ExceededRateLimit)
      end

      it "should provide the code" do
      	data = double
      	allow(data).to receive(:body).and_return('{ "foo":"bar" }')
      	allow(data).to receive(:code).and_return(200)
      	r = Response.new(data)

        expect(r.code).to eq(200)
      end

      it "should consider a code of 2xx to be successful" do
        data = double
        allow(data).to receive(:code).and_return(200)
        r = Response.new(data)
        expect(r).to be_success

        allow(data).to receive(:code).and_return(201)
        r = Response.new(data)
        expect(r).to be_success
      end

      it "should consider a code of 4xx to be unsuccessful" do
        data = double
        allow(data).to receive(:code).and_return(404)
        r = Response.new(data)
        expect(r).to_not be_success
      end

      it "should consider a code of 5xx to be unsuccessful" do
        data = double
        allow(data).to receive(:code).and_return(500)
        r = Response.new(data)
        expect(r).to_not be_success
      end
    end
  end
end