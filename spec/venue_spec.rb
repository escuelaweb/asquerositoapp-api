require 'spec_helper'

describe Venue do
  
  before(:each) do
    DatabaseCleaner.clean
  end

  #validates_presence_of :name, :coordinates, :description
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:coordinates) }

end