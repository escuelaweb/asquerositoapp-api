
class VenuesController < App
  
  get '/' do
    venues =  Venue.all
    venues.to_json
  end

  post '/' do
    venue = Venue.new name: params[:name], location: [params[:longitude].to_f, params[:latitude].to_f], description: params[:description]
    response_on_save_venue(venue)
  end

  get '/:id' do
    venue = Venue.where(params[:id]).last
    unless venue.nil?
      venue.to_json
    else 
      status 404
      { :error => "Venue not found" }.to_json
    end
  end

  %w(patch put).each do |method|                                                                                                         
    send(method, "/:id") do
      venue = Venue.where(params[:id]).last
      unless venue.nil?
        venue.update_venue(params)
        response_on_save_venue(venue)
      else
        status 404
        { :error => "Venue not found" }.to_json
      end
    end
  end

  def response_on_save_venue(venue)
    if venue.save
      status 201
      venue.to_json
    else
      status 422
      venue.errors.to_json
    end
  end
end