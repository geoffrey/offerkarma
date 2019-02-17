web: bin/rails server -p $PORT -e $RAILS_ENV
release: rails db:migrate
email_worker: bundle exec sidekiq -t 25 -q mailers
