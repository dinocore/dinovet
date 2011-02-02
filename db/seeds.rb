# Load Default Species and Breeds
Dir.glob(File.join(File.dirname(__FILE__), "species", "*.yml")).each do |file|
  yml = open(file) { |f| YAML.load(f) }

  yml.each_key do |species|
    entry = Species.new(:name => yml[species]['name'])

    yml[species]['breeds'].each do |breed|
      entry.breeds << Breed.new(:name => breed)
    end unless yml[species]['breeds'].nil?

    entry.save
  end
end unless not Species.all.empty?
