---
layout: page
title: Stream
permalink: /stream/
show_quote: true
---

<div class="stream-header">
  <p>Some low-friction, non-commital, thoughts, ideas...</p>
</div>

{% assign stream_posts = site.data.stream | reverse %}
{% for post in stream_posts %}
<div class="stream-item">
  <div class="stream-meta">
    <div class="stream-date">{{ post.t | date: "%Y/%m/%d %H:%M" }}</div>
  </div>
  <div class="stream-content">
    {{ post.s | markdownify }}
  </div>
</div>
{% endfor %}