class StaticPagesController < ApplicationController
   respond_to :json
  def home
   @contests = Contest.find_all_by_user_id(current_user)

  end

  def help
  end

  def about
  end

  def contact
  end

end
