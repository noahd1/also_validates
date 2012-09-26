require "spec_helper"

class MonsterTruckRally
  include ActiveModel::Validations

  attr_accessor :beer, :belly, :truck_count

  validates_presence_of :truck_count
  also_validates :beer, :belly

  def initialize(attrs = {})
    @beer = attrs[:beer]
    @belly = attrs[:belly]
    @truck_count = attrs[:truck_count]
  end
end

class NascarRace
  include ActiveModel::Validations
  attr_accessor :beer, :belly
  also_validates :beer, :allow_nil => true
  also_validates :belly

  def initialize(attrs = {})
    @beer = attrs[:beer]
    @belly = attrs[:belly]
  end
end

class Bar
  include ActiveModel::Validations
  attr_accessor :beers, :name
  validates_presence_of :name

  also_validates :beers

  def initialize(attrs = {})
    @name  = attrs[:name]
    @beers = attrs.fetch :beers, []
  end
end

describe Bar do
  it "validates arrays of other models and errors any objects that don't respond to valid?" do
    ref_array =
    bar = Bar.new beers: [Object.new, Beer.new, Beer.new(malt: [Belly.new])]
    bar.valid?
    expect(bar).to have(6).errors
    expect(bar.errors.full_messages).to include(
      %q(Name can't be blank)
    )
    expect(bar.errors.full_messages).to include(
      %q(Beer[0]: Object can't be validated)
    )
    expect(bar.errors.full_messages).to include(
      %q(Beer[1]: Hops can't be blank)
    )
    expect(bar.errors.full_messages).to include(
      %q(Beer[2]: Hops can't be blank)
    )
    expect(bar.errors.full_messages).to include(
      %q(Beer[1]: Malt can't be blank)
    )
    expect(bar.errors.full_messages).to include(
      %q(Beer[2]: Malt[0]: Button can't be blank)
    )
  end
end

describe MonsterTruckRally do

  it "adds all the errors together from other models" do
     monster  = MonsterTruckRally.new(beer: Beer.new, belly: Belly.new)
     monster.valid?
     expect(monster).to have(4).errors
     expect(monster.errors.full_messages).to include(
        %q(Truck count can't be blank)
      )
      expect(monster.errors.full_messages).to include(
        %q(Beer: Hops can't be blank)
      )
      expect(monster.errors.full_messages).to include(
        %q(Beer: Malt can't be blank)
      )
      expect(monster.errors.full_messages).to include(
        %q(Belly: Button can't be blank)
      )
  end

  it "is valid if all the attributes are valid" do
    beer = Beer.new(hops: true, malt: Belly.new(button: "wat"))
    belly = Belly.new(button: "inny")
    monster  = MonsterTruckRally.new(beer: beer, belly: belly, truck_count: 4)
    expect(monster).to be_valid
  end

  it "complains if the associated model is nil" do
    race = NascarRace.new(beer: Beer.new(hops: true, malt: Belly.new(button: "wat")))
    race.valid?
    expect(race.errors.full_messages).to eq(["Belly can't be blank"])
  end

  it "does not complain if the associated model is allowed to be nil" do
    race = NascarRace.new(belly: Belly.new(button: "outy"))
    race.valid?
    expect(race).to have(:no).errors
  end


end
