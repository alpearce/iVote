class VotingController < ApplicationController
  def index
    @candidates = Candidate.all
    
  end

  def vote
  end

  def confirm
  end
end
