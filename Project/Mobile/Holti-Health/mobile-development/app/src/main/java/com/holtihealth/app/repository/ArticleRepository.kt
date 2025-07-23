package com.holtihealth.app.repository

import androidx.lifecycle.LiveData
import com.holtihealth.app.database.Article
import com.holtihealth.app.database.ArticleDao

class ArticleRepository(private val articleDao: ArticleDao) {

    fun getAllArticles() = articleDao.getAllArticles()

    fun getArticleDetail(eventId: Int): LiveData<Article> {
        return articleDao.getEventById(eventId)
    }
}