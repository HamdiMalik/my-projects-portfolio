package com.holtihealth.app.network

import com.google.gson.annotations.SerializedName

data class FileUploadResponse(

    @field:SerializedName("confidence")
    val confidence: String? = null,

    @field:SerializedName("prediction")
    val prediction: String? = null,

    @field:SerializedName("message")
    val message: String? = null,

    @field:SerializedName("explanation")
    val explanation: String? = null,

    @field:SerializedName("status")
    val status: String? = null
)
