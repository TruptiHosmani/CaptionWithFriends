class Contest < ActiveRecord::Base
  attr_accessible :title, :pic, :end_date, :pic_url , :image_remote_url

  belongs_to :user
  has_many :contestants

  has_many :users, :through => :contestants
  has_many :microposts

  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'

private

  def image_url_provided?
    !self.image_remote_url.blank?
  end

  def download_remote_image
    self.image = do_download_remote_image
    self.image_remote_url = image_url
  end

  def do_download_remote_image
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end


end
