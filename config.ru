libs = File.expand_path "../", __FILE__
$LOAD_PATH.unshift libs unless $LOAD_PATH.include?(libs)

require File.expand_path "../app.rb", __FILE__

Dir.glob('controllers/**/*.rb').each do |file|
  require file
end

Dir.glob('controllers/**/*.rb').each do |file|
  controller = File.basename(file, '.rb').split('_').map{|f| f.capitalize }.inject(:+)
  route = "/" + controller.sub(/Controller/,'').downcase 
  map(route) { run Module.const_get controller }
end

map('/') { run App }

