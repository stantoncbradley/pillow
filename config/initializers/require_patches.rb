Dir[Rails.root + 'lib/patches/*.rb'].each do |file|
  require file
end