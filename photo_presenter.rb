require 'chronic'
require 'exifr'

require 'delegate'

# Extra methods for Photo
class PhotoPresenter < SimpleDelegator
  def filename
    File.basename(model.pathname) # ant-on-blue-flower.jpg
  end

  def title
    slug.gsub('-', ' ') # ant on blue flower
  end

  def caption
    "Photo of #{title}" # Photo of ant on blue flower
  end

  def date_taken
    EXIFR::JPEG.new(model.pathname).date_time_original
  end

  def image
    Dragonfly.app.fetch_file(model.pathname)
  end

  def <=>(other)
    date_taken <=> other.date_taken
  end

  #######

  # Returns ref to the object we're decorating
  # a method to help readability.
  # If using this n>1 times then consider moving upto superclass
  def model
    __getobj__
  end

  # Enables us to call Presenter.wrap on a collection of objects
  # and instatiate those objects
  def self.wrap(collection)
    collection.map do |obj|
      new obj
    end
  end
end
