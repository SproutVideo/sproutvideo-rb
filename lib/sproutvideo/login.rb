module Sproutvideo
	class Login < Resource
		
		def self.create(options={})
			post("/logins", options)
		end
		
		def self.list(options={})
			params = {
				:page => options.delete(:page) || 1,
				:per_page => options.delete(:per_page) || 25
			}
			params = params.merge(options)
			get("/logins", params)
		end

		def self.details(login_id, options={})
			get("/logins/#{login_id}", options)
		end

		def self.update(login_id, options={})
			put("/logins/#{login_id}", options)
		end

		def self.destroy(login_id, options={})
			delete("/logins/#{login_id}", options)
		end

	end
end