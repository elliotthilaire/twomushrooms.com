class WatermarkProcessor

  def call(content, *args)
	content.process! :convert, "'public/watermark.png' -gravity southeast -composite"
  end

  def update_url(attrs, *args) # attrs is Job#url_attributes, which is an OpenStruct-like object
    attrs.style = 'watermarked'
  end


end