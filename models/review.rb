# Review belongs_to Venue link:Venue.html
#  
# 
# 
# 
# 
class Review

  include Mongoid::Document
  include Mongoid::Timestamps

  field :author,  type: Moped::BSON::ObjectId
  field :comment, type: String
  field :rate, type: Integer
  field :upvote, type: Array

  embedded_in :venue
  
  validates_presence_of :name, :comment, :rate
  validates_numericality_of :rate, greater_than_or_equal_to: 1, less_than_or_equal_to: 5
end