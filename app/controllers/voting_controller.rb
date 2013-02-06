class VotingController < ApplicationController
  before_filter :require_login
 
  
  def index
    @candidates = Candidate.all.shuffle!
    
  end
  
  def election
    @candidates = Candidate.all.shuffle!
  end

  def vote
    @candidates = Candidate.all
    ballot = params[:ballot]
    yes_validation = ballot.select{|k, v|
      v == "0"
      }
    abstains = ballot.select{|k, v|
      v == "1"}
      if yes_validation.size > 8
        respond_to do |format|
          format.html {render :text => "You may not have more than 15 YES votes. You had" + yes_validation.size.to_s, :status => 406}
          format.json {render :text => "You may not have more than 15 YES votes.", :status => 403}
        end
        return
      end
      if abstains.size > 12
        respond_to do |format|
          format.html {render :text => "You abstained too many times", :status => 406}
          format.json {render :text => "You abstained too many times", :status => 403}
        end
        return
      end
    user = params[:user_id]
    @voted_already = UserVoted.find_by_user_id(user.to_i)
    if @voted_already.nil?
      ballotVote = Ballot.new
      ballotVote.votes = params[:ballot]
      ballotVote.save
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
  
  
  def quickpick
    @candidates = Candidate.all.shuffle!
    
  end
  
  def quickvote
     @candidates = Candidate.all
      ballot = params[:ballot]
      yes_validation = ballot.select{|k, v|
        v == "0"
        }
        if yes_validation.size > 7
          respond_to do |format|
            format.html {render :text => "You may not have more than 7 YES votes. You had" + yes_validation.size.to_s, :status => 406}
            format.json {render :text => "You may not have more than 7 YES votes.", :status => 403}
          end
          return
        end
      user = params[:user_id]
      @voted_already = UserVoted.find_by_user_id(user.to_i)
      if @voted_already.nil?
        ballotVote = Ballot.new
        ballotVote.votes = ballot
        ballotVote.save
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
