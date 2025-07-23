package com.holtihealth.app.ui.detailArticle

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import com.holtihealth.app.database.Article
import com.holtihealth.app.repository.ArticleRepository


class DetailArticleViewModel(repository: ArticleRepository, articleId: Int) : ViewModel() {

    val getdetail: LiveData<Article> = repository.getArticleDetail(articleId)
}

