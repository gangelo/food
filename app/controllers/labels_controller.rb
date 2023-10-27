# frozen_string_literal: true

# The controller for item labels.
class LabelsController < ApplicationController
  include ItemSearchConcern

  before_action :authenticate_user!
  before_action :set_label, only: %i[edit update archive unarchive]

  # GET /labels or /labels.json
  def index
    page = params[:page].to_i
    pager_params = Label.pager_params_for(page: page,
                                          pages_between: pager_pages_between,
                                          items_per_page: pager_items_per_page,
                                          pager_path: labels_path)
    @pager_params = PagerPresenter.new(pager_params: pager_params, user: current_user, view_context: view_context)
    labels = Label.page_for(page: page,
                            order_by: [label_name: :ASC],
                            items_per_page: pager_items_per_page)
    @labels = PresenterDecorator.new(resource: labels,
                                     user: current_user,
                                     view_context: view_context)
  end

  # GET /labels/1 or /labels/1.json
  def show
    label = Label.find(params[:id])
    @label = PresenterDecorator.new(resource: label, user: current_user, view_context: view_context)
  end

  # GET /labels/new
  def new
    label = Label.new
    @label = PresenterDecorator.new(resource: label, user: current_user, view_context: view_context)
    render layout: 'label'
  end

  # GET /labels/1/edit
  def edit
    render layout: 'label'
  end

  # POST /labels or /labels.json
  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_url, notice: 'Label was successfully created.'
    else
      @label = PresenterDecorator.new(resource: @label, user: current_user, view_context: view_context)
      render :new, status: :unprocessable_entity, layout: 'label'
    end
  end

  # PATCH/PUT /labels/1 or /labels/1.json
  def update
    Rails.logger.info("xyzzy: params: #{params.inspect}")
    Rails.logger.info("xyzzy: label_params: #{label_params.inspect}")

    ActiveRecord::Base.transaction do
      @label.item_labels.clear
      if @label.update(label_params)
        redirect_to labels_url, notice: 'Label was successfully updated.'
      else
        render :edit, status: :unprocessable_entity, layout: 'label'
        raise ActiveRecord::Rollback
      end
    end
  rescue StandardError => e
    Rails.logger.error("xyzzy: class: #{e.class}, error: #{e.message}")

    flash[:alert] = 'An error occurred and the label could not be updated. No more information is available.'
    render :edit, status: :unprocessable_entity, layout: 'label'
  end

  # DELETE /labels/1 or /labels/1.json
  def destroy
    label = Label.find_by(id: params[:id])
    if label
      label.destroy
      redirect_to labels_url, notice: 'Label was successfully destroyed.'
    else
      redirect_to labels_url,
                  status: :not_found,
                  alert: 'The label could not not found.'
    end
  end

  # GET /labels/search
  def search
    locals = {
      search_results: @search_results,
      javascript_controller: 'label-items'
    }
    render partial: 'shared/item_search_results', locals: locals, layout: false
  end

  # POST /labels/1 or /labels/1.json
  def archive
    @label.archive!

    respond_to do |format|
      format.html { redirect_to labels_url, notice: 'Label was successfully archived.' }
      format.json { head :no_content }
    end
  end

  # POST /labels/1 or /labels/1.json
  def unarchive
    @label.unarchive!

    respond_to do |format|
      format.html { redirect_to labels_url, notice: 'Label was successfully unarchived.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_label
    label = Label.find(params[:id])
    @label = PresenterDecorator.new(resource: label, user: current_user, view_context: view_context)
  end

  def label_params
    params[:label]&.delete(:query)
    params[:label]&.delete(:item_ids)
    params.require(:label).permit(
      :label_name,
      :archived,
      item_labels_attributes: [:item_id]
    )
  end
end
