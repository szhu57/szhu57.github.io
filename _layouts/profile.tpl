<!DOCTYPE html>
<html>
    <head>
        <title>About me</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="/assets/css/blog-home.css" rel="stylesheet" type="text/css"/>
        <link href="/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="/">Weiwei's Blog</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="/">Home</a></li>
                        <li class="active"><a href="/about.html">Profile</a></li>
                        <li><a href="/">Posts</a></li>
                        <li><a href="/exp/index.html">Projects</a></li>
                        <li><a href="http://wwsun.lofter.com/" target="_blank">Photos</a></li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>

        <div class="container">
            <div class="centered row">
                <br>
                <br>
                <img class="img-circle" src="{{ site.meta.gravatar}}{{ site.meta.author.gravatar }}?s=155" alt='user_avater' />
            </div>
            <div class="row col-md-8 col-md-offset-2">
                <h1 class="text-center">Hi, I am Xiaofeng</h1>
                {{ content }}
            </div>
            <div class="row col-md-8 col-md-offset-2">
                <h2 class="text-center">Contact</h2>
                <br>
                <p class="text-center">
                    <i class="fa fa-envelope fa-3x"></i>&#9;
                    <i class="fa fa-qq fa-3x"></i>&#9;
                    <i class="fa fa-weibo fa-3x"></i>&#9;
                    <i class="fa fa-weixin fa-3x"></i>&#9;
                    <i class="fa fa-github fa-3x"></i>
                </p>
            </div>

            <div class="row col-md-8 col-md-offset-2">
                <br>
                <h2 class="text-center">Skills</h2>
                <h4>Java</h4>
                <div class="progress">
                    <div class="progress-bar progress-bar-info col-md-6" style="width: 70%;"></div>
                </div>
                <h4>Java EE</h4>
                <div class="progress">
                    <div class="progress-bar progress-bar-info col-md-6" style="width: 60%;"></div>
                </div>
                <h4>HTML/CSS/JS/Bootstrap</h4>
                <div class="progress">
                    <div class="progress-bar progress-bar-info col-md-6" style="width: 80%;"></div>
                </div>
            </div>
            
            <div class="row col-md-7 col-md-offset-2">
                <br>
                <h2 class="text-center">Latest Reading</h2>
                <div class='centered'>
                <script type="text/javascript" src="http://www.douban.com/service/badge/swwol32/?selection=latest&amp;picsize=medium&amp;show=collection&amp;n=18&amp;cat=book&amp;columns=6"></script>
                </div>
            </div>
        </div>
        <footer>
            <br>
        </footer>
    </body>
</html>