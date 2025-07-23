#!/usr/bin/env python3
"""
Test script untuk endpoint scan
"""
import requests
import os

def test_scan_endpoint():
    # URL ngrok (ganti dengan URL Anda)
    base_url = "https://01fdf984a18d.ngrok-free.app"
    scan_url = f"{base_url}/api/v1/scans/scan"
    
    # Test dengan file dummy (buat file test.jpg kecil)
    test_image_path = "test_image.jpg"
    
    # Buat file test sederhana jika tidak ada
    if not os.path.exists(test_image_path):
        from PIL import Image
        import numpy as np
        
        # Buat gambar test sederhana
        img_array = np.random.randint(0, 255, (100, 100, 3), dtype=np.uint8)
        img = Image.fromarray(img_array)
        img.save(test_image_path)
        print(f"Created test image: {test_image_path}")
    
    try:
        # Upload file
        with open(test_image_path, 'rb') as f:
            files = {'image': f}
            print(f"Testing scan endpoint: {scan_url}")
            response = requests.post(scan_url, files=files, timeout=30)
        
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.text}")
        
        if response.status_code == 200:
            print("✅ Scan endpoint working!")
        else:
            print("❌ Scan endpoint failed!")
            
    except Exception as e:
        print(f"❌ Error testing scan endpoint: {e}")

if __name__ == "__main__":
    test_scan_endpoint() 