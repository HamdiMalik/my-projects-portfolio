package com.holtihealth.app.ui.detailHistory

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import com.bumptech.glide.Glide
import com.holtihealth.app.MyApplication
import com.holtihealth.app.R
import com.holtihealth.app.ViewModelFactory
import com.holtihealth.app.database.HistoryWithDisease
import com.holtihealth.app.databinding.ActivityDetailHistoryBinding

class DetailHistoryActivity : AppCompatActivity() {
    private lateinit var binding: ActivityDetailHistoryBinding

    private val myApplication by lazy {
        application as? MyApplication
            ?: throw IllegalStateException(getString(R.string.throw_application))
    }

    private val detailHistoryViewModel: DetailHistoryViewModel by lazy {
        val historyId = intent.getIntExtra("HISTORY_ID", 0)
        ViewModelProvider(
            this,
            ViewModelFactory(
                historyRepository = myApplication.historyRepository,
                historyId = historyId
            )
        )[DetailHistoryViewModel::class.java]
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityDetailHistoryBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val toolbar = binding.toolbar
        setSupportActionBar(toolbar)
        supportActionBar?.apply {
            title = getString(R.string.story)
            setDisplayHomeAsUpEnabled(true)
        }

        detailHistoryViewModel.getDetail.observe(this) { historyWithDisease ->
            historyWithDisease?.let { showHistoryDetail(it) }
        }
    }

    private fun showHistoryDetail(historyWithDisease: HistoryWithDisease) {
        val history = historyWithDisease.history
        val disease = historyWithDisease.disease

        binding.resultTextView.text = disease.name
        binding.indicationText.text = disease.symptoms
        binding.controlText.text = disease.control

        Glide.with(this)
            .load(history.photoUri)
            .into(binding.resultImageView)
    }

    override fun onSupportNavigateUp(): Boolean {
        onBackPressedDispatcher.onBackPressed()
        return true
    }
}
