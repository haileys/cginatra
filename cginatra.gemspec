require_relative "lib/cginatra/version"

Gem::Specification.new do |s|
  s.name = "cginatra"
  s.version = CGInatra::VERSION
  s.summary = "Friendly CGI library for Ruby"
  s.description = "A replacement CGI library for Ruby, with a friendly and more familiar API."
  s.homepage = "https://github.com/charliesome/cginatra"
  s.license = "MIT"

  s.author = "Charlie Somerville"
  s.email = "charlie@charliesomerville.com"

  s.add_dependency "rack", "1.5.2"
end
