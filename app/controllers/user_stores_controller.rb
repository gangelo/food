# frozen_string_literal: true

# The user store controller for managing user stores for
# this application.
class UserStoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource, only: %i[show edit update destroy]

  # GET /user/stores or /user/stores.json
  def index
    @resource = all_user_stores
  end

  # GET /user/stores/1 or /user/stores/1.json
  def show; end

  # GET /user/stores/new
  def new
    @resource = current_user.user_stores.build(store: Store.new)
  end

  # GET /user/stores/1/edit
  def edit; end

  # POST /user/stores or /user/stores.json
  def create
    @resource = current_user.user_stores.create(create_params).presenter(user: current_user, view_context: view_context)
    if @resource.persisted?
      redirect_to add_user_stores_path, notice: 'Store was successfully added.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user/stores/1 or /user/stores/1.json
  def update
    respond_to do |format|
      if @resource.update(user_store_params)
        format.html { redirect_to store_url(@resource), notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/stores/1 or /user/stores/1.json
  def destroy
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /user/stores/add
  def add
    @resource = Store.all.presenter(user: current_user, view_context: view_context)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = UserStore.find(params[:id])
  end

  def all_user_stores
    current_user.user_stores.presenter(user: current_user, view_context: view_context)
  end

  # Only allow a list of trusted parameters through.
  def user_store_params
    params.require(:store).permit(:user_story_id)
  end

  def create_params
    store_attributes = {
      store_attributes: [
        :store_name,
        :address,
        :address2,
        :zip_code,
        :city,
        :state_id
      ]
    }
    params.require(:user_store).permit(store_attributes)
  end
end
