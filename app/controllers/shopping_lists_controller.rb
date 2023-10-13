# frozen_string_literal: true

# The controller for shopping lists.
class ShoppingListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shopping_list, only: %i[edit update destroy]

  # GET /shopping_lists or /shopping_lists.json
  def index
    page = params[:page].to_i
    pager_params = ShoppingList.pager_params_for(page: page,
                                                 pages_between: pager_pages_between,
                                                 items_per_page: pager_items_per_page,
                                                 pager_path: shopping_lists_path)
    @pager_params = PagerPresenter.new(pager_params: pager_params, user: current_user, view_context: view_context)
    order_by = [week_of: :desc, shopping_list_name: :asc]
    shopping_lists = ShoppingList.page_for(page: page, order_by: order_by, items_per_page: pager_items_per_page)
    @shopping_lists = shopping_lists.presenter(user: current_user, view_context: view_context)
    Rails.logger.debug("xyzzy: @pager_params: #{@pager_params.inspect}")
  end

  # GET /shopping_lists/1 or /shopping_lists/1.json
  def show
    @shopping_list = ShoppingList.find(params[:id]).presenter(user: current_user, view_context: view_context)
  end

  # GET /shopping_lists/new
  def new
    @shopping_list = ShoppingList.new
  end

  # GET /shopping_lists/1/edit
  def edit; end

  # POST /shopping_lists or /shopping_lists.json
  def create
    @shopping_list = ShoppingList.new(shopping_list_params)

    respond_to do |format|
      if @shopping_list.save
        format.html { redirect_to shopping_list_url(@shopping_list), notice: 'Shopping list was successfully created.' }
        format.json { render :show, status: :created, location: @shopping_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shopping_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shopping_lists/1 or /shopping_lists/1.json
  def update
    respond_to do |format|
      if @shopping_list.update(shopping_list_params)
        format.html { redirect_to shopping_list_url(@shopping_list), notice: 'Shopping list was successfully updated.' }
        format.json { render :show, status: :ok, location: @shopping_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shopping_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_lists/1 or /shopping_lists/1.json
  def destroy
    @shopping_list.destroy

    respond_to do |format|
      format.html { redirect_to shopping_lists_url, notice: 'Shopping list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shopping_list_params
    params.require(:shopping_list).permit(:shopping_list_name, :week_of, :notes, :template)
  end
end
