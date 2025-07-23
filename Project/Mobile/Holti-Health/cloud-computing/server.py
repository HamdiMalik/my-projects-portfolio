from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import JSONResponse
import tensorflow as tf
import numpy as np
from PIL import Image
import uvicorn
import os

# Inisialisasi FastAPI
app = FastAPI()

# Muat model
model = None
class_names = [
    'Bercak Daun',
    'Busuk Buah Antraknosa',
    'Kutu Daun',
    'Sehat',
    'Thrips',
    'Virus Kuning'
]

def load_model():
    global model
    model_path = "E:/API-HOLTIHEAL/model/model.h5"
    model = tf.keras.models.load_model(model_path)
    print("Model loaded successfully!")

load_model()

# Fungsi prediksi gambar
def predict_image(image: Image.Image):
    try:
        # Resize gambar ke (224, 224)
        image = image.resize((224, 224))
        image_array = np.array(image) / 255.0  # Normalisasi
        input_tensor = np.expand_dims(image_array, axis=0)  # Tambahkan dimensi batch
        
        # Prediksi
        predictions = model.predict(input_tensor)
        predicted_class_index = np.argmax(predictions, axis=-1)[0]
        predicted_class = class_names[predicted_class_index]
        
        # Buat respons informatif
        confidence_percentage = predictions[0][predicted_class_index] * 100  # Ubah ke persentase
        return predicted_class, confidence_percentage
    except Exception as e:
        raise ValueError(f"Error during prediction: {str(e)}")

# Endpoint untuk prediksi
@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    # Validasi tipe file
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="Invalid file type. Please upload an image.")
    
    try:
        # Baca file gambar
        image = Image.open(file.file)
        
        # Lakukan prediksi
        prediction, confidence_percentage = predict_image(image)
        
        # Respons yang lebih menarik
        response = {
            "status": "success",
            "message": "Prediksi berhasil dilakukan!",
            "prediction": prediction,
            "confidence": f"{confidence_percentage:.2f}%",  # Format ke 2 desimal
            "explanation": f"Berdasarkan analisis model, gambar ini diprediksi sebagai '{prediction}' dengan kepercayaan {confidence_percentage:.2f}%."
        }
        
        return JSONResponse(content=response)
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Gagal memproses gambar: {e}")

# Jalankan server
if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)
