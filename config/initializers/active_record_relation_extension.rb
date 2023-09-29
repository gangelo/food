# frozen_string_literal: true

# The relation extensions for this application.
# This extension adds a presenter method to all ActiveRecord::Relation objects.
module RelationExtensions
  def presenter(user:, view_context:, options: nil)
    puts "RelationExtensions#presenter_klass_name: #{presenter_klass_name}" if Rails.env.development?
    options ||= {}
    presenter_klass.new(resource: self, view_context: view_context, user: user, options: options)
  rescue NameError => e
    Rails.logger.warn("No presenter found for \"#{presenter_klass_name}\": #{e.message}")
  end

  def presenter_klass
    presenter_klass_name.constantize
  end

  def presenter_klass_name
    "#{model.name.pluralize}Presenter"
  end
end

ActiveRecord::Relation.include(RelationExtensions)
