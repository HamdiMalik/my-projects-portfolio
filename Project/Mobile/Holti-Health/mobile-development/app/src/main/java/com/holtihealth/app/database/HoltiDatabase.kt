package com.holtihealth.app.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteDatabase
import com.holtihealth.app.helper.InitialDataSource
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch


@Database(
    entities = [Article::class, Disease::class, History::class],
    version = 1,
    exportSchema = false
)
abstract class HoltiDatabase : RoomDatabase() {
    abstract fun articleDao(): ArticleDao
    abstract fun diseaseDao(): DiseaseDao
    abstract fun historyDao(): HistoryDao

    companion object {
        @Volatile
        private var INSTANCE: HoltiDatabase? = null

        @JvmStatic
        fun getDatabase(context: Context, applicationScope: CoroutineScope): HoltiDatabase {
            if (INSTANCE == null) {
                synchronized(HoltiDatabase::class.java) {
                    INSTANCE = Room.databaseBuilder(
                        context.applicationContext,
                        HoltiDatabase::class.java, "holti_database"
                    )
                        .fallbackToDestructiveMigration()
                        .addCallback(object : Callback() {
                            override fun onCreate(db: SupportSQLiteDatabase) {
                                super.onCreate(db)
                                INSTANCE?.let { database ->
                                    applicationScope.launch {
                                        val articelDao = database.articleDao()
                                        val diseaseDao = database.diseaseDao()
                                        articelDao.insertAll(InitialDataSource.getArticles())
                                        diseaseDao.insertAll(InitialDataSource.getDiseases())
                                    }
                                }
                            }
                        })
                        .build()
                }
            }
            return INSTANCE as HoltiDatabase
        }
    }
}
