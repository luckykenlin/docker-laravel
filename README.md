## Usage

Install laravel on root.

To get started, make sure you have [Docker installed](https://docs.docker.com/docker-for-mac/install/) on your system, and then clone this repository.

Next, navigate in your terminal to the directory you cloned this, and spin up the containers for the web server by running `docker-compose up -d --build site`.

Bringing up the Docker Compose network with `site` instead of just using `up`, ensures that only our site's containers are brought up at the start, instead of all of the command containers as well. The following are built for our web server, with their exposed ports detailed:

- **nginx** - `:80`
- **mysql** - `:3306`
- **php** - `:9000`

Three additional containers are included that handle Composer, NPM, and Artisan commands *without* having to have these platforms installed on your local computer. Use the following command examples from your project root, modifying them to fit your particular use case.

- `docker-compose exec app composer install`
- `docker-compose exec app php artisan key:generate`

For production

step 1: prepare app image via app.dockerfile
step 2: prepare web image via web.dockerfile

- `docker-compose -f docker-compose.production.yml up -d --build`

docker run watchtower
watchtower will restart container if app or web image update.

