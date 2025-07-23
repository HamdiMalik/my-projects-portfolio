package com.holtihealth.app.ui.register

import android.content.Intent
import android.os.Bundle
import android.util.Patterns
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.UserProfileChangeRequest
import com.holtihealth.app.R
import com.holtihealth.app.databinding.ActivityRegisterBinding
import com.holtihealth.app.ui.login.LoginActivity

class RegisterActivity : AppCompatActivity() {
    private lateinit var binding: ActivityRegisterBinding
    private lateinit var firebaseAuth: FirebaseAuth


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityRegisterBinding.inflate(layoutInflater)
        setContentView(binding.root)
        supportActionBar?.hide()
        firebaseAuth = FirebaseAuth.getInstance()

        binding.signupButton.setOnClickListener {
            val name = binding.nameEditText.text.toString().trim()
            val email = binding.emailEditText.text.toString().trim()
            val password = binding.passwordEditText.text.toString().trim()

            if (validateInputs(name, email, password)) {
                registerUser(name, email, password)
            }
        }
        binding.tvLogin.setOnClickListener {
            val intent = Intent(this, LoginActivity::class.java)
            startActivity(intent)
        }
    }

    private fun validateInputs(name: String, email: String, password: String): Boolean {
        if (name.isEmpty()) {
            binding.nameEditTextLayout.error = getString(R.string.error_name_empty)
            return false
        } else {
            binding.nameEditTextLayout.error = null
        }

        if (email.isEmpty() || !Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
            binding.emailEditTextLayout.error = getString(R.string.invalid_email)
            return false
        } else {
            binding.emailEditTextLayout.error = null
        }

        if (password.isEmpty() || password.length < 8) {
            binding.passwordEditTextLayout.error = getString(R.string.error_min_password)
            return false
        } else {
            binding.passwordEditTextLayout.error = null
        }
        return true
    }

    private fun registerUser(name: String, email: String, password: String) {
        firebaseAuth.createUserWithEmailAndPassword(email, password)
            .addOnCompleteListener { task ->
                if (task.isSuccessful) {
                    val user = firebaseAuth.currentUser
                    user?.let {
                        val profileUpdates = UserProfileChangeRequest.Builder()
                            .setDisplayName(name)
                            .build()
                        it.updateProfile(profileUpdates).addOnCompleteListener { updateTask ->
                            if (updateTask.isSuccessful) {
                                it.sendEmailVerification()
                                    .addOnCompleteListener { emailTask ->
                                        if (emailTask.isSuccessful) {
                                            Toast.makeText(
                                                this,
                                                getString(R.string.succes_register),
                                                Toast.LENGTH_LONG
                                            ).show()
                                            val intent = Intent(this, LoginActivity::class.java)
                                            startActivity(intent)
                                            finish()
                                        } else {
                                            Toast.makeText(
                                                this,
                                                getString(
                                                    R.string.error_send_email,
                                                    emailTask.exception?.message
                                                ),
                                                Toast.LENGTH_SHORT
                                            ).show()
                                        }
                                    }
                            } else {
                                Toast.makeText(
                                    this,
                                    getString(R.string.error_profie, updateTask.exception?.message),
                                    Toast.LENGTH_SHORT
                                ).show()
                            }
                        }
                    }
                } else {
                    Toast.makeText(
                        this,
                        getString(R.string.register_fail, task.exception?.message),
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }
    }
}