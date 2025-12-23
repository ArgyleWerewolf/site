# Argyle Werewolf

Angela Quinton's [personal site](https://www.argylewerewolf.com). Phoenix LiveView without a database or Tailwind.

## Prerequisites

### erlang 27.2 and elixir 1.18.4-otp-27

If you use [asdf](https://asdf-vm.com/guide/getting-started.html), you can install the appropriate versions of Erlang and Elixir by running `asdf install` in the root of the project.

## Get running

1. run `mix setup`. This will
   - fetch all dependencies
   - set up and compile all front-end assets
2. run `mix phx.server`. This will start the application at [http://localhost:4000](http://localhost:4000).
