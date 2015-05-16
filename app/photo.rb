require 'exifr'

class Photo

  attr_reader :pathname, :category, :slug, :filename, :title, :caption, :date_taken

  @path = './content' # no trailing slash

  def initialize(params = {})
    @pathname = params[:pathname]
    @slug = File.basename(@pathname, '.*')              # e.g. # ant-on-blue-flower
    @category = File.dirname(@pathname).split('/').last # e.g. featured
    @filename = File.basename(@pathname)                # e.g. ant-on-blue-flower.jpg
    @title = slug.gsub('-', ' ')                        # e.g. ant on blue flower
    @caption = "Photo of #{title}"                      # e.g. Photo of ant on blue flower
    @date_taken = EXIFR::JPEG.new(@pathname).date_time_original
  end

  # return a dragonlfy object for image manipulation
  def image
    Dragonfly.app.fetch_file(@pathname)
  end

  # order photos by the date they were taken
  def <=>(other)
    date_taken <=> other.date_taken
  end

  ################
  # class methods
  #

  # return array of all photos
  def self.all
    prepare
  end
 
  # return array of photos for one category
  def self.find_by_category(category)
    prepare(category: category)
  end

  # return an array of photos from multiple categories
  # categories taken in as an array of strings
  # e.g. find_by_categories(['featured', 'gallery'])
  def self.find_by_categories(categories)
    categories.reduce([]) { |photos, category| photos.push *find_by_category(category) }  
  end

  # return a single photo object
  # takes a slug as an input
  # e.g. find('ant-on-blue-flower')
  def self.find(slug)
    prepare(slug: slug).first || nil
  end

  private

  # return an array of photo objects from the file system
  # takes a params hash to filter category or slug
  # e.g. prepare(category: 'featured')
  # e.g. prepare(slug: )
  def self.prepare(params = {})
    # glob search string from parameters
    category = params[:category] || '*'
    slug = params[:slug] || '*'

    search_string = "#{@path}/#{category}/#{slug}.{jpg}"  
    Dir.glob(search_string).collect { |pathname| new(pathname: pathname) }
  end


end
