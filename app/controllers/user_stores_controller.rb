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
    @resource = current_user.user_stores.build(store: Store.new).presenter(user: current_user, view_context: view_context)
  end

  # GET /user/stores/1/edit
  def edit; end

  # POST /user/stores or /user/stores.json
  def create
    @resource = current_user.user_stores.create(create_params).presenter(user: current_user, view_context: view_context)
    redirect_to add_user_stores_path, notice: 'Store was successfully added.' and return if @resource.persisted?

    store_name = create_params[:store_attributes][:store_name]
    zip_code = create_params[:store_attributes][:zip_code]
    store = Store.where_name_and_zip_case_insensitive(store_name, zip_code).first
    if store && current_user.user_stores.exists?(store_id: store.id)
      flash.now[:info] = 'This store is already in your stores list!'
      render :new, status: :conflict
    elsif @resource.store&.non_unique_store?
      render :new, status: :conflict
    else
      render :new, status: :unprocessable_entity
    end
  end

  # POST /user/stores/link
  def link
    @resource = current_user.user_stores.create(store_id: link_store_params[:store_attributes][:id]).presenter(user: current_user, view_context: view_context)
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
      format.html { redirect_to user_stores_url, notice: 'Store was successfully removed.' }
      format.json { head :no_content }
    end
  end

  # GET /user/stores/add
  def add
    if request.post?
      store = current_user.user_stores.create(store_id: add_params[:store_id])
      @resource = user_stores_store_build_for_add

      flash[:alert] = store.errors.full_messages unless store.persisted?
      flash[:notice] = 'Store was successfully added.' if store.persisted?
      redirect_to add_user_stores_url, status: :see_other
    else
      @resource = user_stores_store_build_for_add
    end
  end

  private

  def user_stores_store_build_for_add
    store_ids = current_user.stores.pluck(:id)
    Store.where.not(id: store_ids).pluck(:id).map do |store_id|
      current_user.user_stores.build(store_id: store_id)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = UserStore.find(params[:id])
  end

  def all_user_stores
    current_user.user_stores_by_name_and_zip_code.presenter(user: current_user, view_context: view_context)
  end

  def add_params
    params.require(:user_store).permit(:store_id)
  end

  def user_store_params
    params.require(:store).permit(:user_store_id)
  end

  def create_params
    params.require(:user_store).permit(
      :non_unique_store_id,
      store_attributes: [
        :store_name,
        :address,
        :address2,
        :zip_code,
        :city,
        :state_id
      ]
    ).slice(:store_attributes)
  end

  def link_store_params
    params.require(:user_store).permit(
      store_attributes: [:id]
    )
  end

  def non_unique_store_id_param
    params.require(:user_store).permit(
      :non_unique_store_id,
      store_attributes: [
        :store_name,
        :address,
        :address2,
        :zip_code,
        :city,
        :state_id
      ]
    )[:non_unique_store_id]
  end
end
