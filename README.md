# AnalysisService

This repository provides the following features:
	* Uses docker-compose Version 2 syntax and features (https://docs.docker.com/compose/)
	* Built from compact alpine docker image for minimal footprint
	* A starting point for quickly bootstrapping an Elixir/Phoenix app with common dependancies
	* A Ready-To-Go Postgresql database container instance

To start this app:

  * Clone the repository
  * Create and migrate your database with `docker compose run web mix ecto.create && mix ecto.migrate`
  * The application will come up in a docker container

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
  * Docker docs https://docs.docker.com/compose/
