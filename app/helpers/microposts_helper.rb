module MicropostsHelper
  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  def rating_ballot
    if @rating = current_user.ratings.find_by_micropost_id(params[:id])
        @rating
    else
        current_user.ratings.new
    end
  end
  def current_user_rating
    if @rating = current_user.ratings.find_by_micropost_id(params[:id])
        @rating.value
    else
        "N/A"
    end
  end

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end
