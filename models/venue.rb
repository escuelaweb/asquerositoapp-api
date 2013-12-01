# Venue tiene los siguientes campos:
#
# * field :name, type: String
# * field :location, type: Array => [lat, long]
# * field :description, type: String
# * has_many Reviews (link:Review.html)
# * has_many Photos (link:Photo.html)
class Venue 

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :location, type: Array
  field :description, type: String

  belongs_to :user 
  embeds_many :reviews
  embeds_many :photos

  # Todos los campos son obligatorios
  validates_presence_of :name, :location, :description

  validate :validates_uniqueness_of_venue

  index({ location: "2d" }, { min: -200, max: 200 })

  # Este metodo actualiza un Venue tomando los atributos desde el params - 
  # no guarda el objeto, debe guardarse posteriormente
  def update_venue(params)
    self.name = name unless params[:name].nil?
    self.location = [params[:longitude].to_f, params[:latitude].to_f] unless [params[:longitude], params[:latitude]].all?
    self.description = params[:description] unless params[:description].nil?
  end

  private
    # Valida que no exista otro Venue con el mismo nombre en una zona cercana a la actual
    def validates_uniqueness_of_venue
      if  Venue.where(name: self.name).geo_near(self.location).count > 0
        errors.add(:venue, "Existe un local con el mismo nombre y locacion el mio!!")
      end
    end
end