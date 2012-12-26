class ElectionsController < ApplicationController
  before_filter :require_login
  
  def election
    @candidates = Candidate.all
  end
  
  def vote
    @candidates = Candidate.all
    ballot = params[:ballot]
    logger.info "Starting Yes Val"
    yes_validation = ballot.select{|k, v|
      v == "0"
      }
      logger.info "Yes votes = " + yes_validation.to_s
      if yes_validation.size > 1
        respond_to do |format|
          format.html {render :text => "You may not have more than one first choice. You had" + yes_validation.size.to_s, :status => 406}
          format.json {render :text => "You may not have more than one first choice vote.", :status => 403}
        end
        return
      end
      abs_validation = ballot.select{|k, v|
        v == "1"
        }
        logger.info "Abs votes = " + abs_validation.to_s
        if abs_validation.size > 1
          respond_to do |format|
            format.html {render :text => "You may not have more than one second choice. You had" + abs_validation.size.to_s, :status => 406}
            format.json {render :text => "You may not have more than one second choice vote.", :status => 403}
          end
          return
        end
        no_validation = ballot.select{|k, v|
          v == "2"
          }
          logger.info "No votes = " + no_validation.to_s
          if no_validation.size > 1
            respond_to do |format|
              format.html {render :text => "You may not have more than one third choice. You had" + no_validation.size.to_s, :status => 406}
              format.json {render :text => "You may not have more than one third choice vote.", :status => 403}
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
  
end
