FROM python:3.11-slim

WORKDIR /app

# Install uv for fast dependency management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy dependency files first for better caching
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync --no-cache --no-dev

# Copy the rest of the application code
COPY . .

# Add virtual environment to PATH
ENV PATH="/app/.venv/bin:$PATH"

# Expose the port Railway uses
EXPOSE 8000

# Start the server using langgraph dev (more robust for custom containers)
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "8000"]
