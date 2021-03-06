class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_v1_user!
  before_action :get_user

  # GET /user
  def index
    @user = User.all

    @user_ids = params[:user_ids].to_a.uniq
    if (@user_ids.size != 0)
      @user = @user.where(id: @user_ids)
    end

    render json: @user
  end

  # GET /user/1
  def show
    render json: @user
  end

  # POST /user
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :description)
  end
end
