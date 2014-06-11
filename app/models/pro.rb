class Pro < ActiveRecord::Base
	
	validates_presence_of :name
	validates_uniqueness_of :name
	validates :score, numericality: true
	
  # def image=(input_data)
  #     self.image = input_data.read
  # end
	
end
