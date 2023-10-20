# frozen_string_literal: true

# The controller for Items.
class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[show edit update archive unarchive]

  # GET /items or /items.json
  def index
    page = params[:page].to_i
    pager_params = Item.pager_params_for(page: page,
                                         pages_between: pager_pages_between,
                                         items_per_page: pager_items_per_page,
                                         pager_path: items_path)
    @pager_params = PagerPresenter.new(pager_params: pager_params, user: current_user, view_context: view_context)
    items = Item.page_for(page: page, order_by: :item_name, items_per_page: pager_items_per_page)
    @items = items.presenter(user: current_user, view_context: view_context)
  end

  # GET /items/1 or /items/1.json
  def show; end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit; end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_url, notice: 'Item was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_url, notice: 'Item was successfully updated.' }
        format.json { render :index, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /items/1 or /items/1.json
  def archive
    @item.archive!

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully archived.' }
      format.json { head :no_content }
    end
  end

  # POST /items/1 or /items/1.json
  def unarchive
    @item.unarchive!

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully unarchived.' }
      format.json { head :no_content }
    end
  end

  # GET /items/search
  def search
    @items = Item.where('item_name ILIKE ?', "%#{params[:query]}%").order(:item_name)
    render partial: 'items/results', locals: { items: @items }, layout: false
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:item_name, :archived)
  end
end
