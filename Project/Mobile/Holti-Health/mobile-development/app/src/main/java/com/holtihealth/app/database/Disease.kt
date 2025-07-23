package com.holtihealth.app.database

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "disease")
data class Disease(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val name: String,
    val symptoms: String,
    val control: String
)
