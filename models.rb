require 'chronic'
require 'exifr'
require 'dragonfly'

include Sinatra::Thumbnails::Helpers

class Photo
  extend Dragonfly::Model

  attr_accessor :id, :pathname, :filename, :slug, :name, :caption, :mtime, :date_taken, :image, :image_uid

  dragonfly_accessor :image

  def initialize (params = {})
    pathname = params[:pathname]

    @pathname = pathname                        # content/featured/ant-on-blue-flower.jpg
    @filename = File.basename(pathname)         # ant-on-blue-flower.jpg
    @slug = File.basename(pathname, ".*")       # ant-on-blue-flower
    @title = @slug.gsub('-', ' ')               # ant on blue flower
    @caption = "Photo of #{@title}"             # Photo of ant on blue flower

    @mtime = File.mtime(pathname)
    @date_taken = EXIFR::JPEG.new(pathname).date_time_original

    @image = Dragonfly.app.fetch_file(pathname)

  end
  
  def self.all 
    prepare
  end

  def self.find (slug)
    
    pathname = "content/featured/#{slug}.jpg"

    if File.exists?(pathname)
      photo = new(:pathname => pathname)
    end
  end

  def to_s
    @pathname
  end

  def <=> rhs
    date_taken <=> rhs.date_taken
  end
  
  def self.prepare

    # search for files in directories
    pathnames = Dir.glob('content/featured/*.{jpg}')

    photos = []

    pathnames.each do |pathname|
      photo = new(:pathname => pathname)
      photos << photo
    end

    photos.sort.reverse
  end

end
