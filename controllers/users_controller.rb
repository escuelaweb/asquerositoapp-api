class UsersController < App
  get '/' do
    "Get from users"
  end

  post '/' do
    @user = User.new(
      name: params[:name],
      surname: params[:surname],
      birthday: params[:birthday],
      email: params[:email],
      )

    @user.password= params[:password]

    if @user.save
      status 201
      @user.to_json
    else
      status 422
      @user.errors.to_json
    end
  end
end
