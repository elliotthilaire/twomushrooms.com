class OrientationAnalyser

  def call(content, *args)

    width = content.analyse(:width)
    height = content.analyse(:height)

    if width == height
    	return :square
    elsif width > height
    	return :landscape
    elsif height > width
    	return :portrait
    end

    return :oops

  end

end