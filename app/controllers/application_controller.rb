# frozen_string_literal: true

# The application controller for this application.
class ApplicationController < ActionController::Base
  add_flash_types :info, :warn

  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_session_timeout
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end
  end

  # def after_sign_in_path_for(resource)
  #   <some>_path
  # end

  private

  def pager_params_for(resource:, pager_path:)
    page = params[:page].to_i
    pager_params = Pageable.pager_params_for(
      resource,
      page: page,
      pages_between: pager_pages_between,
      items_per_page: pager_items_per_page,
      pager_path: pager_path
    )
    PagerPresenter.new(pager_params: pager_params, user: current_user, view_context: view_context)
  end

  def page_for(resource:, page:, order_by:)
    Pageable.page_for(resource,
                      page: page,
                      order_by: order_by,
                      items_per_page: pager_items_per_page)

  end

  # Pagination default items per page.
  def pager_items_per_page
    8
  end

  # Pagination default number of pages between the
  # Previous and Next buttons.
  def pager_pages_between
    5
  end

  def handle_session_timeout
    if request.format.html?
      redirect_to new_user_session_path, alert: 'Your session has expired. Please log in again.'
    else
      response.headers['Turbo-Stream-Location'] = new_user_session_path
      render json: { error: 'session_expired' }, status: :unauthorized
    end
  end
end
