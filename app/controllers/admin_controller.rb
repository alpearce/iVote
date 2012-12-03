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
    @candidates = Candidate.all
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
        
        #candidate.save
        }
          
          
    end
    users_who_voted = UserVoted.all
    @number_of_votes = users_who_voted.size
    @candidates.sort! {|x, y| y.yes <=> x.yes}
  end
  
  def irv_tally
    @ballots = Ballot.all
    @candidates = Candidate.all
    @candidates.each do |c|
      c.yes = 0
      c.save
    end
    @ballots.each do |ballot|
      ballot.votes.each {|candidate_id, vote|
        candidate = @candidates.select{|s| s.id == candidate_id.to_i}.first
        if vote == "0"
          candidate.yes += 1
        end
        
        }
      end
      total_votes = UserVoted.all
      @vote_number = total_votes.size
      @candidates.sort! {|x, y| y.yes <=> x.yes}
      top_vote = @candidates[0]
      if top_vote.yes > 0.5 * @vote_number
        @outcome_1 = ""
        @candidates.each do |c|
          @outcome_1 += c.name + ": " + c.yes.to_s + "(" + number_to_percentage((c.yes / @vote_number)).to_s + ")m"
        end
        @outcome_1 += top_vote.name + " wins."
      else
        bottom_vote = @candidates.last
        @outcome_1 = ""
        @candidates.each do |c|
          @outcome_1 += c.name + ": " + c.yes.to_s + "(" + number_to_percentage((c.yes / @vote_number)).to_s + "), "
        end
        @candidates.each do |c|
          c.yes = 0
          c.save
        end
        @ballots.each do |ballot|
          if ballot.votes[bottom_vote.id] == "0"
            ballot.votes[bottom_vote.id] = nil
            one_key = ballot.votes.select{|k, v| v = "1"}.keys.first
            ballot.votes[one_key] = "0"
            two_key = ballot.votes.select{|k,v| v = "2'"}.keys.first
            ballot.votes[two_key] = "1"
          end
        end
        @ballots.each do |ballot|
          ballot.votes.each{|candidate_id, vote|
            candidate = @candidates.select{|s| s.id == candidate_id.to_i}.first
            if vote == 0
              candidate.yes += 1
            end
            }
            
          @candidates.sort!{|x, y| y.yes <=> x.yes}
          top_vote = @candidates[0]
          @outcome_2 = ""
          @candidates.each do |c|
            @outcome_2 += c.name + ": " + c.yes.to_s + "(" + number_to_percentage((c.yes / @vote_number)).to_s + ")"
          end
      end
    end
  end
  
  def advance
    @vote_count = UserVoted.all.count
    @candidates = Candidate.all
    @candidates.each do |candidate|
      if candidate.yes >= 39 || candidate.no >= 7 * @vote_count
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
