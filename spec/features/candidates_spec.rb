require "spec_helper"

describe "Listing Candidates" do

  it "add candidate" do

    visit candidates_path
    page.has_content? "Listing Candidates"
    click_link 'New Candidate'
    fill_in "Name", with: "Lily"
    click_button "Create Candidate"
    page.has_content? "Candidate was successfully created."

  end
end