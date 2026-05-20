---
layout: page
title: Blog
permalink: /blog/
---

{% for post in site.posts %}
<div class="blog-post-item">
  <h2 class="post-title">
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  </h2>
  
  <div class="post-date">{{ post.date | date: "%d %B %Y" | upcase }}</div>
  
  <div class="post-excerpt">
    {{ post.excerpt | strip_html | truncatewords: 30 }}
  </div>
</div>
{% endfor %}