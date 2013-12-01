class Photo

  include Mongoid::Document
  include Mongoid::Timestamps

  # 
  embedded_in :venue
end