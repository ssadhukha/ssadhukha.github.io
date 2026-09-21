---
layout: page
---

<div class="home-header">
  <div class="home-header-content">
    <h1>Sushmita Sadhukha</h1>

    <div class="home-intro">
      <p>Hi, I'm Sush, a cognitive neuroscience PhD candidate.</p>
      <p>I heard this somewhere recently: a good story lets you surf the *wave* of your own imagination.</p>
      <p>Which is <em>kind of</em> what I study, actually.</p>
      <p>Find out more <a href="/research/">here</a>.</p>
    </div>
  </div>

  <div class="home-header-banner">
    <img src="/assets/budva_coast.png" alt="Budva coast">
    <p class="home-header-caption">Adriatic coast, Budva, Montenegro, 2026</p>
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