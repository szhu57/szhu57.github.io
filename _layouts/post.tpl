---
layout: blog

pageClass: page-type-post

---

<div  class="page-header">/ <a href="/">{{ site.name }}</a> / <samll>{{ page.title }}</small></div>

<article>
	<h2><a href="{{ page.url }}">{{ page.title }}</a></h2>
	{% assign post = page %}
	{% include meta.tpl %}
	{{ content }}
	{% capture permaurl %}http://{{site.host}}{{ page.url }}{% endcapture %}
	<!--<p class="permalink">永久链接：<a href="{{ permaurl }}">{{ permaurl }}</a></p>-->
</article>
<div id="disqus_thread" class="comments"></div>
