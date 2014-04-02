# A sample Guardfile
# More info at https://github.com/guard/guard#readme

#guard :rubocop, all_on_start: false do
#  watch(%r{.+\.rb$})
#  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
#end

group :server do
  guard :shotgun do
    watch(/.+/) # watch *every* file in the directory
  end
end
