FROM python:3.11-slim

WORKDIR /app

# 1. Copy ALL code first so Python can find the 'src' folder during installation
COPY . .

# 2. Install uv (the package manager)
RUN pip install uv

# 3. Install project dependencies
RUN uv sync --no-cache --no-dev

# 4. Install the Production LangGraph API server and Postgres runtime
RUN uv pip install "langgraph-api" "langgraph-runtime-postgres" "psycopg[binary]" "redis"

# Activate the virtual environment
ENV PATH="/app/.venv/bin:$PATH"

# Expose the port
EXPOSE 8000

# Tell the server where the graph is located
ENV LANGSERVE_GRAPHS='{"Deep Researcher": "./src/open_deep_research/deep_researcher.py:deep_researcher"}'

# Start the production server! (It will automatically detect DATABASE_URI and use Postgres)
CMD langgraph-api --host 0.0.0.0 --port ${PORT:-8000}
