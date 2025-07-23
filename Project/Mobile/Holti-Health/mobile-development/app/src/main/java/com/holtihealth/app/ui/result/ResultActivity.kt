package com.holtihealth.app.ui.result

import android.annotation.SuppressLint
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.bumptech.glide.Glide
import com.holtihealth.app.MainActivity
import com.holtihealth.app.MyApplication
import com.holtihealth.app.R
import com.holtihealth.app.ViewModelFactory
import com.holtihealth.app.database.History
import com.holtihealth.app.databinding.ActivityResultBinding
import com.holtihealth.app.formatToIndonesianTime
import com.holtihealth.app.saveImageToInternalStorage
import com.holtihealth.app.ui.scan.CameraActivity
import kotlinx.coroutines.launch

class ResultActivity : AppCompatActivity() {
    private lateinit var binding: ActivityResultBinding

    private val myApplication by lazy {
        application as? MyApplication
            ?: throw IllegalStateException(getString(R.string.throw_application))
    }

    private val historyRepository by lazy { myApplication.historyRepository }
    private val resultViewModel: ResultViewModel by viewModels {
        ViewModelFactory(diseaseRepository = myApplication.diseaseRepository)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityResultBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val toolbar = binding.toolbar
        setSupportActionBar(toolbar)
        supportActionBar?.apply {
            title = getString(R.string.result)
            setDisplayHomeAsUpEnabled(true)
        }

        val resultText = intent.getStringExtra("resultText") ?: "No result"
        val imageUriString = intent.getStringExtra("imageUri")

        binding.resultTextView.text = resultText

        val imageUri = Uri.parse(imageUriString)
        Glide.with(this)
            .load(imageUri)
            .into(binding.resultImageView)

        resultViewModel.getDiseaseDetails(resultText).observe(this) { disease ->
            if (disease != null) {
                binding.indicationText.text = disease.symptoms
                binding.controlText.text = disease.control

                val formattedTime = formatToIndonesianTime(System.currentTimeMillis())

                val diseaseImageUri = Uri.parse(imageUriString)

                val fileName = "result_image_${System.currentTimeMillis()}.jpg"
                val imagePath = saveImageToInternalStorage(this, diseaseImageUri, fileName)

                val history = History(
                    scanTime = formattedTime,
                    photoUri = imagePath ?: "",
                    diseaseId = disease.id
                )

                lifecycleScope.launch {
                    historyRepository.insertHistory(history)
                }

            } else {
                binding.indicationText.text = getString(R.string.symptoms_not_find)
                binding.controlText.text = getString(R.string.control_not_find)
            }
        }
    }

    override fun onSupportNavigateUp(): Boolean {
        val intent = Intent(this, MainActivity::class.java)
        startActivity(intent)
        finish()
        return true
    }

    @Deprecated(
        "This method has been deprecated in favor of using OnBackPressedDispatcher.",
        ReplaceWith("getOnBackPressedDispatcher().onBackPressed()")
    )
    @SuppressLint("MissingSuperCall")
    override fun onBackPressed() {
        val intent = Intent(this, MainActivity::class.java)
        startActivity(intent)
        finish()
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.result_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.action_camera -> {
                startCameraX()
                true
            }

            else -> super.onOptionsItemSelected(item)
        }
    }

    private fun startCameraX() {
        val intent = Intent(this, CameraActivity::class.java)
        startActivity(intent)
    }
}
