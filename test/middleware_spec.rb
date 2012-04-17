require "relevance_portfolio_iteration_switcher"
require "test/unit"

class TestMiddleware < Test::Unit::TestCase

  def test_url_building_with_http_auth_encodes_the_parts
    middleware = RelevancePortfolioIterationSwitcher::Middleware.new(:rack_app,  :current_iteration => 1,
                                                               :iterations => { 1 => "example.thinkrelevance.com" },
                                                               :http_auth => { :username => "joe@example.com", 
                                                                               :password => "password" })
    assert_equal("joe%40example.com:password@example.thinkrelevance.com",
                  middleware.build_url("example.thinkrelevance.com"))
  end

  def test_url_building_with_http_auth_keeps_the_protocol
    middleware = RelevancePortfolioIterationSwitcher::Middleware.new(:rack_app,  :current_iteration => 1,
                                                               :iterations => { 1 => "https://example.thinkrelevance.com" },
                                                               :http_auth => { :username => "joe@example.com", 
                                                                               :password => "password" })
    assert_equal("https://joe%40example.com:password@example.thinkrelevance.com",
                  middleware.build_url("https://example.thinkrelevance.com"))
  end

  def test_url_building_with_https_but_no_http_auth
    middleware = RelevancePortfolioIterationSwitcher::Middleware.new(:rack_app,  :current_iteration => 1,
                                                               :iterations => { 1 => "https://example.thinkrelevance.com" })
    assert_equal("https://example.thinkrelevance.com",
                  middleware.build_url("https://example.thinkrelevance.com"))
  end
end
