user = User.create!(email: "admin@reffo.us", password: "password", password_confirmation: "password")
user2 = User.create!(email: "hello@reffo.us", password: "password", password_confirmation: "password")

eaze = Company.create!(name: "eaze", domain: "eaze.com")
sharespost = Company.create!(name: "sharespost", domain: "sharespost.com")
instacart = Company.create!(name: "instacart", domain: "instacart.com")
Company.create!(name: "checkr", domain: "checkr.com")
Company.create!(name: "slack", domain: "slack.com")
Company.create!(name: "remind", domain: "remind.com")
Company.create!(name: "coinbase", domain: "coinbase.com")
Company.create!(name: "stripe", domain: "stripe.com")

Offer.create!(user: user, company: instacart, base_salary: 180000, stock_type: :rsus, stock_count: 20000, stock_fair_market_value: 30.00, position: "Senior Software Engineer", status: "pending")
Offer.create!(user: user2, company: sharespost, base_salary: 180000, stock_type: :option, stock_count: 50000, stock_fair_market_value: 2.00, stock_strike_price: 1.3, position: "Senior Software Engineer", status: "pending")
Offer.create!(user: user2, company: eaze, base_salary: 185000, position: "Senior Software Engineer", status: "pending")
