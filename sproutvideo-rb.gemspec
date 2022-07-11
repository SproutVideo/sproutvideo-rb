Gem::Specification.new do |s|
  s.name = "sproutvideo-rb"
  s.version = "1.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["SproutVideo"]
  s.date = "2022-07-11"
  s.description = "SproutVideo API Client"
  s.email = "support@sproutvideo.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "example/token_upload.rb",
    "lib/sproutvideo.rb",
    "lib/sproutvideo/access_grant.rb",
    "lib/sproutvideo/account.rb",
    "lib/sproutvideo/analytics.rb",
    "lib/sproutvideo/login.rb",
    "lib/sproutvideo/playlist.rb",
    "lib/sproutvideo/resource.rb",
    "lib/sproutvideo/response.rb",
    "lib/sproutvideo/sproutvideo.rb",
    "lib/sproutvideo/tag.rb",
    "lib/sproutvideo/upload_token.rb",
    "lib/sproutvideo/version.rb",
    "lib/sproutvideo/video.rb",
    "lib/sproutvideo/folder.rb",
    "lib/sproutvideo/subtitle.rb",
    "lib/sproutvideo/call_to_action.rb",
    "lib/sproutvideo/live_stream.rb",
    "spec/spec_helper.rb",
    "spec/sproutvideo/access_grant_spec.rb",
    "spec/sproutvideo/account_spec.rb",
    "spec/sproutvideo/analytics_spec.rb",
    "spec/sproutvideo/login_spec.rb",
    "spec/sproutvideo/playlist_spec.rb",
    "spec/sproutvideo/resource_spec.rb",
    "spec/sproutvideo/response_spec.rb",
    "spec/sproutvideo/sproutvideo_spec.rb",
    "spec/sproutvideo/tag_spec.rb",
    "spec/sproutvideo/upload_token_spec.rb",
    "spec/sproutvideo/video_spec.rb",
    "spec/sproutvideo/folder_spec.rb",
    "spec/sproutvideo/subtitle_spec.rb",
    "spec/sproutvideo/call_to_action_spec.rb",
    "spec/sproutvideo/live_stream_spec.rb",
    "spec/sproutvideo_spec.rb",
    "sproutvideo-rb.gemspec"
  ]
  s.homepage = "http://github.com/SproutVideo/sproutvideo-rb"
  s.licenses = ["MIT"]
  s.summary = "SproutVideo API Client"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-client>, [">= 2"])
      s.add_runtime_dependency(%q<json>, ">= 1.8.6", "< 2.7.0")
      s.add_runtime_dependency(%q<multi_json>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, "~> 6.3.1")
    else
      s.add_dependency(%q<rest-client>, ["~> 1.8.0"])
      s.add_dependency(%q<json>, ">= 1.8.6", "< 2.7.0")
      s.add_dependency(%q<multi_json>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, "~> 6.3.1")
    end
  else
    s.add_dependency(%q<rest-client>, [">= 2"])
    s.add_dependency(%q<json>, ">= 1.8.6", "< 2.7.0")
    s.add_dependency(%q<multi_json>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, "~> 6.3.1")
  end
end

