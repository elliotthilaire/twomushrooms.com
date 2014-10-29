require 'chronic'
require 'exifr'

class Photo

 # Not needed when using Dragonfly.fetch_file
 #extend Dragonfly::Model
 #dragonfly_accessor :image

  attr_accessor :pathname

  def initialize (params = {})
    @pathname = params[:pathname]
  end
  
  # Class methods

  def self.all 
    prepare
  end

  def self.find (slug)

      results = Dir.glob("./content/*/#{slug}*")

      if results.any?
        photo = new(:pathname => results.first)
      end
  end

  def self.prepare

    # search for files in directories
    pathnames = Dir.glob('./content/*/*.{jpg}')

    photos = Array.new

    pathnames.each do |pathname|
      photos << new(:pathname => pathname)
    end

    photos.sort.reverse 

  end

  # Instance methods

  def filename
    File.basename(@pathname) # ant-on-blue-flower.jpg
  end

  def slug
    File.basename(@pathname, ".*") # ant-on-blue-flower
  end  

  def title
    slug.gsub('-', ' ') # ant on blue flower
  end

  def caption 
    "Photo of #{title}" # Photo of ant on blue flower
  end

  def mtime
    File.mtime(@pathname) # file modified time
  end

  def date_taken
    EXIFR::JPEG.new(@pathname).date_time_original
  end

  def image 
      Dragonfly.app.fetch_file(@pathname)
  end

  # Overrides
  def to_s
    @pathname
  end

  def <=> rhs
    date_taken <=> rhs.date_taken
  end

end
