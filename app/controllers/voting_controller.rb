class VotingController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  
  def require_admin
    unless current_user.admin?
      redirect_to "/"
    end
  end
  
  def index
    @candidates = Candidate.all
    
  end

  def vote
   
    @candidates = Candidate.all
    ballot = params[:ballot]
    yes_validation = ballot.select{|k, v|
      v == "0"
      }
      if yes_validation.size > 15
        respond_to do |format|
          format.html {render :text => "You may not have more than 15 YES votes. You had" + yes_validation.size.to_s, :status => 406}
          format.json {render :text => "You may not have more than 15 YES votes.", :status => 403}
        end
        return
      end
    user = params[:user_id]
    @voted_already = UserVoted.find_by_user_id(user.to_i)
    if @voted_already.nil?
      ballot.each {|candidate_id, vote|
        candidate = Candidate.find(candidate_id.to_i)
        if vote == "0"
          candidate.yes += 1
        elsif vote == "1"
          candidate.abstain += 1
        elsif vote == "2"
          candidate.no += 1
        end
        candidate.save
        }
        @candidates.each{|candidate|
          logger.info candidate.name + " : " + candidate.yes.to_s
        
          }
      u = UserVoted.new
      u.user_id = user.to_i
      u.voted = true
      u.save
      render :js => "window.location = '/voting/confirm'"
    else
      respond_to do |format|
        format.html {render :text => "Sorry. You already voted.", :status => 403}
        format.json {render :text => "Sorry. You already voted.", :status => 403}
      end
      
      logger.info "USER ALREADY VOTED"
    end
    
  end

  def confirm
  end
end
