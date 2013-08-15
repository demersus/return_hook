$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "return_hook/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "return_hook"
  s.version     = ReturnHook::VERSION
  s.authors     = ["Nik Petersen"]
  s.email       = ["demersus@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "adds some convenience helpers and methods for hooking the redirect in a controller"
  s.description = "adds some convenience helpers and methods for hooking the redirect in a controller"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]

  s.add_dependency "rails"

end
