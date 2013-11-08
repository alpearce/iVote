class UsersnewController < ApplicationController


   def require_admin
     unless current_user.admin?
       logger.info "tried to access restricted area"
       redirect_to "/"
     end
   end
  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = Usersnew.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usersnew }
    end
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
    @usernew = Usersnew.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usernew }
    end
  end

  # GET /candidates/new
  # GET /candidates/new.json
  def new
    @usernew = Usersnew.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usernew }
    end
  end



  # POST /candidates
  # POST /candidates.json
  def create
    @usernew = Usersnew.new(params[:usernew])
    usernew.admin = false;
    respond_to do |format|
      if @usernew.save
        format.html { redirect_to @usernew, notice: 'User was successfully created.' }
        format.json { render json: @usernew, status: :created, location: @usernew }
      else
        format.html { render action: "new" }
        format.json { render json: @usernew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /candidates/1
  # PUT /candidates/1.json
  def update
    @candidate = Usersnew.find(params[:id])

    respond_to do |format|
      if @candidate.update_attributes(params[:usernew])
        format.html { redirect_to @usernew, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usernew.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @usersnew = Usersnew.all
  end

  def admin
   @usernew = Usersnew.find_by_id(params[:id])
   @usernew.admin = true
   @usernew.save   
   flash[:notice] = "Superpowers granted" 
   redirect_to "/users"
  end

  def unadmin
   @usernew = Usersnew.find_by_id(params[:id])
   @usernew.admin = false
   @usernew.save    
   redirect_to "/users", notice: "Superpowers revoked"
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @usernew = Usersnew.find(params[:id])
    @usernew.destroy

    respond_to do |format|
      format.html { redirect_to candidates_url }
      format.json { head :no_content }
    end
  end
end
