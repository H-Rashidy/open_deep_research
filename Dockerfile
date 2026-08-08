FROM python:3.11-slim

WORKDIR /app

# Install uv for fast dependency management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# 1. Copy ALL code first so Python can find the 'src/' folder during installation
COPY . .

# 2. Install project dependencies
RUN uv sync --no-cache --no-dev

# 3. Install the LangGraph CLI inside the virtual environment
RUN uv pip install "langgraph-cli[inmem]"

# Activate the virtual environment by adding it to PATH
ENV PATH="/app/.venv/bin:$PATH"

# Expose the port (Railway will use its own $PORT variable dynamically)
EXPOSE 8000

# Start the server using langgraph dev, listening on the $PORT Railway provides
CMD langgraph dev --host 0.0.0.0 --port ${PORT:-8000}
