require 'spec_helper'

describe Candidate do
  it "requires a name" do
  	subject.should_not be_valid
  	subject.name = "Bob"
  	subject.should be_valid
  end
end
