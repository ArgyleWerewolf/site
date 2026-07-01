# Argyle Werewolf

Angela Quinton's [personal site](https://www.argylewerewolf.com). Phoenix LiveView without a database or Tailwind.

## Prerequisites

### Local Development: Elixir 1.18.4 and Erlang 27.2

If you use [asdf](https://asdf-vm.com/guide/getting-started.html), you can install the development versions by running `asdf install` in the root of the project.

**Note**: Render uses Elixir 1.16.1 and Erlang 24.x by default for this service (created May 2025). The project supports Elixir >= 1.12. I should just rebuild the Render service to get on a newer version, but I don't have the appetite for that right now.

## Get running

1. run `mix setup`. This will
   - fetch all dependencies
   - set up and compile all front-end assets
2. run `mix phx.server`. This will start the application at [http://localhost:4000](http://localhost:4000).
