package com.holtihealth.app.ui.profile

import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.auth.FirebaseAuth
import com.holtihealth.app.R
import com.holtihealth.app.databinding.FragmentProfileBinding
import com.holtihealth.app.ui.welcome.WelcomeActivity

class ProfileFragment : Fragment() {
    private var _binding: FragmentProfileBinding? = null
    private val binding get() = _binding!!
    private lateinit var firebaseAuth: FirebaseAuth

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentProfileBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val toolbar = binding.toolbar
        (activity as AppCompatActivity).setSupportActionBar(toolbar)
        (activity as? AppCompatActivity)?.supportActionBar?.title = getString(R.string.profil)

        firebaseAuth = FirebaseAuth.getInstance()

        val user = firebaseAuth.currentUser
        if (user != null) {
            binding.name.setText(user.displayName ?: getString(R.string.name_not_set))
            binding.email.setText(user.email)
        } else {
            Toast.makeText(requireContext(), getString(R.string.user_not_found), Toast.LENGTH_SHORT)
                .show()
        }

        binding.logoutButton.setOnClickListener {
            showLogoutConfirmationDialog()
        }
    }

    private fun showLogoutConfirmationDialog() {
        val context = requireContext()
        val builder = AlertDialog.Builder(context)
        builder.setTitle(getString(R.string.logout_alert))
            .setMessage(getString(R.string.are_you_sure_logout))
            .setPositiveButton(getString(R.string.yes)) { _, _ ->
                performLogout()
            }
            .setNegativeButton(getString(R.string.no)) { dialog, _ ->
                dialog.dismiss()
            }
        builder.create().show()
    }

    private fun performLogout() {
        firebaseAuth.signOut()
        Toast.makeText(requireContext(), getString(R.string.logout_succes), Toast.LENGTH_SHORT)
            .show()
        val intent = Intent(requireContext(), WelcomeActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
        requireActivity().finish()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
