class UsersController < ApplicationController
    before_action :authenticate_user, only: [:show]
    
    ##  get '/signup' do
    def new
        # The sign up page.
        @new_user = User.new 
    end
    
    ## post '/signup' do
    def create
        name = params[:username]
        password = params[:password]
        email = params[:email]
        if !User.find_by(email: email).nil?
          flash[:alert] = "Email already registered"
          redirect_to new_user_url
          return 
        elsif !User.find_by(username: name).nil?
          flash[:message] = "Username taken"
          redirect_to new_user_url
          return 
        else
          new_user = User.create(username: name, email:email)
          new_user.password = password;
          new_user.save!;
          session[:id] = new_user.id
          redirect_to user_url(new_user)
          return 
        end
      end


    ## get '/account'
    def show
    end
  
    # ###### custom GET requests  

    ## get '/login' do
    def login 
    end
  
    #   ## get '/forgot_pass' do
    #   def forgot_password
    #     # The forget password page.
    #     # The user will be forced to change their password.
    #     # DO NOT SEND THEM THEIR PASSWORD AS PLAIN TEXT!
    #     # This is a security vulnerability and can be exploited.
    #     # Always store a hash. Remmeber, Sony 2012!!!
    #   @current_user = User.getLoggedUser(session[:id])
    #     if !@current_user.nil?
    #       redirect '/feeds/0'
    #     else
    #       erb :forgot_pass
    #     end
    #   end
  
    # ## Post/Fetch/Delete/etc Request
  
    ## patch '/update_account' do
    def update
            new_password = params[:password]
            old_password = params[:password_confirmation]
            email = params[:email]
  
            logged_user = getLoggedUser.authenticate(old_password)
            
            if logged_user
              logged_user.email = email unless email.empty?
              logged_user.update(password: new_password, password_confirmation: new_password) unless new_password.empty? 
              flash[:alert] = "Account updated"
            else
              flash[:alert] = "Password Incorrect"
            end

             redirect_to user_url(logged_user)
    end


    ## get '/signout' do
    def signout
        # The sign out page.
        # Search a safer way to do this ************* DELETE
        logout_user 
        flash[:alert] = "You have successfully logged out."
        redirect_to '/'
      end
  
    ## post '/login' do
    def process_login 
          logged_user = User.find_by(username: params[:username] )
        
          unless logged_user && logged_user.authenticate(params[:password])
            flash[:alert] = "Invalid Creditentials"
            redirect_to login_user_url
            return
          else
            session[:id] = logged_user.id
            redirect_to feeds_url
            return 
          end
        end
  

 
  end
  