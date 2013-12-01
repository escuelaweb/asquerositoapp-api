class SessionsController < App
  get '/' do
    "Get from Session"
  end

  post '/' do
     user = User.authenticate(params[:login], params[:password])
     if user
       status 201
       user.to_json
     else
       status 404
       {error: "Login or Password not valid"}.to_json
     end
  end

  delete '/:id' do
    user = User.find(params[:id])
    user.update_attribute(:token, nil)

    status 200
    {mensaje: "La sesion ha sido cerrada"}
  end

end
