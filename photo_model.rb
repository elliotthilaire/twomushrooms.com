require 'chronic'
require 'exifr'

require './photofile_model.rb'

# Extra methods for Photo
class Photo < PhotoFile

  @path = './content' # no trailing slash

  def filename
    File.basename(@pathname) # ant-on-blue-flower.jpg
  end

  def title
    slug.gsub('-', ' ') # ant on blue flower
  end

  def caption
    "Photo of #{title}" # Photo of ant on blue flower
  end

  def date_taken
    EXIFR::JPEG.new(@pathname).date_time_original
  end

  def image
    Dragonfly.app.fetch_file(@pathname)
  end

  def <=>(other)
    date_taken <=> other.date_taken
  end

  # file modified time
  def mtime
    File.mtime(@pathname) # file modified time
  end

  #######

end
