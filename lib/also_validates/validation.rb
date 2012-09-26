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
          validate_instance record, model, model_instance
        end
      end
    end

    def validate_instance record, field, instance, index = -1
      if instance.respond_to?(:each)
        instance.each_with_index do |inst, i|
          validate_instance record, field, inst, i
        end
      elsif instance.respond_to?(:valid?)
        return if instance.valid?
        instance.errors.full_messages.each do |error_message|
          record.errors.add :base, prefix_error(error_message, field, index)
        end
      else
        record.errors.add :base,  prefix_error("#{instance.class.name.humanize} can't be validated", field, index)
      end
    end

    def prefix_error error, field, index
      if index.succ > 0
        field.to_s.classify.humanize + "[#{index}]: " + error
      else
        field.to_s.classify.humanize + ": " + error
      end
    end
  end

end
