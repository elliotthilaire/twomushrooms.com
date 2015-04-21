
require File.expand_path '../test_helper.rb', __FILE__

class ImageTest < MiniTest::Unit::TestCase

  def setup
  	test_file = File.expand_path '../data/ant-on-blue-flower.jpg', __FILE__
  	@image = Image.new(test_file)
  	puts @image
  end

  def test_slug
    assert_equal 'ant-on-blue-flower', @image.slug
  end

  def test_file_name
    assert_equal 'ant-on-blue-flower.jpg', @image.file_name
  end

end
