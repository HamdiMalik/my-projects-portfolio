package com.holtihealth.app

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.holtihealth.app.repository.ArticleRepository
import com.holtihealth.app.repository.DiseaseRepository
import com.holtihealth.app.repository.HistoryRepository
import com.holtihealth.app.ui.article.ArticleViewModel
import com.holtihealth.app.ui.detailArticle.DetailArticleViewModel
import com.holtihealth.app.ui.detailHistory.DetailHistoryViewModel
import com.holtihealth.app.ui.history.HistoryViewModel
import com.holtihealth.app.ui.home.HomeViewModel
import com.holtihealth.app.ui.result.ResultViewModel

class ViewModelFactory(
    private val diseaseRepository: DiseaseRepository? = null,
    private val articleRepository: ArticleRepository? = null,
    private val historyRepository: HistoryRepository? = null,
    private val articleId: Int? = null,
    private val historyId: Int? = null
) : ViewModelProvider.Factory {

    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(ResultViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return ResultViewModel(diseaseRepository!!) as T
        } else if (modelClass.isAssignableFrom(ArticleViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return ArticleViewModel(articleRepository!!) as T
        } else if (modelClass.isAssignableFrom(HistoryViewModel::class.java)){
            @Suppress("UNCHECKED_CAST")
            return  HistoryViewModel(historyRepository!!) as T
        } else if (modelClass.isAssignableFrom(DetailArticleViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return DetailArticleViewModel(articleRepository!!, articleId!!) as T
        } else if (modelClass.isAssignableFrom(DetailHistoryViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return  DetailHistoryViewModel(historyRepository!!, historyId!!) as T
        } else if (modelClass.isAssignableFrom(HomeViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return HomeViewModel(articleRepository!!, historyRepository!!) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}
