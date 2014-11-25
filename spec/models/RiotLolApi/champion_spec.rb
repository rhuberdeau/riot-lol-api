require 'RiotLolApi/champion'

module RiotLolApi
  describe Champion do 
    it "should return all champions" do
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      response = double
      allow(response).to receive(:to_hash).and_return({"champions"=>[{"id"=>266, "active"=>true, "botEnabled"=>false, "freeToPlay"=>false, "botMmEnabled"=>false, "rankedPlayEnabled"=>true}, {"id"=>103, "active"=>true, "botEnabled"=>false, "freeToPlay"=>false, "botMmEnabled"=>false, "rankedPlayEnabled"=>true}]})
      allow(Request).to receive(:get).with(any_args).and_return(response)
      expect(Champion.all).to eq({"champions"=>[{"id"=>266, "active"=>true, "botEnabled"=>false, "freeToPlay"=>false, "botMmEnabled"=>false, "rankedPlayEnabled"=>true}, {"id"=>103, "active"=>true, "botEnabled"=>false, "freeToPlay"=>false, "botMmEnabled"=>false, "rankedPlayEnabled"=>true}]})
    end

    it "should return the information for one champion" do
      allow(RiotLolApi).to receive(:api_key).with(any_args).and_return('key')
      response = double
      allow(response).to receive(:to_hash).and_return({"id"=>266,"active"=>true,"botEnabled"=>false,"freeToPlay"=>false,"botMmEnabled"=>false,"rankedPlayEnabled"=>true})
      allow(Request).to receive(:get).with('/champion', :version => "/v1.2", :base_path => "/api/lol", :id => 266).and_return(response)
      expect(Champion.find(266)).to eq({"id"=>266,"active"=>true,"botEnabled"=>false,"freeToPlay"=>false,"botMmEnabled"=>false,"rankedPlayEnabled"=>true})
    end
  end
end