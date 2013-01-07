class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy


   def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Caption Added!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path

  end

  def ios_create
    @micropost = Micropost.new({
        "user_id" => current_user.id,
        "contest_id" => params[:contest_id],
        "content" => params[:content]
    })

    respond_to do |format|
      if @micropost.save
        format.json { render json: @micropost, status: :created, location: @micropost }
      else
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end


  def rate
    @micropost = Micropost.find(params[:id])
    @micropost.rate(params[:stars], current_user)
    average = Micropost.rate_average(true )
    width = (average / @micropost.class.max_stars.to_f) * 100
    render :json => {:id => @micropost.wrapper_dom_id(params), :average => average, :width => width}
  end


  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end

end
