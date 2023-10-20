# frozen_string_literal: true

# The controller for shopping lists.
class UserShoppingListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shopping_list, only: %i[edit update]
  before_action :set_user_shopping_list_items_json, only: %i[edit update]

  # GET /user/user_shopping_lists or /user/user_shopping_lists.json
  def index
    page = params[:page].to_i
    pager_params = current_user.user_shopping_lists.pager_params_for(page: page,
                                                                     pages_between: pager_pages_between,
                                                                     items_per_page: pager_items_per_page,
                                                                     pager_path: user_shopping_lists_path)
    @pager_params = PagerPresenter.new(pager_params: pager_params, user: current_user, view_context: view_context)
    order_by = Arel.sql('shopping_lists.week_of DESC, shopping_lists.shopping_list_name ASC')
    user_shopping_lists = current_user.user_shopping_lists
                                      .joins(:shopping_list)
                                      .page_for(page: page,
                                                order_by: order_by,
                                                items_per_page: pager_items_per_page)
    @user_shopping_lists = PresenterDecorator.new(resource: user_shopping_lists,
                                                  user: current_user,
                                                  view_context: view_context)
  end

  # GET /user/shopping_lists/1 or /user/shopping_lists/1.json
  def show
    shopping_list = ShoppingList.find(params[:id])
    @shopping_list = PresenterDecorator.new(resource: shopping_list, user: current_user, view_context: view_context)
  end

  # GET /user/shopping_lists/new
  def new
    @shopping_list = PresenterDecorator.new(resource: ShoppingList.new, user: current_user, view_context: view_context)
    render layout: 'shopping_list'
  end

  # GET /user/shopping_lists/1/edit
  def edit
    render layout: 'shopping_list'
  end

  # POST /user/user_shopping_lists or /user/user_shopping_lists.json
  def create
    shopping_list = nil

    results = ActiveRecord::Base.transaction do
      shopping_list = ShoppingList.new(shopping_list_params)
      shopping_list.save!

      user_shopping_list = current_user.user_shopping_lists.build(shopping_list: shopping_list)
      user_shopping_list.save!

      user_shopping_list.user_shopping_list_items = []
      params[:item_ids].each do |item_id|
        user_shopping_list_item = user_shopping_list.user_shopping_list_items.build(item_id: item_id, user_shopping_list: user_shopping_list)
        user_shopping_list_item.save!
      end

      true
    rescue StandardError => e
      Rails.logger.debug('xyzzy: An error occurred and a rollback is being initiated.')
      Rails.logger.debug("xyzzy: class: #{e.class}, error: #{e.message}")

      raise ActiveRecord::Rollback
    end

    @shopping_list = PresenterDecorator.new(resource: shopping_list, user: current_user, view_context: view_context)
    if results
      redirect_to user_shopping_lists_url, notice: 'Shopping list was successfully created.'
    else
      render :new, status: :unprocessable_entity, layout: 'shopping_list'
    end
  end

  # PATCH/PUT /user/shopping_lists/1 or /user/shopping_lists/1.json
  def update
    user_shopping_list = nil

    Rails.logger.debug("xyzzy: UserShoppingListsController#update: params: #{params.inspect}")

    results = ActiveRecord::Base.transaction do
      @shopping_list.update!(shopping_list_params)

      user_shopping_list = current_user.user_shopping_lists.find(params[:id])
      user_shopping_list.user_shopping_list_items = []
      params[:selected_item_ids]&.each do |item_id|
        user_shopping_list_item = user_shopping_list.user_shopping_list_items
                                                    .build(item_id: item_id,
                                                           user_shopping_list: user_shopping_list)
        user_shopping_list_item.save!
      end

      user_shopping_list.save!

      true
    rescue StandardError => e
      Rails.logger.debug('xyzzy: An error occurred and a rollback is being initiated.')
      Rails.logger.debug("xyzzy: class: #{e.class}, error: #{e.message}")

      raise ActiveRecord::Rollback
    end

    if results
      redirect_to user_shopping_lists_url, notice: 'Shopping list was successfully created.'
    else
      flash[:alert] = user_shopping_list.errors.full_messages
      render :edit, status: :unprocessable_entity, layout: 'shopping_list'
    end
  end

  # DELETE /user/shopping_lists/1 or /user/shopping_lists/1.json
  def destroy
    user_shopping_list = UserShoppingList.find_by(id: params[:id])
    if user_shopping_list
      user_shopping_list.destroy
      redirect_to user_shopping_lists_url, notice: 'Shopping list was successfully destroyed.'
    else
      redirect_to user_shopping_lists_url,
                  status: :not_found,
                  alert: 'The shopping list could not not found.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shopping_list
    shopping_list = UserShoppingList.find(params[:id]).shopping_list
    @shopping_list = PresenterDecorator.new(resource: shopping_list, user: current_user, view_context: view_context)
  end

  def set_user_shopping_list_items_json
    @user_shopping_list_items_json = []
    return if params[:id].blank?

    @user_shopping_list_items_json = UserShoppingList.find(params[:id]).to_hash[:user_shopping_list_items].to_json
  end

  # Only allow a list of trusted parameters through.
  def shopping_list_params
    filtered_params = params.except(:query)

    filtered_params.require(:shopping_list).permit(
      :shopping_list_name,
      :week_of,
      :template,
      :notes
    )
  end
end
