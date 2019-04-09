module ReferralValidations
  extend ActiveSupport::Concern

  included do
    validates :position, :location, presence: true
    validates :linkedin_profile_url,
              :job_posting_url,
              format: URI::regexp(%w(http https)),
              allow_blank: true

    validate :position_validations, :candidate_validations
  end

  def position_validations
    return unless step?("position")
    return if position && location || job_posting_url

    errors.add(
      :base,
      :blank,
      message: "Please specify either a Job posting URL or a position/location"
    )
  end

  def candidate_validations
    puts "CANDIDATE VALIDATIONS #{step?("candidate")}"
    return unless step?("candidate")
    return if first_name && last_name || linkedin_profile_url

    errors.add(
      :base,
      message: "Please add your name of linkedin profile"
    )
  end
end
