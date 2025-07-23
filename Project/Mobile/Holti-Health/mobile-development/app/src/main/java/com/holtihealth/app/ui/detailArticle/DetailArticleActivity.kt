package com.holtihealth.app.ui.detailArticle

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import com.bumptech.glide.Glide
import com.holtihealth.app.MyApplication
import com.holtihealth.app.R
import com.holtihealth.app.ViewModelFactory
import com.holtihealth.app.database.Article
import com.holtihealth.app.databinding.ActivityDetailArticleBinding

class DetailArticleActivity : AppCompatActivity() {
    private lateinit var binding: ActivityDetailArticleBinding

    private val myApplication by lazy {
        application as? MyApplication
            ?: throw IllegalStateException(getString(R.string.throw_application))
    }

    private val detailArticleViewModel: DetailArticleViewModel by lazy {
        val articleId = intent.getIntExtra("ARTICLE_ID", 0)
        ViewModelProvider(
            this,
            ViewModelFactory(
                articleRepository = myApplication.articleRepository,
                articleId = articleId
            )
        )[DetailArticleViewModel::class.java]
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        binding = ActivityDetailArticleBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.ibBack.setOnClickListener {
            onBackPressed()
        }

        detailArticleViewModel.getdetail.observe(this) { article ->
            article?.let { displayStoryDetails(it) }
        }

    }

    private fun displayStoryDetails(article: Article) {

        binding.descriptionText.text = article.description
        binding.name.text = article.title

        Glide.with(this)
            .load(article.image)
            .into(binding.detailImageView)
    }

    @Suppress("DEPRECATION")
    override fun onBackPressed() {
        super.onBackPressed()
    }
}