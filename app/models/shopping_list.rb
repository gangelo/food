# frozen_string_literal: true

# The shopping list model.
class ShoppingList < ApplicationRecord
  include PagableConcern

  has_many :user_shopping_lists, dependent: :destroy
  has_many :users, through: :user_shopping_lists

  validates :shopping_list_name, presence: true, length: { maximum: 512 }
  validates :week_of, presence: true
  validate :week_of_cannot_be_in_the_past, if: -> { week_of.present? }
  validate :week_of_cannot_be_too_far_into_the_future, if: -> { week_of.present? }
  validates :notes, length: { maximum: 512 }
  validates :shopping_list_name, uniqueness: { scope: :week_of, case_sensitive: false }


  attr_accessor :query

  def template?
    template
  end

  def shopping_list?
    !template?
  end

  def week_of=(date)
    return if date.is_a?(Date)

    self[:week_of] = begin
      Date.strptime(date, '%m/%d/%Y')
    rescue StandardError
      nil
    end
  end

  private

  def week_of_cannot_be_in_the_past
    return if week_of >= Date.today

    errors.add(:week_of, :in_the_past)
  end

  def week_of_cannot_be_too_far_into_the_future
    return if week_of < 1.month.from_now

    errors.add(:week_of, :in_the_future)
  end
end
