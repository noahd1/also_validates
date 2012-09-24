require "active_model"
require "also_validates/version"
require "also_validates/validation"
require "also_validates/helper"

ActiveModel::Validations::HelperMethods.module_eval do
  include AlsoValidates::Helper
end
