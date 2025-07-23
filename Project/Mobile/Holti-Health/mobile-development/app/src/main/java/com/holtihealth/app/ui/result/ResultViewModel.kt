package com.holtihealth.app.ui.result

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import com.holtihealth.app.database.Disease
import com.holtihealth.app.repository.DiseaseRepository

class ResultViewModel(private val diseaseRepository: DiseaseRepository) : ViewModel() {

    fun getDiseaseDetails(diseaseName: String): LiveData<Disease?> {
        return diseaseRepository.getDiseaseByName(diseaseName)
    }
}


