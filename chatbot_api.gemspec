$:.push File.expand_path('../lib', __FILE__)
require 'chatbot_api/version'

Gem::Specification.new do |s|
  s.name        = "chatbot_api"
  s.version     = ChatbotApi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Verdi"]
  s.email       = ["michael.v.verdi@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A wrapper for chatbot service}
  s.description = %q{easily create new messages and chatrooms}

  s.add_development_dependency "rspec"
  s.add_development_dependency "faraday"

  s.rubyforge_project = "chatbot_api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end