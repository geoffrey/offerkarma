module OfferValidations
  extend ActiveSupport::Concern
  attr_writer :current_step

  included do
    validates_presence_of :position, :location, if: Proc.new { step?("position") }
    validates_presence_of :base_salary, if: Proc.new { step?("cash") }
  end
end
