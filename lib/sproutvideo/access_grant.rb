module Sproutvideo
	class AccessGrant < Resource
		
		def self.create(options={})
			post("/access_grants", options)
		end
		
		def self.list(options={})
			params = {
				:page => options.delete(:page) || 1,
				:per_page => options.delete(:per_page) || 25
			}
			params = params.merge(options)
			get("/access_grants", params)
		end

		def self.details(access_grant_id, options={})
			get("/access_grants/#{access_grant_id}", options)
		end

		def self.update(access_grant_id, options={})
			put("/access_grants/#{access_grant_id}", options)
		end

		def self.destroy(access_grant_id, options={})
			delete("/access_grants/#{access_grant_id}", options)
		end

		def self.bulk_create(access_grants)
			post("/access_grants/bulk", access_grants)
		end

	end
end