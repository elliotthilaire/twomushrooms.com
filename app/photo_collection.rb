class PhotoCollection
  def self.find(slug)
    search_string = "./content/*/#{slug}.{jpg}"
    Dir.glob(search_string).collect do |pathname|
      Photo.new(pathname)
    end.first
  end

  def self.featured
    search_string = './content/featured/*.{jpg}'
    Dir.glob(search_string).collect do |pathname|
      Photo.new(pathname)
    end.sort
  end

  def self.gallery
    search_string = './content/featured/*.{jpg}'
    featured_photos = Dir.glob(search_string).collect do |pathname|
      Photo.new(pathname)
    end

    search_string = './content/gallery/*.{jpg}'
    gallery_photos = Dir.glob(search_string).collect do |pathname|
      Photo.new(pathname)
    end

    (featured_photos + gallery_photos).sort
  end
end
