class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :update, :destroy]
  before_action :authenticate_v1_user!
  before_action :get_user

  # GET /user_profiles
  def index
    @user_profiles = UserProfile.all

    @user_ids = params[:user_ids].to_a.uniq
    if (@user_ids.size != 0)
      @user_profiles = @user_profiles.where(id: @user_ids)
    end

    render json: @user_profiles
  end

  # GET /user_profiles/1
  def show
    render json: @user_profile
  end

  # POST /user_profiles
  def create
    @user_profile = UserProfile.new(user_profile_params)

    if @user_profile.save
      render json: @user_profile, status: :created, location: @user_profile
    else
      render json: @user_profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_profiles/1
  def update
    if @user_profile.update(user_profile_params)
      render json: @user_profile
    else
      render json: @user_profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_profiles/1
  def destroy
    @user_profile.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_profile_params
    params.require(:user_profile).permit(:name, :description)
  end
end
