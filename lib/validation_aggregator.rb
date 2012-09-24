require "active_model"
require "validation_aggregator/version"
require "validation_aggregator/validation"
require "validation_aggregator/helper"

ActiveModel::Validations::HelperMethods.module_eval do
  include ValidationAggregator::Helper
end
