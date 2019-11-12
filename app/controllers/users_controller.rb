class UsersController < ApplicationController
    before_action :findUser, only: [:show, :edit, :update]



    def new
        @user = User.new
    end

    def create
        @user = User.new(userParams)

        if @user.save 
            redirect_to @user
        else
            flash[:error] = @user.errors.full_messages
            redirect_to new_user_path
        end

    end

    def show
        @id = @user.id
        if @user == @logged_in 
            render :show
        else 
            flash[:error] = "LMAO"
            redirect_to login_path
        end
    end

    def edit 
    end

    def update
        @user.assign_attributes(userParams)
        if @user.save 
            redirect_to @user
        else
            flash[:error] = @user.errors.full_messages
            redirect_to edit_user_path(@user)
        end
    end


    private 

    def userParams
        params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def findUser
        @user = User.find(params[:id])
    end


end
