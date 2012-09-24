module AlsoValidates

  class Validation < ActiveModel::Validator
    def initialize(args)
      options = args[:models].extract_options!
      @options = options.merge(:models => args[:models])
    end

    def validate(record)
      options[:models].each do |model|
        model_instance = record.send(model)
        next if options[:allow_nil] && model_instance.nil?
        if !options[:allow_nil] && model_instance.nil?
          record.errors.add(:base, model.to_s.classify.humanize + " can't be blank")
        else
          unless model_instance.valid?
            model_instance.errors.full_messages.each do |error_message|
              record.errors.add(:base, error_message)
            end
          end
        end
      end
    end

  end

end
