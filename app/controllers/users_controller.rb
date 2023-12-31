# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
    @password_verifier = PasswordVerifier.new(@user)
  end

  # GET /users/1/edit
  def edit
    @password_verifier = PasswordVerifier.new(@user)
  end

  # POST /users or /users.json
  def create
    set_user_and_verifier
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: successful_response('create') }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: successful_response('update') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: successful_response('destroy') }
      format.json { head :no_content }
    end
  end

  # POST /users/preview
  # preview form validation
  def preview
    @password_verifier = PasswordVerifier.new(User.new(user_params))

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_user_and_verifier
    @user = User.new(user_params)
    @password_verifier = PasswordVerifier.new(@user)
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def successful_response(action)
    t("activerecord.successful.messages.#{action}", model: @user.class.model_name.human)
  end
end
