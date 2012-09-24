module ValidationAggregator
  module Helper
    def also_validates(*models)
      validates_with ValidationAggregator::Validation, models: models
    end
  end
end
