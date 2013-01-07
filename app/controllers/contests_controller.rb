class ContestsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  respond_to :json
  # GET /contests
  # GET /contests.json
  def index
    @contests = Contest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contests }
    end
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
    @contest = Contest.find(params[:id])
    @send = Contest.find_by_sql("Select users.name, microposts.content, microposts.rating_average, users.email from users INNER JOIN microposts on microposts.user_id = users.id
                                INNER JOIN contests on contests.id = microposts.contest_id where contests.id = '#{params[:id]}'")
    @microposts = @contest.microposts

    @micropost = Micropost.new

    respond_to do |format|
      format.html # show.html.erb
      format.json {
        data = { 'microposts' => @send }
        render json: data
      }
      end
  end

  # GET /contests/new
  # GET /contests/new.json
  def new
    @contest = Contest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contest }
    end
  end

  # GET /contests/1/edit
  def edit
    @contest = Contest.find(params[:id])
  end

  # POST /contests
  # POST /contests.json
  def create
    #@contest = current_user.contests.build(params[:contest])

   @contest = Contest.new(params[:contest])
   @contest.user_id = current_user.id
    respond_to do |format|
      if @contest.save
        format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
        format.json { render json: @contest, status: :created, location: @contest }
      else
        format.html { render action: "new" }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contests/1
  # PUT /contests/1.json
  def update
    @contest = Contest.find(params[:id])

    respond_to do |format|
      if @contest.update_attributes(params[:contest])
        format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy

    respond_to do |format|
      format.html { redirect_to contests_url }
      format.json { head :no_content }
    end
  end


  def my_photos
    @contests = Contest.find_all_by_user_id(current_user.id)
    @current_page = 'my_photos'
    respond_to do |format|
      format.html # show.html.erb
      format.json {
        data = {'contests' => @contests}
        render json: data
      }

    end
  end

  def user_photos
    @contests = Contest.find_all_by_user_id(params[:id])
    result = []
    @contests.each do |contest|
      pic_url = "http://localhost:3000"+contest.pic.url
      result <<  pic_url

    end

    respond_to do |format|
      format.html # show.html.erb
      format.json {
        data = {'contests' => @contests, "Pic_URL" =>result}
        render json: data
      }

    end
  end


  def captions_given
    friends = current_user.friends
    @contests = []
      friends.each do |friend|
        contests = Contest.find_all_by_user_id(friend.id)
        contests.each do |contest|
          micropost = Micropost.find_all_by_contest_id_and_user_id(contest.id,current_user.id)
          if (micropost.length > 0)
            @contests << contest
          end

        end
      end
    @current_page = 'captions_given'
    respond_to do |format|
            format.html # show.html.erb
            format.json {
        data = {'contests' => @contests}
        render json: data
      }
    end


  end

  def captions_pending
      # Get photos from friends that you haven't given caption yet
      friends = current_user.friends
      @contests = []

      friends.each do |friend|
        logger.debug "friend_id => #{friend.id}"
        contests = Contest.find_all_by_user_id(friend.id)
        logger.debug "contests length => " + contests.length.to_s

        contests.each do |contest|
          micropost = Micropost.find_all_by_contest_id_and_user_id(contest.id,current_user.id)
          if (micropost.length == 0)
            @contests << contest
          end

        end
      end
    @current_page = 'captions_pending'
    respond_to do |format|
            format.html # show.html.erb
           format.json {
        data = {'contests' => @contests}
        render json: data
      }
      end
  end



  def captions_pending_web
      # Get photos from friends that you haven't given caption yet
      friends =  User.find(params[:id]).friends
      @contests = []
      result = []

      friends.each do |friend|
        contests = Contest.find_all_by_user_id(friend.id)
        contests.each do |contest|

          micropost = Micropost.find_all_by_contest_id_and_user_id(contest.id,params[:id])
          if (micropost.length == 0)
            @contests << contest
             pic_url = "http://localhost:3000"+contest.pic.url
            result <<  pic_url
          end

        end
      end
      respond_to do |format|
            format.html # show.html.erb
           format.json {
        data = {'contests' => @contests, "Pic_URL" =>result}
        render json: data
      }
      end

       logger.debug "contests pending = " + @contests.to_s
  end
  def captions_given_web
    friends = User.find(params[:id]).friends

      result = []

      @contests = []
      friends.each do |friend|
        contests = Contest.find_all_by_user_id(friend.id)
        contests.each do |contest|

          micropost = Micropost.find_all_by_contest_id_and_user_id(contest.id,params[:id])
          if (micropost.length > 0)
            @contests << contest
             pic_url = "http://localhost:3000"+contest.pic.url
            result <<  pic_url
          end

        end
      end
    respond_to do |format|
            format.html # show.html.erb
            format.json {
        data = {'contests' => @contests, "Pic_URL" =>result}
        render json: data
      }
    end
    logger.debug "contests given = " + @contests.to_s


  end
end
