package com.holtihealth.app.database

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface DiseaseDao {
    @Query("SELECT * FROM Disease WHERE name = :name LIMIT 1")
    fun getDiseaseByName(name: String): LiveData<Disease?>

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insertAll(diseases: List<Disease>)
}
