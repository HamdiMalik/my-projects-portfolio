package com.holtihealth.app.database

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "article")
data class Article(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val title: String,
    var description: String,
    var image: Int,


    )