require_relative 'photo_repository'
require_relative 's3_adapter'

class PhotoCollection
  def self.find(slug)
    all.select do |photo|
      photo.slug == slug
    end.first
  end

  def self.all
    s3 = S3Adapter.new
    repo = PhotoRepository.new(adapter: s3)
    repo.all.sort
  end

  def self.featured
    all.select do |photo|
      photo.category == 'featured'
    end.sort
  end

  def self.gallery
    all.reject do |photo|
      photo.category == 'hidden'
    end.sort
  end
end
