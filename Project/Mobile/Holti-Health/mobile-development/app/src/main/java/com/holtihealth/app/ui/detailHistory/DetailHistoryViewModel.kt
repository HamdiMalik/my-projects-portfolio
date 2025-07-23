package com.holtihealth.app.ui.detailHistory

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import com.holtihealth.app.repository.HistoryRepository
import com.holtihealth.app.database.HistoryWithDisease

class DetailHistoryViewModel(historyRepository: HistoryRepository, historyId: Int) : ViewModel() {

    val getDetail: LiveData<HistoryWithDisease> = historyRepository.getHistoryDetail(historyId)

}