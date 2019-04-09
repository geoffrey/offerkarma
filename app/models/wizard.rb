module Wizard
  attr_writer :current_step

  def current_step
    @current_step || wizard_steps.first
  end

  def next_step
    self.current_step = wizard_steps[current_step_index+1]
  end

  def previous_step
    self.current_step = wizard_steps[current_step_index-1]
  end

  def current_step_index
    wizard_steps.index(current_step)
  end

  def step?(step)
    current_step == step
  end

  def first_step?
    current_step == wizard_steps.first
  end

  def last_step?
    current_step == wizard_steps.last
  end

  def all_valid?
    wizard_steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
