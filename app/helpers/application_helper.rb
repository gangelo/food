# frozen_string_literal: true

# This is the helper file for the application.
module ApplicationHelper
  # Returns the disabled css class to disable the control if the current page
  # is equal to path.
  #
  # Usage:
  #
  # <%= link_to "Sign-up",
  #     new_user_registration_path,
  #     class: "btn btn-warning #{disabled_if_current_page(new_user_registration_path)}"
  # %>
  def disabled_if_current_page(path)
    'disabled' if current_page?(path)
  end
end
