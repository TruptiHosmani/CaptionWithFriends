class FriendshipController < ApplicationController

  def index
    @friends = current_user.friends
   # @friends = @friendship.paginate(page: params[:page])
    @request_sent = current_user.pending_friends

    @request_received = current_user.requested_friendships
    respond_to do |format|
      format.html # show.html.erb
      format.json {
        data = {'Request_received' => @request_received, 'Request_sent' => @request_sent ,'friends'=>@friends}
        render json: data
      }
    end

   end

  def create
    @friendship = Friendship.new(:user_id => current_user.id, :friend_id => params[:friend_id], :approved => 'f')
    if @friendship.save
      flash[:success] = "Friend request sent!"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def approve
    @friendship = Friendship.where(:user_id =>  params[:friend_id], :friend_id =>current_user.id).first
    if @friendship.update_attributes(:approved => 't')
      flash[:success] = "friend request approved"

    else
      flash[:error] = "Could not  approved friend request"
    end
    redirect_to current_user
  end

  def ignore
    @friendship = Friendship.where(:user_id =>  params[:friend_id], :friend_id =>current_user.id).first
    @friendship.delete
    if@friendship.save
      flash[:success] = "Ignore friend request"

    else
      flash[:error] = "Could not ignore friend request"
    end
    redirect_to current_user
  end

  def delete
    @friendship = Friendship.where(:user_id =>  params[:friend_id], :friend_id =>current_user.id).first
    @friendship.delete
    if@friendship.save
      flash[:success] = "Ignore friend request"

    else
      flash[:error] = "Could not ignore friend request"
    end
    redirect_to current_user
  end
end
