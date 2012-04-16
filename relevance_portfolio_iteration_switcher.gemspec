# -*- encoding: utf-8 -*-
require File.expand_path('../lib/relevance_portfolio_iteration_switcher/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rob Sanheim and Jared Pace"]
  gem.email         = ["pair@thinkrelevance.com"]
  gem.description   = %q{Iteration switcher for projects in our sales portfolio}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "relevance_portfolio_iteration_switcher"
  gem.require_paths = ["lib"]
  gem.version       = RelevancePortfolioIterationSwitcher::VERSION
end
