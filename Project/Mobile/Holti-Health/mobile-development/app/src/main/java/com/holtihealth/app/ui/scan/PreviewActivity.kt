package com.holtihealth.app.ui.scan

import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.Uri
import android.os.Bundle
import android.widget.Button
import android.widget.ImageView
import android.widget.Toast
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import com.holtihealth.app.R
import com.holtihealth.app.databinding.ActivityPreviewBinding
import com.holtihealth.app.helper.ImageClassifierHelper
import com.holtihealth.app.ui.result.ResultActivity

class PreviewActivity : AppCompatActivity(), ImageClassifierHelper.ClassifierListener {

    private lateinit var binding: ActivityPreviewBinding
    private lateinit var imageClassifierHelper: ImageClassifierHelper
    private var isFromCamera: Boolean = false
    private var progressDialog: AlertDialog? = null

    private val openGalleryLauncher =
        registerForActivityResult(ActivityResultContracts.PickVisualMedia()) { uri ->
            uri?.let {
                openPreviewActivity(it, false)
            }
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityPreviewBinding.inflate(layoutInflater)
        setContentView(binding.root)

        supportActionBar?.hide()
        imageClassifierHelper = ImageClassifierHelper(
            context = this,
            classifierListener = this
        )

        val imageUriString = intent.getStringExtra("imageUri")
        val imageUri = Uri.parse(imageUriString)
        isFromCamera = intent.getBooleanExtra("isFromCamera", false)

        updateButtonText()

        imageUri?.let {
            binding.previewImageView.setImageURI(it)

            if (isFromCamera) {
                binding.previewImageView.scaleType = ImageView.ScaleType.CENTER_CROP
            } else {
                binding.previewImageView.scaleType = ImageView.ScaleType.FIT_CENTER
            }
        }

        binding.buttonSnapTips.setOnClickListener {
            showSnapTipsDialog()
        }
        binding.buttonRetake.setOnClickListener {
            handleRetake()
        }

        binding.buttonAnalyzeImage.setOnClickListener {
            if (imageUri != null) {
                analyzeImage(imageUri)
            } else {
                Toast.makeText(this, getString(R.string.image_not_find), Toast.LENGTH_SHORT).show()
            }
        }
    }

    private fun analyzeImage(uri: Uri) {
        if (!isInternetAvailable()) {
            showNoInternetDialog()
            return
        }
        try {
            showProgressDialog(getString(R.string.analyze_image))
            imageClassifierHelper.classifyImage(uri)
        } catch (e: Exception) {
            hideProgressDialog()
            Toast.makeText(
                this,
                getString(R.string.erro_analyze_image, e.message), Toast.LENGTH_SHORT
            ).show()
        }
    }


    private fun handleRetake() {
        if (isFromCamera) {
            val cameraIntent = Intent(this, CameraActivity::class.java)
            startActivity(cameraIntent)
            finish()
        } else {
            openGalleryLauncher.launch(PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.ImageOnly))
        }
    }

    private fun openPreviewActivity(uri: Uri, isFromCamera: Boolean) {
        val intent = Intent(this, PreviewActivity::class.java)
        intent.putExtra("isFromCamera", isFromCamera)
        intent.putExtra("imageUri", uri.toString())
        startActivity(intent)
        finish()
    }

    private fun updateButtonText() {
        if (isFromCamera) {
            binding.buttonRetake.text = getString(R.string.retake)
        } else {
            binding.buttonRetake.text = getString(R.string.choose_again)
        }
    }

    private fun showProgressDialog(message: String) {
        if (progressDialog == null) {
            val builder = AlertDialog.Builder(this)
            builder.setView(R.layout.progress_dialog)
            builder.setCancelable(false)
            builder.setMessage(message)
            progressDialog = builder.create()
        }
        progressDialog?.show()
    }

    private fun hideProgressDialog() {
        progressDialog?.dismiss()
    }

    override fun onResults(predictedLabel: String, confidence: String) {
        hideProgressDialog()

        val confidenceScore = confidence.replace("%", "").toFloatOrNull() ?: 0f

        if (confidenceScore < 90f) {
            showLowConfidenceDialog()
            return
        }

        val imageUri = intent.getStringExtra("imageUri")
        val intent = Intent(this, ResultActivity::class.java)
        intent.putExtra("resultText", predictedLabel)
        intent.putExtra("imageUri", imageUri)
        startActivity(intent)
    }

    override fun onError(error: String) {
        hideProgressDialog()
        showNoInternetDialog()
    }

    override fun onDestroy() {
        hideProgressDialog()
        super.onDestroy()
    }

    private fun showNoInternetDialog() {
        val dialogView = layoutInflater.inflate(R.layout.dialog_no_internet, null)
        val alertDialog = AlertDialog.Builder(this)
            .setView(dialogView)
            .setCancelable(false)
            .create()

        val button = dialogView.findViewById<Button>(R.id.dialog_button)
        button.setOnClickListener {
            alertDialog.dismiss()
        }

        alertDialog.show()
    }

    private fun isInternetAvailable(): Boolean {
        val connectivityManager =
            getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = connectivityManager.activeNetwork
        val capabilities = connectivityManager.getNetworkCapabilities(network)
        return capabilities != null && capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
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

    private fun showLowConfidenceDialog() {
        val dialogView = layoutInflater.inflate(R.layout.dialog_low_confidence, null)
        val alertDialog = AlertDialog.Builder(this)
            .setView(dialogView)
            .setCancelable(false)
            .create()

        val tryAgainButton = dialogView.findViewById<Button>(R.id.dialog_try_again_button)
        tryAgainButton.setOnClickListener {
            alertDialog.dismiss()
        }

        alertDialog.show()
    }

}
