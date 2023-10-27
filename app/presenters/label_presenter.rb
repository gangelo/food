# frozen_string_literal: true

# The label presenter for this application.
class LabelPresenter < Presenter
  # def shopping_list_presenter
  #   shopping_list.presenter(user: user, view_context: view_context)
  # end

  def items_json
    to_hash[:items].to_json
  end

  def display_name
    vc.content_tag(:span, label_name, class: css_class)
  end

  def display_archived
    archived = archived? ? 'Archived' : 'Active'
    vc.content_tag(:span, archived, class: css_class)
  end

  def display_archived_yes_no
    archived = archived? ? 'Yes' : 'No'
    vc.content_tag(:span, archived, class: css_class)
  end

  private

  def css_class
    'archived' if archived?
  end
end
