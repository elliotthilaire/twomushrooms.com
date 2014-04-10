# A sample Guardfile
# More info at https://github.com/guard/guard#readme

#guard :rubocop, all_on_start: false do
#  watch(%r{.+\.rb$})
#  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
#end

#group :server do
#  guard :shotgun do
#    watch(/.+/) # watch *every* file in the directory
#  end
#end

guard 'livereload' do
  watch(%r{views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end
