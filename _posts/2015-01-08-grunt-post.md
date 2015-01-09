---
layout: post
title: Grunt, 基于JavaScript的项目构建工具
category: technique
---

由于前端工作中承担了越来越多的任务，使得现代Web开发中的前端变的足够复杂，因此应运而生的是对此类任务的自动构建工具。Grunt类似于`Make`或`Ant`，它可以完成诸如编译、单元测试等常用工作，从而帮助开发者进行自动重复的工作，节省开发者的时间。Grunt通常与我们[之前](http://wwsun.me/posts/bower-post.html)提到的`Bower`配合使用。

<!--more-->

###Grunt基础
为什么要用Grunt？自动化你的任务，诸如代码最小化、代码编译、单元测试、代码规范校验等等重复的任务，你必须要做的工作越少，你的工作就变得越简单，从而避免重复人工操作中的误操作。Grunt同样依赖于Node，使用NPM进行安装。通过文件`Gruntfile`进行配置任务流程，这样你和你的团队就可以在之后非常简单的执行这些任务。

安装Grunt前，首先要确保你的Node和NPM处于新版本。你可以使用如下命令升级NPM：
	
	npm update -g npm

我们需要知道的是，Grunt包括三大组成部分：GruntJS CLI, GruntJS Task Runner, Grunt Plugins，分别代表Grunt的命令行工具、任务运行器、和插件库。

Grunt基本的三个概念分别为：Task, Target, Options
###安装Grunt
首先你要做的是全局安装Grunt CLI，安装过程可能需要你具备管理员权限。

	npm install -g grunt-cli

这个过程会自动将`grunt`加入到你的path环境变量中。需要注意的是，安装了grunt-cli并不会同时安装grunt task runner。 CLI的主要工作就是，当你运行grunt命令时，CLI载入本地安装的Grunt库，应用`Gruntfile`中的配置项，执行你所请求的任务。你可以通过[链接页面](https://github.com/gruntjs/grunt-cli/blob/master/bin/grunt)查看grunt的源代码。


###已有项目如何增加Grunt支持

Grunt本身只是NPM得一个Package，因此只要使用NPM在项目中安装Grunt的依赖即可。通常我们将Grunt放在`devDependencies`中。使用如下命令将Grunt添加到`package.json`文件中，这个文件被用来存储已经作为npm模块发布的项目元数据(也就是依赖模块)：

	npm install grunt --save-dev

Grunt主要通过`Gruntfile.js`文件配置或者定义Grunt任务和加载Grunt插件。添加Grunt插件同样借助于`npm install <module> --save-dev`命令。这不仅会在本地安装`<module>`，它还会适用于一个波浪形符号的版本范围自动将所安装的`<module>`添加到项目依赖中。

在开始之前，我们通常会安装两个插件，分别是`load-grunt-tasks`[3]和`time-grunt`[4]。第一个插件的作用是用来自动读取package.json文件中的`dependencies/ devDenpendencies/ peerDenpendencies`，从而自动加载与给定模式匹配的Grunt任务。第二个插件的作用是在`console`窗口中显示任务的执行状态。

为了示例`Gruntfile.js`文件，我们还安装了官方的`grunt-contrib-copy`和`grunt-contrib-clean`文件用来进行文件的拷贝和清除。借助这几个插件，我们编写的一个简单的`Gruntfile.js`文件如下：

	'use strict';
	
	module.exports = function (grunt) {
	    require('load-grunt-tasks')(grunt);
	
	    require('time-grunt')(grunt);
	
	    var config = {
	        app: 'app',
	        dist: 'dist'
	    };
	
	    grunt.initConfig({
	        config: config,
	        copy: {
	            dist: {
	                files: [
	                    {
	                        expand: true,
	                        cwd: '<%= config.app %>/',
	                        src: '*.html',
	                        dest: '<%= config.dist %>/',
	                        ext: '.min.html'
	                    }
	                ]
	            }
	        },
	
	        clean: {
	            dist: {
	                src: ['<%= config.dist %>/**/*'],
	                //filter: 'isFile' //only remove file, rather than folder
	                filter: function (filepath) {
	                    return (!grunt.file.isDir(filepath));
	                }
	            }
	        }
	    });
	};

一个Gruntfile通常由下面几部分组成：

- 包装函数： `module.exports = function(grunt) { ... }`
- 项目和任务配置: `grunt.initConfig(...)`
- 加载的Grunt插件和任务
- 自定义任务


实际上，Grunt任务的书写方式可以有很多种，这里我们只是推荐一种最通用的书写方式。我们在`initConfig`中定义了两个task，分别为`copy`和`clean`。更多的关于task的配置，请参考[2]

###References

1. https://github.com/gruntjs/grunt-cli/blob/master/bin/grunt
2. http://gruntjs.com/configuring-tasks
3. https://github.com/sindresorhus/load-grunt-tasks
4. https://github.com/sindresorhus/time-grunt