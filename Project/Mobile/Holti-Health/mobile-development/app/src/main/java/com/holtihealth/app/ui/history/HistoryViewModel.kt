package com.holtihealth.app.ui.history

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.holtihealth.app.repository.HistoryRepository
import com.holtihealth.app.database.HistoryWithDisease
import kotlinx.coroutines.launch

class HistoryViewModel(private val repository: HistoryRepository) : ViewModel() {

    val allHistoryWithDisease: LiveData<List<HistoryWithDisease>> =
        repository.getAllHistoryWithDisease()

    fun deleteHistory(historyId: Int) {
        viewModelScope.launch {
            repository.deleteHistory(historyId)
        }
    }

}