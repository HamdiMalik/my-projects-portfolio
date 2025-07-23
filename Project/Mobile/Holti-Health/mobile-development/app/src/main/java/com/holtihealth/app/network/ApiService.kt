package com.holtihealth.app.network

import okhttp3.MultipartBody
import retrofit2.http.*

interface ApiService {
    @Multipart
    @POST("predict")
    suspend fun uploadImage(
        @Part file: MultipartBody.Part
    ): FileUploadResponse
}
