---
layout: post
title: 使用Bower进行前端依赖管理
category: technique
---

通常网站可以由很多东西组成，包括框架、库、静态资源、工具包等等。Bower的作用就湿用来管理所有的这些东西。你可以简单的理解为：Bower是一个前端依赖管理工具，可以用来管理Bootstrap，jQuery等常用的前端库或框架。

<!--more-->

###Bower基础入门
Bower是一个客户端技术的软件包管理器，它可用于搜索、安装和卸载如JavaScript、HTML、CSS之类的网络资源。其他一些建立在Bower基础之上的开发工具，如YeoMan和Grunt，这个会在以后的文章中介绍。

使用Bower的优势是让你能够轻松的管理前端依赖，而不用手动的去各个网站下载资源，Bower能够通过通用的方式自动下载各项资源，从而节省你的时间，轻松的管理项目的前端依赖，并且升级也非常的简单。

###安装Bower
Bower依赖于Node.js，Git，因此你需要提前安装好，才能正常安装bower。 Bower可以通过NPM进行安装：

	$ npm install -g bower 	//全局安装bower
	$ bower --version 		//检查版本确认是否安装好
	1.3.12  				//本文使用的bower版本

###基础使用

Bower的基础使用，可以参考[这篇文章](http://segmentfault.com/a/1190000000349555)。本文依然会介绍Bower的常用使用细节，但综合了多篇文章和Bower的官方文档。下面我们通过一个示例项目来使用Bower,首先创建项目目录

	$ bower help			//帮助命令
	$ mkdir bower-in-action
	$ cd bower-in-action
	$ mkdir jquery-in-action
	$ cd jquery-in-action
	
安装jQuery和Bootstrap依赖

	$ bower install jquery
	$ bower install bootstrap

项目会自动生成`bower_components`目录，jquery和bootstrap的相关文件都会被下载到该文件夹内。

安装依赖可以有很多种方式，主要包括以下4种方式：

	# registered package
	$ bower install jquery
	# GitHub shorthand
	$ bower install desandro/masonry
	# Git endpoint
	$ bower install git://github.com/user/package.git
	# URL
	$ bower install http://example.com/script.js
	
卸载包

	$ bower uninstall jquery

搜索相关的依赖，你可以使用如下工具

	http://bower.io/search/

当然你也可以使用一个bower指令来搜索，但不如web页面来的方便直观

	$ bower search bootstrap

###bower.json和.bowerrc

为了更好的管理依赖，我们通常通过`bower.json`,`.bowerrc`进行管理项目的依赖。可以通过下面的的命令生成`bower.json`文件：

	bower init

它会自动提示你输入一系列的内容，以生成最终的文件，包括项目名称、版本号、作者信息、项目描述信息、关键词、开源证书等等。关于bower.josn文件的详细解释可以参考[链接页面](http://bower.io/docs/creating-packages/#bowerjson)，这里示例文件如下：
	
	{
	  "name": "jquery-in-action",
	  "version": "0.0.0",
	  "authors": [
	    "Weiwei <ww.sun@outlook.com>"
	  ],
	  "description": "test bower using jquery & bootstrap",
	  "keywords": [
	    "jquery",
	    "bootstrap"
	  ],
	  "license": "MIT",
	  "ignore": [
	    "**/.*",
	    "node_modules",
	    "bower_components",
	    "test",
	    "tests"
	  ],
	  "dependencies": {
	    "bootstrap": "~3.3.1",
	    "jquery": "~2.1.3"
	  },
	  "devDependencies": {
	    "angular": "~1.3.8"
	  }
	}

需要注意的是，这里有两个版本的依赖，一个是`dependencies`，另一个是`devDependencies`，分别代表生产环境和开发环境中的依赖包，两种环境在很多情况下有区别，比如在开发环境中我们通常使用jquery.js、开启详细的日志；在生产环境中通常使用jquery.min.js、向用户暴露简单的错误信息。它们可以分别通过下面两个指令自动添加：

	bower install jquery --save			//添加到dependencies
	bower install angular --save-dev		//添加到devDependencies

下面我们来编写一个示例页面，这里省略了HTML的头尾标记，只保留了body内的内容：
	
	<button>Animate Me!!</button>
	<div style="background: red; height: 100px; width: 100px; position:absolute;"></div>
	
	<script src="../bower_components/jquery/dist/jquery.js"></script>
	<script>
	    $(document).ready(function () {
	        $('button').click(function () {
	            $('div').animate({left: '250px'});
	        })
	    });
	</script>

我们发现，这里有一个问题是必须用 `../bower_components` 的相对定位方式才能找到相关的资源。解决方法是配合使用grunt，而grunt和bower天生就是应该一起使用的。本文不具体介绍grunt，感兴趣的可以去grunt的官网查看相关内容。

下面介绍`.bowerrc`文件，它是一个json文件，你可以直接创建该文件，通过该文件我们可以指定bower的依赖目录，网关服务器，超时连接等配置信息，内容如下：

	{
	  "directory": "bower_components",
	  "proxy": "",
	  "https-proxy": "",
	  "timeout": 60000
	}

###References

1. http://bower.io/
2. http://bower.io/docs/creating-packages/#bowerjson
2. http://bower.io/docs/tools/
3. http://segmentfault.com/a/1190000000349555