---
layout: post
title: Awesome MarkDown
category: database
---





## Markdown之缘起
Markdown 是我在接触到Git的时候了解的。每一个repo Git上面都会包含一个REDEME.md 文件，并在会在每一个repo下面呈现出如下的显示。
<!--more-->

![md](/img/posts/md.PNG)

当时很好奇，看到这种.md格式的竟然可以这样去显示。于是试着去修改，当我打开之后很是惊讶，竟然是显示着用着我不熟悉的标记去表示。如下

![md1](/img/posts/md1.PNG)

其中可以看到有"\*","\+",等等。当时很是纳闷，为何如此简单给个符号能够去表示如此格式文本。深入了解以后方知是Markdown语言。也试着用Markdown语言去书写自己在Git上面的README．ｍｄ同时也利用了它写了一份不错的英文简历。于是深感Markdown的魅力无穷。今天就很浅显的去谈一谈为何Markdown的awesome。

## Markdown 简介

>Markdown 是一种轻量级标记语言，创始人为約翰·格魯伯（John Gruber）。它允许人们“使用易读易写的纯文本格式编写文档，然后转换成有效的XHTML(或者HTML)文档”。这种语言吸收了很多在电子邮件中已有的纯文本标记的特性。——————wikipedia


Markdown的目标是适用于网络的语言，而不是去取代现有的HTML。


## Why Markdown

* 纯文本书写，兼容性极强，可以用任意的文本编辑器打开。（当然也有专门的编辑器）
* 语法特变简单，只需要简单的几个符号即可。兼容HTML，可以添加HTML中的标记而无需说明。可以说上手很快，让你专注于写作本身而不是页面的排版。
* 格式转换方面， 可以转换HTML、PDF、电子书等。
*  使用与团队协作，可以使用git/svn等版本控制管理。


## Markdown的语法说明
 
Markdown用了非常少的符号就可以轻松的搞定，先预告一下。
	
	\   反斜线
	`   反引号
	*   星号
	_   底线
	{}  花括号
	[]  方括号
	()  括弧
	#   井字号
	+   加号
	-   减号
	.   英文句点
	!   惊叹号
为了能更好的了解各个符号在Markdown中表示的一样，就将本文的书写作为Demo去一一的讲解各个符号的用法。

为了能更好的看到其效果，我推荐使用[MarkDownpad](http://markdownpad.com/) 编辑器。

### 标题

我们在使用word的时候会经常使用到标题，有一标题二级标题三级等。那在Markdown如何实现？

使用‘#’的个数去表示各个标题。共有六个标题一个‘#’表示一级标题... 如下图


![md3](/img/posts/md3.PNG)

### 列表

列表的表示方式有多重，可以用\+,\-,\*来表示。如下图（用\*表示，你可尝试其他两种方式）

![md2](posts/img/md2.PNG)

### 分割线

分割线也用多种方式。利用三个\*，或者三个\-号来表示。

	***
	---
### 黑体和斜体

**黑体**的表示使用'\*\*内容\*\*'来表示或者'\_\_内容\_\_'(注意是两个\_)。

*斜体*的表示使用'\*内容\*'来表示或者'\_内容\_'。

### 图片的插入

	![图片名称](图片的URL)
在Markdown语法中不可以控制图片的大小，但可以嵌入HTML语句帮助。如
	
	 <img src="./xxx.png" width = "300" height = "200" alt="图片名称" align=center />
### 链接

* 直接用'\<url\>'表示 


	

2.	'\[显示链接\]\(url\)'


### 引用

	'>'符号之后添加要引用的内容

### 代码
####代码块
只需要四个空格，或者一个tab位就可以轻松实现

	这是一个代码区块
####一段代码

如果只需要标记一行的代码则字需要用'\`代码部分`\-'

	Use the `printf()` function.

### 反斜杠
Markdown 可以利用反斜杠来插入一些在语法中有其它意义的符号，例如：如果你想要用星号加在文字旁边的方式来做出强调效果，你可以在星号的前面加上反斜杠。
	
	\*literal asterisks\*

## 利用MarkdownPad 生成HTML或者PDF

### HTML
 在MarkdownPad编辑器中，可以按`F6`预览md文件的HTML格式。如下图

![md4](/img/posts/md4.PNG)

或者直接利用`export`导入HTML格式

### PDF

同样有两种方式在预览HTML格式的时候，在浏览器中点击‘打印’，然后通过设置输出PDF格式。如下图：

![md5](/img/posts/md5.PNG)

或者直接利用 `export`导入。

## 小缺陷

* 正如我在插入图片的时候讲过，Markdown不能有效的控制图片的大小。虽然可以嵌入HTML语句来实现，但是我感觉这样就不符合Markdown简单而又容易的理念。希望有朝一日能够不使用HTML的情况下改变图片大小。

* Markdown里支持黑体，斜体。但是不支持高亮（多种颜色），我只在网上看到说代码的高亮可以用一些编辑器实现，而脱离编辑器就不行了。




##总结
从以上可以看出，Markdown语法结构简单，使用Word时，我们会花费大量力气去排版，试图让文档变得漂亮一些。是粗体还是斜体，是宋体还是黑体，对创作来说，有那么重要吗？Markdown让你专注于写作，解放被各种word排版的束缚，你有什么理由不去试一试！ Have a try。



Reference：

https://zh.wikipedia.org/zh/Markdown

http://www.appinn.com/markdown/

http://www.yangzhiping.com/tech/r-markdown-knitr.html
