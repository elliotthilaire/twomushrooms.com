
# Adds a watermark to the image
class WatermarkProcessor
  def call(content, *_args)
    content.process! :convert, "'public/watermark.png' -gravity southeast -composite"
  end

 # attrs is Job#url_attributes, which is an OpenStruct-like object
  def update_url(attrs, *_args)
    attrs.style = 'watermarked'
  end
end
