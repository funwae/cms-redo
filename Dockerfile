# Build stage
FROM hexpm/elixir:1.14.0-erlang-25.0-alpine-3.16.0 AS build

# Install build dependencies
RUN apk add --no-cache build-base npm git

# Prepare build dir
WORKDIR /app

# Install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set build ENV
ENV MIX_ENV=prod

# Install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# Install npm dependencies
COPY assets/package*.json ./assets/
RUN cd assets && npm ci

# Copy priv dir for migrations
COPY priv ./priv

# Copy config files
COPY config ./config

# Compile assets
COPY assets ./assets
RUN mix assets.deploy

# Compile code
COPY lib ./lib
RUN mix compile

# Build release
RUN mix release

# Runtime stage
FROM alpine:3.16.0 AS runtime

# Install runtime dependencies
RUN apk add --no-cache \
    openssl \
    ncurses-libs \
    libstdc++

WORKDIR /app

# Create non-root user
RUN chown nobody:nobody /app

# Copy release from build stage
COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/code_my_spec ./

USER nobody:nobody

# Expose port
EXPOSE 4000

# Set environment
ENV MIX_ENV=prod
ENV PHX_SERVER=true

# Run migrations and start server
CMD ["/app/bin/code_my_spec", "start"]

