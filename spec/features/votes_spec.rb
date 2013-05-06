require "spec_helper"

describe "Voting" do

  it "should submit" do

    #To change this template use File | Settings | File Templates.
    visit votes_path
    page.has_content? "Voting"
    page.has_content "YES votes remain"
    click_button "Submit"
    page.has_content "Hey Thanks for Voting!"
  end
end