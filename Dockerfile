FROM node:20-bullseye-slim

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
RUN npm ci
RUN npm install pg --save

# Copy the full project
COPY . .

# Build Strapi (build TypeScript → dist/)
RUN npm run build

# Clean up dev dependencies after build
RUN npm prune --production

# Create non-root user
RUN groupadd -r strapi && useradd -r -g strapi strapi
RUN chown -R strapi:strapi /app
USER strapi

EXPOSE 1337

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:1337/_health || exit 1

# Start Strapi in production mode
CMD ["npm", "run", "start"]
