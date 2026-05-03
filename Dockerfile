ARG RUBY_VERSION=3.4.7
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# System dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libjemalloc2 \
    libpq-dev \
    libvips \
    libyaml-dev \
    pkg-config \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Environment
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development test" \
    LD_PRELOAD=/usr/local/lib/libjemalloc.so

# Jemalloc
RUN ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so

# ---------------- BUILD STAGE ----------------
FROM base AS build

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

# Precompile bootsnap
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# ---------------- FINAL STAGE ----------------
FROM base

# Create non-root user
RUN groupadd -g 1000 rails && \
    useradd -u 1000 -g 1000 -m rails

USER rails

WORKDIR /rails

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

EXPOSE 3000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

CMD ["bin/rails", "server", "-b", "0.0.0.0"]