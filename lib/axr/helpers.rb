module AjaxfulRating # :nodoc:
  module Helpers
    include AjaxfulRating::Errors

    # Outputs the required css file, and the dynamic CSS generated for the
    # current page.
    def ajaxful_rating_style
      @axr_css ||= CSSBuilder.new
      stylesheet_link_tag('ajaxful_rating') +
        content_tag(:style, @axr_css.to_css, :type => "text/css")
    end
   def ratings_for(*args)
      @axr_css ||= CSSBuilder.new
      options = args.extract_options!.symbolize_keys.slice(:small, :remote_options,
        :wrap, :show_user_rating, :dimension, :force_static, :current_user, :disable_remote, :to_nearest)
      remote_options = options.delete(:remote_options) || {}
      rateable = args.shift
      user = args.shift || (respond_to?(:current_user) ? current_user : raise(NoUserSpecified))
      StarsBuilder.new(rateable, user, self, @axr_css, options, remote_options).render
    end
  end
end

class ActionView::Base # :nodoc:
  include AjaxfulRating::Helpers
end