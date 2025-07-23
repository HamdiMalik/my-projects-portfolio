# Skin Check Backend - WSL Ubuntu Deployment

Backend API untuk aplikasi skin check dengan TensorFlow model.

## Prerequisites

- WSL Ubuntu
- Docker installed
- Model file `keras_Model.h5` dan `labels.txt` di folder `models/`

## Quick Start

### 1. Clone dan masuk ke direktori
```bash
cd skin_check_api
```

### 2. Pastikan model files ada
```bash
ls models/
# Harus ada: keras_Model.h5 dan labels.txt
```

### 3. Jalankan backend
```bash
chmod +x run_backend.sh
./run_backend.sh
```

### 4. Test API
```bash
curl http://localhost:5000/api/v1/health
```

## Manual Deployment

### Build Docker Image
```bash
docker build -t skincheck-backend .
```

### Run Container
```bash
docker run -d \
  --name skincheck-backend \
  -p 5000:5000 \
  -v $(pwd)/uploads:/app/uploads \
  -v $(pwd)/models:/app/models \
  skincheck-backend
```

## API Endpoints

- `GET /api/v1/health` - Health check
- `POST /api/v1/scan` - Upload dan analisis gambar kulit

### Test Scan Endpoint
```bash
curl -X POST \
  -F "image=@test_image.jpg" \
  http://localhost:5000/api/v1/scan
```

## Useful Commands

```bash
# View logs
docker logs -f skincheck-backend

# Stop container
docker stop skincheck-backend

# Restart container
docker restart skincheck-backend

# Remove container
docker rm skincheck-backend

# Remove image
docker rmi skincheck-backend
```

## Troubleshooting

### TensorFlow Import Error
Jika ada error TensorFlow, pastikan:
1. Docker image sudah di-build ulang
2. Model files ada di folder `models/`

### Port Already in Use
```bash
# Check what's using port 5000
sudo netstat -tulpn | grep :5000

# Kill process if needed
sudo kill -9 <PID>
```

### Permission Issues
```bash
# Fix file permissions
chmod +x run_backend.sh
chmod 755 uploads/ models/
```

## Environment Variables

- `FLASK_ENV=production`
- `TF_CPP_MIN_LOG_LEVEL=2` - Reduce TensorFlow logging
- `PYTHONPATH=/app`

## Model Requirements

- `keras_Model.h5` - TensorFlow Keras model
- `labels.txt` - Class labels (one per line)

Model harus kompatibel dengan TensorFlow 2.15.0 dan input shape (1, 224, 224, 3). 