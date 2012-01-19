ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../../spec/dummy/config/environment.rb",  __FILE__)
ENV["RAILS_ROOT"] ||= File.dirname(__FILE__) + "../../../spec/dummy"

require 'cucumber/rails'
require 'aruba/cucumber'


Before do
  @aruba_timeout_seconds = 60
end

#require File.expand_path("../../step_definitions/common_steps", __FILE__)
