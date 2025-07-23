package com.holtihealth.app.database

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface ArticleDao {
    @Query("SELECT * from article ORDER BY id ASC")
    fun getAllArticles(): LiveData<List<Article>>

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insertAll(articles: List<Article>)

    @Query("SELECT * FROM article WHERE id = :articleId")
    fun getEventById(articleId: Int): LiveData<Article>
}