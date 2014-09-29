<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <meta name="author" content="{{ site.meta.author.name }}" />
        <meta name="keywords" content="{{ page.tags | join: ',' }}" />
       
        <title>{{ site.name }}{% if page.title %} / {{ page.title }}{% endif %}</title>
       
        <link href="http://{{ site.host }}/feed.xml" rel="alternate" title="{{ site.name }}" type="application/atom+xml" />

        <link href="/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>        

        <link rel="stylesheet" type="text/css" href="/assets/css/site.css" />
        <link rel="stylesheet" type="text/css" href="/assets/css/code/github.css" />
        {% for style in page.styles %}
            <link rel="stylesheet" type="text/css" href="{{ style }}" />
        {% endfor %}
        <!--Move down the content to a proper position-->
        <link href="/assets/css/blog-home.css" rel="stylesheet" type="text/css"/>

        
    </head>
    <body class="{{ page.pageClass }}">
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Weiwei</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Weiwei's Blog</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="/">Home</a></li>
                        <li><a href="/about.html">Profile</a></li>
                        <li><a href="/">Posts</a></li>
                        <li><a href="/exp/index.html">Projects</a></li>
                        <li><a href="http://wwsun.lofter.com/" target="_blank">Photos</a></li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>

        <!-- Page Content -->
        <div class="container">

            <div class="row">

                <!-- Blog Entries Column -->
                <div class="col-md-8">
                    <!-- First Blog Post -->
                    {{ content }}
                    <hr>
                    <!-- Pager -->
                    <ul class="pager">
                        <li class="previous">
                            <a href="#">&larr; Older</a>
                        </li>
                        <li class="next">
                            <a href="#">Newer &rarr;</a>
                        </li>
                    </ul>

                </div>

                <!-- Blog Sidebar Widgets Column -->
                <div class="col-md-4">

                    <!-- Blog Search Well -->
                    <div class="well">
                        <h4>Author</h4>
                        <figure>
                            <!--
                            {% if site.meta.author.gravatar %}
                            <img src="{{ site.meta.gravatar}}{{ site.meta.author.gravatar }}?s=70" />
                            {% endif %}
                            <figcaption><strong>{{ site.meta.author.name }}</strong></figcaption>
                            -->
                            <img class="img-rounded" src="http://en.gravatar.com/avatar/48b4b2d677d28780288ab93737230019?s=70" />
                            <figcaption><strong>Weiwei SUN</strong></figcaption>
                        </figure>
                        <h5>热爱Coding的摄影爱好者</h5>
                        <!-- /.input-group -->
                    </div>

                    <div class="well">
                        <h4>Talks</h4>
                        <iframe height="350" frameborder="0" scrolling="no" src="http://widget.weibo.com/weiboshow/index.php?language=&width=0&height=350&fansRow=2&ptype=1&speed=0&skin=1&isTitle=0&noborder=0&isWeibo=1&isFans=0&uid=1252228384&verifier=7afc8484&colors=d6f3f7,f8f5f0,666666,0082cb,f8f5f0&dpc=1"></iframe>
                    </div>

                    <!-- Blog Categories Well -->
                    <div class="well">
                        <h4>Categories</h4>
                        <div class="row">
                            <div class="col-md-10">
                                <ul class="list-unstyled">
                                    {% for category in site.custom.categories %}
                                    <li class="{{ category.name }}"><a href="/category/{{ category.name }}/">{{ category.title }}</a></li>
                                    {% endfor %}
                                </ul>
                            </div>
                            <!-- /.col-lg-6 -->
                        </div>
                        <!-- /.row -->
                    </div>

                    <!-- Side Widget Well -->
                    <div class="well">
                        <h4>Copyright</h4>
                        <p><a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/2.5/cn/" target="_blank" class="hide-target-icon" title="Copyright declaration of site content"><img alt="知识共享许可协议" src="http://i.creativecommons.org/l/by-nc-nd/2.5/cn/88x31.png" /></a></p>
                    </div>

                    <div class="well">
                        <h4>Powered by</h4>
                        <p>
                            <a href="http://disqus.com/" target="_blank">Disqus</a>,
                            <a href="http://elfjs.com/" target="_blank">elf+js</a>,
                            <a href="https://github.com/" target="_blank">GitHub</a>,
                            <a href="http://www.google.com/cse/" target="_blank">Google Custom Search</a>,
                            <a href="http://en.gravatar.com/" target="_blank">Gravatar</a>,
                            <a href="http://softwaremaniacs.org/soft/highlight/en/">HighlightJS</a>,
                            <a href="https://github.com/mojombo/jekyll" target="_blank">jekyll</a>,
                            <a href="https://github.com/mytharcher/SimpleGray" target="_blank">SimpleGray</a>
                        </p>
                    </div>

                </div>

            </div>
            <!-- /.row -->

            <hr>

            <!-- Footer -->
            <footer>
                <div class="row">
                    <div class="col-lg-12">
                        <p>Copyright &copy; Weiwei SUN 2014</p>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
            </footer>

        </div>
        <!-- /.container -->


        <script src="http://elfjs.googlecode.com/files/elf-0.4.1-min.js"></script>
        <script src="http://yandex.st/highlightjs/7.3/highlight.min.js"></script>

        <!--Google CSE -->
        <script src="/assets/js/site.js"></script>
        {% for script in page.scripts %}<script src="{{ script }}"></script>
        {% endfor %}
        <script>
        site.URL_GOOGLE_API = '{{site.meta.gapi}}';
        site.URL_DISCUS_COMMENT = '{{ site.meta.author.disqus }}' ? 'http://{{ site.meta.author.disqus }}.{{ site.meta.disqus }}' : '';

        site.VAR_SITE_NAME = '{{ site.name }}';
        site.VAR_GOOGLE_CUSTOM_SEARCH_ID = '{{ site.meta.author.gcse }}';
        site.TPL_SEARCH_TITLE = '#{0} / 搜索：#{1}';
        </script>

        <!--Google Analytics -->
        <script>
          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

          ga('create', 'UA-53482289-1', 'auto');
          ga('send', 'pageview');

        </script>
    </body>
</html>
