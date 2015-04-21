require 'chronic'
require 'exifr'

# Extra methods for Photo
class Photo

  attr_accessor :pathname, :category, :slug, :filename, :title, :caption, :date_taken

  @path = './content' # no trailing slash

  def initialize(params = {})
    @pathname = params[:pathname]
    @slug = File.basename(@pathname, '.*')
    @category = File.dirname(@pathname).split('/').last

    #readible
    @filename = File.basename(@pathname) # ant-on-blue-flower.jpg
    @title = slug.gsub('-', ' ') # ant on blue flower
    @caption = "Photo of #{title}" # Photo of ant on blue flower
    @date_taken = EXIFR::JPEG.new(@pathname).date_time_original
  end

  def image
    Dragonfly.app.fetch_file(@pathname)
  end

  def <=>(other)
    date_taken <=> other.date_taken
  end



  # Class methods

  def self.all
    prepare
  end

  def self.find_by_category(category)
    prepare(category: category)
  end

  # Takes an array of categories
  # Returns an array of photos
  # e.g. find_by_categories(['featured', 'gallery'])
  def self.find_by_categories(array)
    photos = []

    array.each do |category| 
      photos.push *find_by_category(category)
    end

    photos

  end

  def self.find(slug)
    prepare(slug: slug).first || nil
  end


  protected

  # Returns an array of photo objects
  def self.prepare(params = {})
    category = params[:category] || '*'
    slug = params[:slug] || '*'
 
    search_string = "#{@path}/#{category}/#{slug}.{jpg}"  
    
    Dir.glob(search_string).collect { |pathname| new(pathname: pathname) }
  end



end
