require 'chronic'
require 'exifr'

include Sinatra::Thumbnails::Helpers

class Photo

  attr_accessor :name, :filename, :url, :date_taken, :title, :mtime, :id, :caption

  IMAGEPATH = File.join("content", "featured")

  def initialize (args = {})
    filename = args[:filename]
    @filename = filename
    @name = File.basename(@filename, ".*")
    @url = File.join(IMAGEPATH, @filename)
    @mtime = File.mtime(@url)
    @date_taken = EXIFR::JPEG.new(@url).date_time_original
    @caption = "Photo of #{@name.gsub('-', ' ')}"
  end
  
  def self.all 
    prepare
  end

  def self.find (name)
    if File.exists?(File.join(IMAGEPATH,name + ".jpg"))
      photo = new(:filename => name + ".jpg")
    end
  end

  def to_s
    @url
  end

  def <=> other_photo
    date_taken <=> other_photo.date_taken
  end


  def self.prepare
    path = File.join(IMAGEPATH,"*.{jpg}")
    files = Dir.glob(path)

    photos = []

    files.each do |file|
      filename = File.basename(file)
      photo = new(:filename => filename)
      photos << photo
    end

    photos.sort.reverse
  end

end
