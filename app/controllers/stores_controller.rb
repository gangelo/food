# frozen_string_literal: true

# The store controller for this application.
class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: %i[show edit update destroy]

  # GET /stores or /stores.json
  def index
    @resource = current_user.stores.order(:store_name).presenter(current_user)
  end

  # GET /stores/1 or /stores/1.json
  def show; end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit; end

  # POST /stores or /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to store_url(@store), notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1 or /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to store_url(@store), notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1 or /stores/1.json
  def destroy
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /stores/add
  def add
    @resource = all_stores
  end

  # POST /stores/add_create
  def add_create
    success = UserStore.new(user_id: current_user.id, store_id: add_create_params[:store_id]).save
    @resource = all_stores
    if success
      redirect_to add_create_stores_path, notice: 'Store was successfully added.'
    else
      # You might want to handle the error differently, perhaps redirecting back with a flash message.
      redirect_to add_create_stores_path, alert: 'There was an error adding the store.'
    end
  end

  # GET /stores/search
  def search; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end

  def all_stores
    Store.all.order(:store_name).presenter(current_user)
  end

  # Only allow a list of trusted parameters through.
  def store_params
    params.require(:store).permit(:store_name, :address, :address2, :city, :state_id, :zip_code)
  end

  def add_create_params
    params.require(:store).permit(:store_id)
  end
end
