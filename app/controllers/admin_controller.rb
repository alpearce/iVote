class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  
  def require_admin
    unless current_user.admin?
      redirect_to "/"
    end
  end
  
  def tally
    @ballots = Ballot.all
    @candidates = Candidate.all
    @candidates.each do |c|
      c.yes = 0
      c.no = 0
      c.abstain = 0
      c.save
    end
    @ballots.each do |ballot|
      ballot.votes.each {|candidate_id, vote|
        candidate = @candidates.select{|s| s.id == candidate_id.to_i}.first
        #candidate = Candidate.find(candidate_id.to_i)
        if vote == "0"
          candidate.yes += 1
        elsif vote == "1"
          candidate.abstain += 1
        elsif vote == "2"
          candidate.no += 1
        end
        }
          candidate.save
          
    end
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
      else
        candidate.yes = 0
        candidate.no = 0
        candidate.abstain = 0
        candidate.save
      end
      
    end
    UserVoted.all.each do |uv|
      uv.delete
    end
    Ballot.all.each do |ballot|
      ballot.delete
    end
    redirect_to "/candidates/index"
  end
  
  
  def wipe
    @candidates = Candidate.all
    @candidates.each do |candidate|
      candidate.yes = 0
      candidate.no= 0
      candidate.abstain = 0
      candidate.save
    end
    UserVoted.all.each do |uv|
      uv.delete
    end
    Ballot.all.each do |ballot|
      ballot.delete
    end
    redirect_to "/admin/tally"
  end
  
  
end
