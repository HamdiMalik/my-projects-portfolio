package com.holtihealth.app

import android.app.Application
import com.holtihealth.app.repository.ArticleRepository
import com.holtihealth.app.repository.DiseaseRepository
import com.holtihealth.app.repository.HistoryRepository
import com.holtihealth.app.database.HoltiDatabase
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob

class MyApplication : Application() {
    private val applicationScope = CoroutineScope(SupervisorJob())
    val database by lazy { HoltiDatabase.getDatabase(this, applicationScope) }
    val articleRepository by lazy { ArticleRepository(database.articleDao()) }
    val diseaseRepository by lazy { DiseaseRepository(database.diseaseDao()) }
    val historyRepository by lazy { HistoryRepository(database.historyDao()) }
}