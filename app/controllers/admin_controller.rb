class AdminController < ApplicationController
  def tally
    @candidates = Candidate.all
    users_who_voted = UserVoted.all
    @number_of_votes = users_who_voted.size
    @candidates.sort! {|x, y| y.yes <=> x.yes}
  end
  
  def advance
    @vote_count = UserVoted.all.count
    @candidates = Candidate.all
    @candidates.each do |candidate|
      if candidate.yes >= 0.80 * @vote_count || candidate.no >= 0.15 * @vote_count
        candidate.delete
      end
    end
    UserVoted.all.each do |uv|
      uv.delete
    end
    redirect_to "/candidates/index"
  end
  
  
  
end
