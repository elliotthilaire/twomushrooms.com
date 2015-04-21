
require File.expand_path '../test_helper.rb', __FILE__

require File.expand_path '../../lib/image_collection.rb', __FILE__


class ImageCollectionTest < MiniTest::Unit::TestCase

  def setup
    path = 
    @image_collection = ImageCollection.new(path)
  end

  

end