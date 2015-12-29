require 'exifr'


class Photo

  attr_accessor :pathname

  def initialize(pathname)
    @pathname = pathname
  end

  # e.g. ant-on-blue-flower
  def slug
    File.basename(@pathname, '.*')
  end

  # e.g. ant-on-blue-flower.jpg
  def filename
    File.basename(@pathname)
  end

  # e.g. ant on blue flower
  def title
    @title = slug.gsub('-', ' ')
  end

  def date_taken
    EXIFR::JPEG.new(@pathname).date_time_original
  end

  # return a dragonfly object for image manipulation
  def image
    Dragonfly.app.fetch_file(@pathname)
  end

  # order photos by the date they were taken
  def <=>(other)
    other.date_taken <=> date_taken
  end

end
