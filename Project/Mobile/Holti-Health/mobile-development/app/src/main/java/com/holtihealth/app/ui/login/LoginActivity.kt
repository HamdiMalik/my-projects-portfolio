package com.holtihealth.app.ui.login

import android.content.Intent
import android.os.Bundle
import android.util.Patterns
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.auth.FirebaseAuth
import com.holtihealth.app.MainActivity
import com.holtihealth.app.R
import com.holtihealth.app.databinding.ActivityLoginBinding
import com.holtihealth.app.ui.register.RegisterActivity

class LoginActivity : AppCompatActivity() {

    private lateinit var binding: ActivityLoginBinding
    private lateinit var firebaseAuth: FirebaseAuth

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityLoginBinding.inflate(layoutInflater)
        setContentView(binding.root)
        supportActionBar?.hide()
        firebaseAuth = FirebaseAuth.getInstance()

        binding.loginButton.setOnClickListener {
            val email = binding.emailEditText.text.toString().trim()
            val password = binding.passwordEditText.text.toString().trim()

            if (validateInputs(email, password)) {
                loginUser(email, password)
            }
        }
        binding.tvRegister.setOnClickListener {
            val intent = Intent(this, RegisterActivity::class.java)
            startActivity(intent)
        }

    }

    private fun validateInputs(email: String, password: String): Boolean {
        if (email.isEmpty()) {
            binding.emailEditTextLayout.error = getString(R.string.error_email_empty)
            return false
        } else {
            binding.emailEditTextLayout.error = null
        }

        if (email.isEmpty() || !Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
            binding.emailEditTextLayout.error = getString(R.string.invalid_email)
            return false
        } else {
            binding.emailEditTextLayout.error = null
        }

        if (password.isEmpty()) {
            binding.passwordEditTextLayout.error = getString(R.string.error_password_empty)
            return false
        } else {
            binding.passwordEditTextLayout.error = null
        }

        return true
    }

    private fun loginUser(email: String, password: String) {
        firebaseAuth.signInWithEmailAndPassword(email, password)
            .addOnCompleteListener { task ->
                if (task.isSuccessful) {
                    val user = firebaseAuth.currentUser
                    if (user != null && user.isEmailVerified) {
                        Toast.makeText(this, getString(R.string.login_succes), Toast.LENGTH_SHORT)
                            .show()
                        val intent = Intent(this, MainActivity::class.java)
                        startActivity(intent)
                        finish()
                    } else {
                        Toast.makeText(
                            this,
                            getString(R.string.account_not_verified),
                            Toast.LENGTH_SHORT
                        ).show()
                        firebaseAuth.signOut()
                    }
                } else {
                    Toast.makeText(
                        this,
                        getString(R.string.login_failed, task.exception?.message),
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }
    }
}