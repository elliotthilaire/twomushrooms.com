module ContentHelpers
  def content_path(file)
    File.join('content', params[:gallery], file)
  end
end

module DateHelpers
  def nice_date(t)
    t.strftime('%Y-%m-%d %H:%M:%S')
  end
end

helpers do
  include ContentHelpers
  include DateHelpers
end
