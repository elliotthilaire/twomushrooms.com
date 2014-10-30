
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'

# Tests for Photo
class PhotoTest < MiniTest::Unit::TestCase
  def setup
  end

  def test_the_truth
    assert true
  end
end
