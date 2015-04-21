
require 'chronic'
require 'exifr'

class Image

  attr_reader :file_name, :title, :caption, :date_taken, :category, :slug

  def initialize(file_path)
  	#non-readible
  	@file_path = file_path
  	@pathname = file_path

  	#readible
  	@file_name = File.basename(@pathname) # ant-on-blue-flower.jpg
  	@slug = File.basename(@pathname, '.*') # ant-on-blue-flower
  	@title = @slug.gsub('-', ' ') # ant on blue flower
  	@caption = "Photo of #{title}" # Photo of ant on blue flower
  	@date_taken = exif.date_time_original
  	@category = File.dirname(@pathname).split('/').last
end


  #def <=>(other)
  #  date_taken <=> other.date_taken
  #end

  #/Users/elliott/Desktop/Projects/twomushrooms.com/content/featured/ant-on-blue-flower.jpg

  private

  # Access the exif data
  def exif
    EXIFR::JPEG.new(@file_path)
  end

end
