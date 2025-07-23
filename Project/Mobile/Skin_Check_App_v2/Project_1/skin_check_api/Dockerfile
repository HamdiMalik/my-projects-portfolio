FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies for TensorFlow
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libhdf5-dev \
    libhdf5-serial-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create directories
RUN mkdir -p uploads models

# Expose port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
