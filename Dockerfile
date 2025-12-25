# =====================================================
# STAGE 1 — Build & Validate Web Content
# =====================================================
FROM nginx:alpine AS build

# Temporary working directory
WORKDIR /site

# Copy all web files into build stage
COPY . .

# Validate that index.html exists
RUN if [ ! -f index.html ]; then \
        echo "ERROR: index.html not found"; exit 1; \
    else \
        echo "Web files validated successfully"; \
    fi

# =====================================================
# STAGE 2 — NGINX Runtime
# =====================================================
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy validated files from build stage
COPY --from=build /site/ /usr/share/nginx/html/

# Expose HTTP port
EXPOSE 80

# NGINX starts automatically
CMD ["nginx", "-g", "daemon off;"]
