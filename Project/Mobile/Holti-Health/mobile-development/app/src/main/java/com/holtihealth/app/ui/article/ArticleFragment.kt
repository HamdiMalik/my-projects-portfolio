package com.holtihealth.app.ui.article

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.holtihealth.app.MyApplication
import com.holtihealth.app.ViewModelFactory
import com.holtihealth.app.databinding.FragmentArticleBinding
import com.holtihealth.app.ui.detailArticle.DetailArticleActivity

class ArticleFragment : Fragment() {

    private val articleViewModel: ArticleViewModel by viewModels {
        ViewModelFactory(articleRepository = (requireActivity().application as MyApplication).articleRepository)
    }

    private var _binding: FragmentArticleBinding? = null
    private val binding get() = _binding!!

    private lateinit var articleAdapter: ArticleAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentArticleBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val toolbar = binding.toolbar
        (activity as AppCompatActivity).setSupportActionBar(toolbar)
        (activity as? AppCompatActivity)?.supportActionBar?.title = "Artikel"

        articleAdapter = ArticleAdapter { article ->
            val intent = Intent(context, DetailArticleActivity::class.java)
            intent.putExtra("ARTICLE_ID", article.id)
            startActivity(intent)
        }

        binding.rvArticle.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = articleAdapter
        }

        articleViewModel.getAllArticles().observe(viewLifecycleOwner) { articles ->
            articleAdapter.submitList(articles)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
