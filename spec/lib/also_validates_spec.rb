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

describe MonsterTruckRally do

  it "adds all the errors together from other models" do
     monster  = MonsterTruckRally.new(beer: Beer.new, belly: Belly.new)
     monster.valid?
     expect(monster).to have(3).errors
     expect(monster.errors.full_messages).to include(
        %q(Truck count can't be blank)
      )
      expect(monster.errors.full_messages).to include(
        %q(Hops can't be blank)
      )
      expect(monster.errors.full_messages).to include(
        %q(Button can't be blank)
      )
  end

  it "is valid if all the attributes are valid" do
    beer = Beer.new(hops: true)
    belly = Belly.new(button: "inny")
    monster  = MonsterTruckRally.new(beer: beer, belly: belly, truck_count: 4)
    expect(monster).to be_valid
  end

  it "complains if the associated model is nil" do
    race = NascarRace.new(beer: Beer.new(hops: true))
    race.valid?
    expect(race.errors.full_messages).to eq(["Belly can't be blank"])
  end

  it "does not complain if the associated model is allowed to be nil" do
    race = NascarRace.new(belly: Belly.new(button: "outy"))
    race.valid?
    expect(race).to have(:no).errors
  end


end
