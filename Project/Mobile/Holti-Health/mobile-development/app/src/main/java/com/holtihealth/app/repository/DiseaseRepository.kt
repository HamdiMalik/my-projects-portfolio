package com.holtihealth.app.repository

import androidx.lifecycle.LiveData
import com.holtihealth.app.database.Disease
import com.holtihealth.app.database.DiseaseDao

class DiseaseRepository(private val diseaseDao: DiseaseDao) {

    fun getDiseaseByName(name: String): LiveData<Disease?> {
        return diseaseDao.getDiseaseByName(name)
    }
}
