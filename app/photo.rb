require 'exifr'

class Photo
  attr_accessor :pathname, :category

  def initialize(pathname:, category:)
    @pathname = pathname
    @category = category
  end

  def slug     # e.g. ant-on-blue-flower
    File.basename(@pathname, '.*')
  end

  def filename # e.g. ant-on-blue-flower.jpg
    File.basename(@pathname)
  end

  def title    # e.g. ant on blue flower
    slug.tr('-', ' ')
  end

  def date_taken
    EXIFR::JPEG.new(@pathname).date_time_original
  end

  def image # return a dragonfly object for image manipulation
    Dragonfly.app.fetch_file(@pathname)
  end

  def <=>(other)
    other.date_taken <=> date_taken
  end
end
