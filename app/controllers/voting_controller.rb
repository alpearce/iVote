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
    if ballot.nil?  
          respond_to do |format|
          format.html {render :text => "You can't vote until you add some candidates!", :status => 406}
          format.json {render :text => "You can't vote until you add some candidates!", :status => 403}
        end
        return
      end
    yes_validation = ballot.select{|k, v|
      v == "0"
      }
    abstains = ballot.select{|k, v|
      v == "1"}
      #YOU ALSO HAVE TO CHANGE THESE NUMBERS WHEN CHANGING YES VOTES
      if yes_validation.size > 1
        respond_to do |format|
          format.html {render :text => "You may not have more than 1 YES votes. You had" + yes_validation.size.to_s, :status => 406}
          format.json {render :text => "You may not have more than 1 YES votes.", :status => 403}
        end
        return
      end
      #for closed rush you can abstain however much you want
      if abstains.size > 100000000000
        respond_to do |format|
          format.html {render :text => "You abstained too many times", :status => 406}
          format.json {render :text => "You abstained too many times", :status => 403}
        end
        return
      end
    user = params[:user_id]
    @voted_already = UserVoted.find_by_user_id(user.to_i)
    if @voted_already.nil? || @voted_already.voted == false
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
      puts "In the controller voting_controller: vote action"
      puts UserVoted.all
      
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
        if yes_validation.size > 11
          respond_to do |format|
            format.html {render :text => "You may not have more than 11 YES votes. You had" + yes_validation.size.to_s, :status => 406}
            format.json {render :text => "You may not have more than 11 YES votes.", :status => 403}
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
