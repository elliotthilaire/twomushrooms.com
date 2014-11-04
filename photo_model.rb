
# Photo class from files on disk
class Photo
  attr_accessor :pathname, :category, :slug

  @path = './content/'

  def initialize(params = {})
    @pathname = params[:pathname]
    @slug = File.basename(@pathname, '.*')
    @category = File.dirname(@pathname).split('/').last
  end

  # Class methods

  def self.all
    prepare
  end

  def self.find(slug)
    results = Dir.glob("#{@path}/*/#{slug}*")

    # this might be buggy, what is returned if nothing is found?
    new(pathname: results.first) if results.any?
  end

  #def self.prepare(category = nil)
  def self.prepare(params = {})
    photos = []

    if params['category']
      search_string = "./content/#params['category']/*.{jpg}"
    else
      search_string = './content/*/*.{jpg}'
    end
    
    Dir.glob(search_string).each do |pathname|
      photos << new(pathname: pathname)
    end

    photos
  end

  def self.find_by_category(category)
    prepare(category)
    #all.select { |photo| photo.category == category }
  end

  # file modified time
  def mtime
    File.mtime(@pathname) # file modified time
  end

  # Overrides
  def to_s
    @pathname
  end

  #def <=>(other)
  #  mtime <=> other.mtime
  #end
end
