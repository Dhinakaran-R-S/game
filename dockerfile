# Base image with Elixir and Erlang
FROM elixir:1.18-alpine

# Install build tools
RUN apk add --no-cache build-base git

# Set workdir
WORKDIR /app

# Install Hex and Rebar (Elixir build tools)
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy project files
COPY . .

# Get dependencies
RUN mix deps.get

# Compile the project
RUN mix compile

# Set default command to run Elixir's interactive shell (or change it to run your app)
CMD ["iex", "-S", "mix"]
