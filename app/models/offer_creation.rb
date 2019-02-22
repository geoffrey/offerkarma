module OfferCreation
  extend ActiveSupport::Concern
  attr_writer :current_step

  included do
    validates_presence_of :position, :location, if: Proc.new { step?("position") }
    validates_presence_of :base_salary, if: Proc.new { step?("cash") }
  end

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[position cash equity misc]
  end

  def next_step
    self.current_step = steps[current_step_index+1]
  end

  def previous_step
    self.current_step = steps[current_step_index-1]
  end

  def current_step_index
    steps.index(current_step)
  end

  def step?(step)
    current_step == step
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
