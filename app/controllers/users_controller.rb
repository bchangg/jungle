# frozen_string_literal: true

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to 'new'
    end
  end

  def show; end

  def edit; end

  def update
    render 'show'
  end

  def destroy
    render 'show'
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
  # def passwords_not_equal user
  #   if(user[:password] != user[:password_confirmation])
  #     user.errors.add(:password, 'must be equal')
  #   end
  # end
end
