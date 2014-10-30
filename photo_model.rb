

class Photo

 # Not needed when using Dragonfly.fetch_file
 #extend Dragonfly::Model
 #dragonfly_accessor :image

  attr_accessor :pathname

  def initialize (params = {})
    @pathname = params[:pathname]
  end
  
  # Class methods

  def self.all 
    prepare
  end

  def self.find (slug)

      results = Dir.glob("./content/*/#{slug}*")

      if results.any?
        photo = new(:pathname => results.first)
      end
  end

  def self.prepare

    # search for files in directories
    pathnames = Dir.glob('./content/*/*.{jpg}')

    photos = Array.new

    pathnames.each do |pathname|
      photos << new(:pathname => pathname)
    end

    photos.sort.reverse 

  end

  def mtime
    File.mtime(@pathname) # file modified time
  end

  # Overrides
  def to_s
    @pathname
  end

  def <=> rhs
    mtime <=> rhs.mtime
  end

end
