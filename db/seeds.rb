user = User.create!(email: "admin@reffo.us", password: "password", password_confirmation: "password")

eaze = Company.create!(name: "eaze", url: "eaze.com")
sharespost = Company.create!(name: "sharespost", url: "sharespost.com")
instacart = Company.create!(name: "instacart", url: "instacart.com")
Company.create!(name: "checkr", url: "checkr.com")
Company.create!(name: "slack", url: "slack.com")
Company.create!(name: "remind", url: "remind.com")
Company.create!(name: "coinbase", url: "coinbase.com")
Company.create!(name: "stripe", url: "stripe.com")

Offer.create!(user: user, company: eaze, base_salary: 185000, position: "Senior Software Engineer", status: "pending")
Offer.create!(user: user, company: sharespost, base_salary: 180000, position: "Senior Software Engineer", status: "pending")
Offer.create!(user: user, company: instacart, base_salary: 180000, position: "Senior Software Engineer", status: "pending")
