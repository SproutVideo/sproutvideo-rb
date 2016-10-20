module Sproutvideo
  class Account < Resource

    def self.details
      get('/account')
    end

    def self.update(options={})
      put('/account', options)
    end

  end
end
