require 'aws-sdk-s3'
require 'fileutils'
require_relative 'photo'

class S3Adapter
  def initialize(s3_bucket: ENV['S3_BUCKET'])
    s3 = Aws::S3::Resource.new
    @bucket = s3.bucket(s3_bucket)
  end

  def find(key)
    object = @bucket.object(key)
    convert(object)
  end

  def all
    @bucket.objects.map { |object| convert(object) }
  end

  private

  def convert(object)
    unless File.exist?("./tmp/#{object.key}")
      FileUtils.mkpath "./tmp/#{File.dirname(object.key)}"
      object.get(response_target: "./tmp/#{object.key}")
    end
    category = File.dirname(object.key)
    pathname = "./tmp/#{object.key}"
    Photo.new(pathname: pathname , category: category)
  end
end
