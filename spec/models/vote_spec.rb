require 'spec_helper'

describe Vote do
 it "requires a vote" do
  	subject.should_not be_valid
  	subject.vote = 2
  	subject.should be_valid
  end
end
