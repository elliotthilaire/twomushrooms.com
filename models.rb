require 'chronic'
require 'exifr'
require 'dragonfly'
require 'aws-sdk'

class Photo
  extend Dragonfly::Model

  attr_accessor :id, :pathname, :filename, :slug, :name, :caption, :mtime, :date_taken, :image, :image_uid

  dragonfly_accessor :image

  def initialize (params = {})

  #  s3 = AWS::S3.new(
      # this comes straight from the correctly named environment variables
      #  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      #  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  #)

  #bucket = s3.buckets[ENV['S3_BUCKET']]

    pathname = params[:pathname]

    @pathname = pathname                        # content/featured/ant-on-blue-flower.jpg
    @filename = File.basename(pathname)         # ant-on-blue-flower.jpg
    @slug = File.basename(pathname, ".*")       # ant-on-blue-flower
    @title = @slug.gsub('-', ' ')               # ant on blue flower
    @caption = "Photo of #{@title}"             # Photo of ant on blue flower
    @mtime = File.mtime(pathname)
    @date_taken = EXIFR::JPEG.new(pathname).date_time_original

    @image = Dragonfly.app.fetch(pathname)
    #@image = Dragonfly.app.fetch(bucket.objects['featured/ant-on-blue-flower.jpg'].read)
  end
  
  def self.all 
    prepare
  end

  def self.find (slug)

    Dir.chdir('content') do
      results = Dir.glob("*/#{slug}*")

      if results.any?
        photo = new(:pathname => results.first)
      end
    end
  end

  def to_s
    @pathname
  end

  def <=> rhs
    date_taken <=> rhs.date_taken
  end
  
  def self.prepare

    # search for files in directories

    Dir.chdir('./content/') do 
        pathnames = Dir.glob('*/*.{jpg}')

        photos = Array.new

        pathnames.each do |pathname|
          photos << new(:pathname => pathname)
        end

        photos.sort.reverse 
    end


  end

end
