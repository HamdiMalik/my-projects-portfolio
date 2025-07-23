package com.holtihealth.app.ui.article

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import com.holtihealth.app.database.Article
import com.holtihealth.app.repository.ArticleRepository

class ArticleViewModel(private val articleRepository: ArticleRepository) : ViewModel() {

    fun getAllArticles(): LiveData<List<Article>> = articleRepository.getAllArticles()
}
