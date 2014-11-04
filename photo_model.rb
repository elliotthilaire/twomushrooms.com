
# Photo class from files on disk
class Photo
  attr_accessor :pathname, :category, :slug

  @path = './content' # no trailing slash

  def initialize(params = {})
    @pathname = params[:pathname]
    @slug = File.basename(@pathname, '.*')
    @category = File.dirname(@pathname).split('/').last
  end

  # Class methods

  def self.all
    prepare
  end

  def self.find_by_category(category)
    prepare(category: category)
  end

  def self.find(slug)
    prepare(slug: slug).first || nil
  end

  protected

  # Returns an array of Photo objects.
  def self.prepare(params = {})
    photos = []

    category = params[:category] || '*'
    slug = params[:slug] || '*'
 
    search_string = "#{@path}/#{category}/#{slug}.{jpg}"  
    
    Dir.glob(search_string).each do |pathname|
      photos << new(pathname: pathname)
    end

    photos
  end

end
