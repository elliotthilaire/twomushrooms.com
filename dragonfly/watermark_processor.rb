class WatermarkProcessor
  def call(content, *_args)
    content.process! :convert, "'public/watermark.png' -gravity southeast -composite"
  end

  def update_url(attrs, *_args) # attrs is Job#url_attributes, which is an OpenStruct-like object
    attrs.style = 'watermarked'
  end
end
