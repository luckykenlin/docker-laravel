## Usage

To get started, make sure you have [Docker installed](https://docs.docker.com/docker-for-mac/install/) on your system, and then clone this repository.

Next, navigate in your terminal to the directory you cloned this and Install laravel, make sure they are under the same root.

## Dev
Spin up the containers by running `docker-compose up -d`.

The following are built for our web server, with their exposed ports detailed:

- **nginx** - `:80`
- **mysql** - `:3306`
- **php** - `:9000`

Use the following command examples from your project root, modifying them to fit your particular use case.

- `docker-compose exec app composer install`
- `docker-compose exec app php artisan key:generate`

## Production

#### Step 1: prepare app image via app.dockerfile
#### Step 2: prepare web image via web.dockerfile
#### Step 3: copy production env file rename as .env.production under root directory

- `docker-compose -f docker-compose.production.yml up -d --build`

watchtower will restart container if app or web image update.

