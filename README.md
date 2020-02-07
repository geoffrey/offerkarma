## OfferKarma

Get anonymous feedback on your job offers


## Dev

Clone this repo:

```sh
git clone https://github.com/geoffrey/offerkarma.git
cd offerkarma
cp .env.development.default .env
```

Start server:
```sh
brew install yarn rbenv postgresql
rbenv install
bundle install
yarn install
bin/rails s
```

Console:
```sh
bin/rails c
```


### Deployment

Simple merge/push to master and Heroku will automatically deploy the branch master and run the necessary migrations.

### Heroku

- `brew install heroku/brew/heroku`
- `heroku login`
- `heroku git:remote -a offerkarma`

#### Run command on Heroku:

`heroku run <command>`

E.g.: `heroku run rails console`

### Docker

```sh
make build
make up
make shell
```


