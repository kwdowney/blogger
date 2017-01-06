class Article < ApplicationRecord
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings

	def tag_list
  		self.tags.collect do |tag|
    	tag.name
  		end.join(", ")
	end

	def tag_list=(tags_string)

	#Split the tags_string into an array of strings with leading and trailing whitespace removed	
		tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
  	
  	
    #Ensure each one of these strings are unique
    #Look for a Tag object with that name. If there isn’t one, create it.
    #Add the tag object to a list of tags for the article
  	
  		new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  	
  	#Set the article’s tags to the list of tags that we have found and/or created	
  		self.tags = new_or_found_tags
	end

end