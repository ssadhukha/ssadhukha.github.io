---
layout: page
---

<div class="home-header">
  <div class="home-header-content">
    <h1>Sushmita Sadhukha</h1>
    
    <div class="home-intro">
      <p class="home-tagline">Cognitive neuroscience, naturalistic data, methods, & side projects.</p>
      <p>Trying to understand how people make sense of stories. Find out more about me <a href="/about/">here</a> and browse my writing <a href="/blog/">here</a>.</p>
      
    </div>
  </div>

  <div class="home-header-image">
    <img src="/assets/ghost_mushroom.png" alt="Ghost mushroom drawing">
  </div>
</div>

<div class="recent-posts">
  <h2>Recent Posts</h2>
  {% for post in site.posts limit:3 %}
    <div class="post-preview">
      <div class="post-preview-text">
        <a href="{{ post.url | relative_url }}">{{ post.title }}{% if post.subtitle %}<span class="post-preview-subtitle">{{ post.subtitle }}</span>{% endif %}</a>
      </div>
      <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
    </div>
  {% endfor %}
  <p><a href="{{ '/blog/' | relative_url }}">View all posts →</a></p>
</div>