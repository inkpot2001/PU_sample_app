class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        @microposts = @user.microposts
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Sign up succeeded."
            redirect_to microposts_path
        else 
            render 'new', status: :unprocessable_entity
        end
    end

    private
        def user_params
            params.require(:user).permit(:name, :colour)
        end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # beforeフィルター

    # 正しいユーザーかどうかを確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    # 管理者かどうかを確認
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end    
end