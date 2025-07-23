package com.holtihealth.app.ui.home

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.holtihealth.app.database.Article
import com.holtihealth.app.databinding.ItemHomeArticleBinding

class ArticleItemAdapter(private val onArticleClick: (Article) -> Unit) :
    ListAdapter<Article, ArticleItemAdapter.ArticleViewHolder>(DIFF_CALLBACK) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ArticleViewHolder {
        val binding =
            ItemHomeArticleBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ArticleViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ArticleViewHolder, position: Int) {
        val articleItem = getItem(position)
        holder.bind(articleItem)
        holder.itemView.setOnClickListener {
            onArticleClick(articleItem)
        }
    }

    class ArticleViewHolder(private val binding: ItemHomeArticleBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(article: Article) {
            binding.tvTitle.text = article.title
            binding.tvDescription.text = article.description

            Glide.with(binding.root.context)
                .load(article.image)
                .into(binding.ivArticle)
        }
    }

    companion object {
        val DIFF_CALLBACK: DiffUtil.ItemCallback<Article> =
            object : DiffUtil.ItemCallback<Article>() {
                override fun areItemsTheSame(oldItem: Article, newItem: Article): Boolean {
                    return oldItem.id == newItem.id
                }

                @SuppressLint("DiffUtilEquals")
                override fun areContentsTheSame(oldItem: Article, newItem: Article): Boolean {
                    return oldItem == newItem
                }
            }
    }
}
