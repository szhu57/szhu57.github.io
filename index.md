---
layout: page
title: Who loves technology and writing
tagline: Who loves technology and bloging
---
{% include JB/setup %}
You can follow me in Sina Weibo [well](http://weibo.com/swwol/home)
    
## My posts
<!--
<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
-->
{% for post in site.posts %}
<div class="article">
    <h3 class="title"><a href="{{ site.url }}{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a></h3>
    <article class="rexp">
    <p>{{ post.excerpt }}</p>
    </article>
    <a href="{{ site.url }}{{ post.url }}" class="more"><i class="icon-link"></i></a>
    <div class="info">
        <span class="info-title"><i class="icon-calendar"></i> Published: </span>
        <span class="info-date">{{ post.date | date_to_string }}</span>
    </div>
</div>
{% endfor %}

<!--
## Notice

This theme is still unfinished. If you'd like to be added as a contributor, [please fork](http://github.com/plusjade/jekyll-bootstrap)!
We need to clean up the themes, make theme usage guides with theme-specific markup examples.
-->

