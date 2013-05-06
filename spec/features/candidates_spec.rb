require "spec_helper"

describe "Listing Candidates" do

  it "add candidate" do

    visit candidates_path
    page.has_content? "Listing Candidates"
    visit new_candidate_path
    page.has_content? "Candidate was successfully created."

  end
end
