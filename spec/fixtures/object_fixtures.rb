class Beer
  include ActiveModel::Validations
  attr_accessor :hops
  validates_presence_of :hops

  def initialize(attrs = {})
    @hops = attrs[:hops]
  end
end

class Belly
  include ActiveModel::Validations
  attr_accessor :button
  validates_presence_of :button

  def initialize(attrs = {})
    @button = attrs[:button]
  end
end
