class SessionsController < ApplicationController
   def new
  end

   def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
   end

   def ios_login
     #logger_debug "params => " + params
      result = "fail"
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        sign_in user
        result = "ok"
      end

      respond_to do |format|
        format.html # show.html.erb
        format.json {
          data = {'result' => result}
          render json: data
        }
      end
   end

  def destroy
    sign_out
    redirect_to root_path
  end
end
