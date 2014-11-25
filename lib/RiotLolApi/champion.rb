module RiotLolApi
  class Champion
  	def self.all 
  	  Request.get('/champion', :version => Champion.version, :base_path => Champion.base_path).to_hash
  	end

  	def self.find(id)
  	  Request.get('/champion', :version => Champion.version, :base_path => Champion.base_path, :id => id).to_hash
  	end

  	def self.version
  	  "/v1.2"
  	end

  	def self.base_path
  	  "/api/lol"
  	end
  end
end