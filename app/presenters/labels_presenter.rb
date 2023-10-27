# frozen_string_literal: true

# The labelss presenter to display a collection of
# LabelPresenter objects.
class LabelsPresenter < Presenter
  def presenters
    @presenters ||= map do |label|
      label.presenter(user: user, view_context: view_context, options: options)
    end.sort_by(&:label_name)
  end
end
