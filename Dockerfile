FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv cleanly
ADD https://astral.sh/uv/install.sh /uv-bootstrap.sh
RUN sh /uv-bootstrap.sh && rm /uv-bootstrap.sh
ENV PATH="/root/.local/bin/:${PATH}"

WORKDIR /app
ENV UV_COMPILE_BYTECODE=1

# Copy lock and project files
COPY pyproject.toml uv.lock ./

# Install project requirements cleanly, bypassing package builds
RUN uv sync --frozen --no-dev --no-install-project

# Copy application files
COPY app.py ./
COPY templates/ ./templates/

ENV PORT=8080
EXPOSE 8080

CMD ["uv", "run", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
