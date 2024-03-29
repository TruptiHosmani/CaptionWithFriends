class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    respond_to do |format|
      format.html # show.html.erb
      format.json {
        data = {'users' => @user, 'Microposts' => @microposts}
        render json: data
      }
    end
  end

  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    end

  def rate
    @microposts = Micropost.find(params[:id])
    @microposts.rate(params[:stars], current_user)
    render :update do |page|
      page.replace_html @microposts.wrapper_dom_id(params), ratings_for(@microposts)
      page.visual_effect :highlight, @microposts.wrapper_dom_id(params)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
    respond_to do |format|
      format.html # show.html.erb
      format.json {
        data = {'users' => @users}
        render json: data
      }
    end

  end



  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
