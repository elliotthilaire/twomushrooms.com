class WatermarkProcessor

## not needed for sinatra
##include Configurable
##include ImageMagick::Utils

  def call(content, *args)

    # uses the source image dimensions to resize the watermark with
	#image_properties = identify(content)
	watermark_resize = "100x100" #{}"#{image_properties[900]}x#{image_properties[10]}^"
	



	content.process! :convert, "'public/watermark.png' -gravity southeast  -compose dissolve -define compose:args='100' -composite"
  end

  def update_url(attrs, *args) # attrs is Job#url_attributes, which is an OpenStruct-like object
    attrs.style = 'watermarked'
  end

  def watermark(source_image, opts = {})
	opts = defaults.merge(opts)
	
	
	# assembles an ImageMagick convert command which does all the work
	convert(
	source_image,
	"( #{opts[:watermark]} -resize #{watermark_resize} ) -compose dissolve -define compose:args=#{opts[:opacity]} -composite"
	)

	end

	def defaults
	{
	opacity: 60, # 0-100 where 0 is opaque
	watermark: File.new("public/watermark.png").path # a path to a default watermark image
	}
	end

end