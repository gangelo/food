# frozen_string_literal: true

# The shopping list presenter for this application.
class ShoppingListPresenter < Presenter
  def display_name
    shopping_list_name
  end

  def display_week_of
    week_of.strftime('%m/%d/%Y')
  end

  def display_type
    type = if template?
             'Template'
           else
             'Shopping list'
           end
    vc.content_tag(:span, type, class: type_css_class)
  end

  private

  def type_css_class
    'badge rounded-pill text-bg-danger' if template?
  end
end
