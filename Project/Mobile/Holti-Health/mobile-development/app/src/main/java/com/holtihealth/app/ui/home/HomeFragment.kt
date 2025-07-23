package com.holtihealth.app.ui.home

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.firebase.auth.FirebaseAuth
import com.holtihealth.app.MyApplication
import com.holtihealth.app.R
import com.holtihealth.app.ViewModelFactory
import com.holtihealth.app.databinding.FragmentHomeBinding
import com.holtihealth.app.ui.detailArticle.DetailArticleActivity
import com.holtihealth.app.ui.detailHistory.DetailHistoryActivity
import com.holtihealth.app.ui.scan.CameraActivity

class HomeFragment : Fragment() {

    private var _binding: FragmentHomeBinding? = null
    private val binding get() = _binding!!

    private lateinit var firebaseAuth: FirebaseAuth
    private val homeViewModel: HomeViewModel by viewModels {
        ViewModelFactory(
            articleRepository = (requireActivity().application as MyApplication).articleRepository,
            historyRepository = (requireActivity().application as MyApplication).historyRepository
        )
    }

    private lateinit var articleItemAdapter: ArticleItemAdapter
    private lateinit var historyItemAdapter: HistoryItemAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentHomeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val toolbar = binding.toolbar
        (activity as AppCompatActivity).setSupportActionBar(toolbar)
        (activity as? AppCompatActivity)?.supportActionBar?.title = getString(R.string.whats_up)

        setupRecyclerViews()

        firebaseAuth = FirebaseAuth.getInstance()
        val user = firebaseAuth.currentUser
        if (user != null) {
            val username = user.displayName ?: getString(R.string.name_not_filled)
            binding.toolbarSubtitle.text = username
        } else {
            Toast.makeText(requireContext(), getString(R.string.user_not_found), Toast.LENGTH_SHORT)
                .show()
        }

        binding.scanNowButton.setOnClickListener {
            val intent = Intent(context, CameraActivity::class.java)
            startActivity(intent)
        }

        homeViewModel.getAllArticles().observe(viewLifecycleOwner) { articles ->
            articleItemAdapter.submitList(articles)
        }

        homeViewModel.allHistoryWithDisease().observe(viewLifecycleOwner) { histories ->
            if (histories.isNullOrEmpty()) {
                binding.rvHistory.visibility = View.GONE
                binding.tvEmptyHistory.visibility = View.VISIBLE
            } else {
                binding.rvHistory.visibility = View.VISIBLE
                binding.tvEmptyHistory.visibility = View.GONE
                historyItemAdapter.submitList(histories)
            }
        }
    }

    private fun setupRecyclerViews() {
        articleItemAdapter = ArticleItemAdapter { article ->
            val intent = Intent(context, DetailArticleActivity::class.java)
            intent.putExtra("ARTICLE_ID", article.id)
            startActivity(intent)
        }

        binding.rvArticle.apply {
            layoutManager =
                LinearLayoutManager(requireContext(), LinearLayoutManager.HORIZONTAL, false)
            adapter = articleItemAdapter
        }

        historyItemAdapter = HistoryItemAdapter { historyWithDisease ->
            val intent = Intent(context, DetailHistoryActivity::class.java)
            intent.putExtra("HISTORY_ID", historyWithDisease.history.id)
            startActivity(intent)
        }

        binding.rvHistory.apply {
            layoutManager =
                LinearLayoutManager(requireContext(), LinearLayoutManager.VERTICAL, false)
            adapter = historyItemAdapter
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
