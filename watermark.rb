class WatermarkProcessor

##include Configurable
##include ImageMagick::Utils

  def call(content, *args)
    
	content.process! :convert, "'public/watermark.png' -gravity southeast -composite"

	# command = "#{Sinatra::Thumbnails.settings.convert_executable} \"#{src}\" \"./#{Sinatra::Thumbnails.settings.watermark}\" -gravity southeast -composite -define jpeg:size=1200x1200  -thumbnail #{format} \"#{dest}\""


  end

  def update_url(attrs, *args) # attrs is Job#url_attributes, which is an OpenStruct-like object
    attrs.style = 'watermarked'
  end

	def watermark(source_image, opts = {})
	opts = defaults.merge(opts)
	
	# uses the source image dimensions to resize the watermark with
	image_properties = identify(source_image)
	watermark_resize = "#{image_properties[:width]}x#{image_properties[:height]}^"
	
	# assembles an ImageMagick convert command which does all the work
	convert(
	source_image,
	"( #{opts[:watermark]} -resize #{watermark_resize} ) -compose dissolve -define compose:args=#{opts[:opacity]} -composite"
	)
	# as you can see the convert syntax is somewhat inscrutable, which is why
	# it's called ImageMagick and not ImageObvious
	end

	def defaults
	{
	opacity: 60, # 0-100 where 0 is opaque
	watermark: File.new("public/watermark.png").path # a path to a default watermark image
	}
	end

end