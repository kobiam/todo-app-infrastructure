# Use official PostgreSQL base image
FROM postgres:15

# Set environment variables (optional here – best passed via ARM or GitHub Actions)
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=todoapp

# Expose PostgreSQL port
EXPOSE 5432

# Volume for data (ephemeral in ACA unless mounted to Azure File)
VOLUME ["/var/lib/postgresql/data"]
