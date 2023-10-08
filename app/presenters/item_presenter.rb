# frozen_string_literal: true

# The item presenter for this application.
class ItemPresenter < Presenter
  def display_name
    vc.content_tag(:span, item_name, class: css_class)
  end

  def display_archived
    archived = archived? ? 'Archived' : 'Active'
    vc.content_tag(:span, archived, class: css_class)
  end

  private

  def css_class
    'archived' if archived?
  end
end
