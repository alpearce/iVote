require "spec_helper"

describe "Voting" do

  it "should work" do

    #To change this template use File | Settings | File Templates.
    visit votes_path
    page.has_content? "Voting"
    page.has_content? "YES votes remain"
    page.has_content? "NO votes remain"
    page.has_content? "Submit"
  end
end