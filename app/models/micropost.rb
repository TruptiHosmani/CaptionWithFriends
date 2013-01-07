# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
require 'ajaxful_rating'


class Micropost < ActiveRecord::Base


  attr_accessible :content , :rating_average, :photo_id, :contest_id, :user_id
  belongs_to :user
  belongs_to :contest

  validates :content, presence: true,:length => { :maximum => 140 }
  validates :user_id, presence: true
  validates :contest_id, presence: true

  ajaxful_rateable :dimensions => [:star], :cache_column => :rating_average
  default_scope order: 'microposts.created_at DESC'


end
