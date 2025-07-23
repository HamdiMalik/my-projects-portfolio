package com.holtihealth.app.ui.scan

import android.app.AlertDialog
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.camera.core.CameraSelector
import androidx.camera.core.ImageCapture
import androidx.camera.core.ImageCaptureException
import androidx.camera.core.Preview
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import com.holtihealth.app.MainActivity
import com.holtihealth.app.R
import com.holtihealth.app.createCustomTempFile
import com.holtihealth.app.databinding.ActivityCameraBinding

class CameraActivity : AppCompatActivity() {

    private lateinit var binding: ActivityCameraBinding
    private lateinit var imageCapture: ImageCapture
    private lateinit var preview: Preview

    private val openGalleryLauncher =
        registerForActivityResult(ActivityResultContracts.PickVisualMedia()) { uri ->
            uri?.let {
                openPreviewActivity(it, false)
            }
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityCameraBinding.inflate(layoutInflater)
        setContentView(binding.root)

        supportActionBar?.hide()

        startCamera()

        binding.closeCamera.setOnClickListener {
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
            finish()
        }

        binding.buttonSnapTips.setOnClickListener {
            showSnapTipsDialog()
        }
        binding.buttonOpenGallery.setOnClickListener {
            openGallery()
        }

        binding.buttonTakePicture.setOnClickListener {
            takePhoto()
        }
    }

    private fun startCamera() {
        val cameraProviderFuture = ProcessCameraProvider.getInstance(this)

        cameraProviderFuture.addListener({
            val cameraProvider = cameraProviderFuture.get()

            preview = Preview.Builder()
                .build()

            imageCapture = ImageCapture.Builder()
                .build()

            cameraProvider.unbindAll()
            cameraProvider.bindToLifecycle(
                this, CameraSelector.DEFAULT_BACK_CAMERA, preview, imageCapture
            )

            preview.surfaceProvider = binding.textureView.surfaceProvider
        }, ContextCompat.getMainExecutor(this))
    }

    private fun takePhoto() {

        val photoFile = createCustomTempFile(this)

        val outputOptions = ImageCapture.OutputFileOptions.Builder(photoFile).build()

        imageCapture.takePicture(
            outputOptions, ContextCompat.getMainExecutor(this),
            object : ImageCapture.OnImageSavedCallback {
                override fun onImageSaved(outputFileResults: ImageCapture.OutputFileResults) {
                    val savedUri = Uri.fromFile(photoFile)
                    openPreviewActivity(savedUri, true)
                }

                override fun onError(exception: ImageCaptureException) {
                    Toast.makeText(
                        applicationContext,
                        getString(R.string.error_capturing, exception.message),
                        Toast.LENGTH_SHORT
                    ).show()
                }
            })
    }

    private fun openGallery() {
        openGalleryLauncher.launch(PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.ImageOnly))
    }

    private fun openPreviewActivity(uri: Uri, isFromCamera: Boolean) {
        val intent = Intent(this, PreviewActivity::class.java)
        intent.putExtra("isFromCamera", isFromCamera)
        intent.putExtra("imageUri", uri.toString())
        startActivity(intent)
    }

    private fun showSnapTipsDialog() {
        val dialogView = layoutInflater.inflate(R.layout.dialog_snap_tips, null)
        val alertDialog = AlertDialog.Builder(this)
            .setView(dialogView)
            .setCancelable(true)
            .create()


        val buttonGotIt = dialogView.findViewById<Button>(R.id.dialog_button_got_it)
        buttonGotIt.setOnClickListener {
            alertDialog.dismiss()
        }

        alertDialog.show()
    }

    override fun onSupportNavigateUp(): Boolean {
        val intent = Intent(this, MainActivity::class.java)
        startActivity(intent)
        finish()
        return true
    }


}
