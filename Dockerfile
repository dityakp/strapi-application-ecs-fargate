FROM public.ecr.aws/docker/library/node:20-bullseye-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json* ./

# Install all dependencies including pg
RUN npm install
RUN npm install pg --save

# Copy the full project
COPY . .

# Set environment variables for build
ENV NODE_ENV=production
ENV DATABASE_CLIENT=postgres
ENV HOST=0.0.0.0
ENV PORT=1337
ENV APP_KEYS=dummy-key-for-build
ENV API_TOKEN_SALT=dummy-salt-for-build
ENV ADMIN_JWT_SECRET=dummy-secret-for-build
ENV TRANSFER_TOKEN_SALT=dummy-salt-for-build
ENV JWT_SECRET=dummy-secret-for-build

# Build the application
RUN npm run build

# Create non-root user and set permissions BEFORE pruning
RUN groupadd -r strapi && useradd -r -g strapi strapi -m
RUN chown -R strapi:strapi /app

# Clean up dev dependencies after build (but keep pg)
RUN npm prune --production
RUN npm install pg --save --production

# Switch to non-root user
USER strapi

EXPOSE 1337

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:1337/_health || exit 1

# Start Strapi in production mode
CMD ["npm", "run", "start"]
