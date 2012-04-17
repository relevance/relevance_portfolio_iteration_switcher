# RelevancePortfolioIterationSwitcher

Simple switcher for navigating between iterations of projects in our
portfolio.

This is probably not very useful for general use outside of Relevance,
though more power to you if it is helpful for you.

## Installation

Add this line to your application's Gemfile:

    gem 'relevance_portfolio_iteration_switcher'

Add this to your application.rb(Rails 3) or environment.rb(Rails 2)
file.

    config.middleware.use 'RelevancePortfolioIterationSwitcher::Middleware',
      :current_iteration => 42,
      :iterations => {
        1 => 'http://iteration-1.example.com',
        ...
        42 => 'http://iteration-42.example.com'
      }
      # Optional HTTP Auth credentials
      # Must be the same for all urls
      :http_auth => {
        :username => 'john.doe',
        :password => 'password'
      }
