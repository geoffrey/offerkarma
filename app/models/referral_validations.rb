module ReferralValidations
  extend ActiveSupport::Concern

  included do
    validates :linkedin_profile_url,
              format: URI::regexp(%w(http https)),
              if: Proc.new { step?("candidate") }

    validates :job_posting_url,
              format: URI::regexp(%w(http https)),
              if: Proc.new { step?("position") },
              allow_blank: true

    validates_presence_of :position, :location, if: Proc.new { step?("position") }
  end
end
