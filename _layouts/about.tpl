---
layout: about

pageClass: page-type-about

---

<article>
	{% assign about = aboutpage %}
	{% include meta.tpl %}
	{{ content }}
	<!--<p class="permalink">永久链接：<a href="{{ permaurl }}">{{ permaurl }}</a></p>-->
</article>
