class Beer
  include ActiveModel::Validations
  attr_accessor :hops, :malt
  validates_presence_of :hops
  also_validates :malt

  def initialize(attrs = {})
    @hops, @malt = attrs.values_at(:hops, :malt)
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
