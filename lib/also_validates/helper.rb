module AlsoValidates
  module Helper
    def also_validates(*models)
      validates_with AlsoValidates::Validation, models: models
    end
  end
end
