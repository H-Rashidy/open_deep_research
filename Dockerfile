FROM python:3.11-slim

WORKDIR /app

# 1. Copy ALL files first so Python can find the 'src' folder
COPY . .

# 2. Install uv (the package manager)
RUN pip install uv

# 3. Install dependencies and create the virtual environment
RUN uv sync --no-cache --no-dev

# 4. Install the LangGraph CLI inside the virtual environment
RUN uv pip install "langgraph-cli[inmem]"

# 5. Add virtual environment to PATH so the 'langgraph' command works
ENV PATH="/app/.venv/bin:$PATH"

# 6. Expose the port
EXPOSE 8000

# 7. Start the server (Railway dynamically assigns the $PORT variable)
CMD langgraph dev --host 0.0.0.0 --port ${PORT:-8000}
