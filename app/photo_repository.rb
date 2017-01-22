class PhotoRepository
  def initialize(adapter:)
    @adapter = adapter      
  end

  def find(key)
    @adapter.find(key)
  end

  def all
    @adapter.all
  end
end
