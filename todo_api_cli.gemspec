Gem::Specification.new do |s|
  s.name = %q{todo_api_cli}
  s.version = "0.0.2"
  s.date = %q{2018-10-13}
  s.summary = %q{CLI to interact with the todo app api}
  s.files = [
    "lib/todo_api_cli.rb"
  ]
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.authors = ['Eduardo Poleo']
  s.executables = ['create_user']

  s.add_development_dependency "bundler", "~> 1.15"
  s.add_development_dependency "pry", "~> 0.10.4"
  s.add_dependency "faraday"
  s.add_dependency "faraday_middleware"
end