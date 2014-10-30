

class Photo
  attr_accessor :pathname, :category, :slug

  @@path = './content/'

  # ./content/featured/ant-on-blue-flower.jpg
  # ./content/gallery/
  # ./content/hidden/

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
    results = Dir.glob("#{@@path}/*/#{slug}*")

    if results.any?
      photo = new(pathname: results.first)
    end
  end

  def self.prepare
    photos = []

    Dir.glob('./content/*/*.{jpg}').each do |pathname|
      photos << new(pathname: pathname)
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

  def <=>(rhs)
    mtime <=> rhs.mtime
  end
end
