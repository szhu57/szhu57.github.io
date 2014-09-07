---
layout: post
title: Beginning JSON in Java
category: technology
---

###JSON
21世纪初，Douglas Crockford寻找一种简便的数据交换格式，能够在服务器之间交换数据。当时通用的数据交换语言是XML，但是Douglas Crockford觉得XML的生成和解析都太麻烦，所以他提出了一种简化格式，也就是JSON。

JSON, JavaScript Object Notation, 它是一种轻量级的数据交换格式，非常适合于服务器与JavaScript的交互。对消息通信而言，JSON的优势是比XML更简单，因而可以大大提高开发效率，代码也更为简单。

###JSON语法
JSON的语法格式非常简单，可以简单的概括如下：

- 并列的数据之间用	","
- 映射用				":"
- 并列数据的集合用	"[]"
- 映射的集合用		"{}"

例如我们可以用如下的JSON文件描述一张图的点集和边集：
	
	{
		"nodes": [
			{ "name": "NodeName"},
			{ "name": "NodeName"}
		],
		
		"links": [
			{
				"source": INDEX,
				"target": INDEX,
				"value": WEIGHT
			},
			{
				"source": INDEX
				"target": INDEX
				"value": WEIGHT
			}	
		]
	}

解析该文件我们可以发现，这个JSON文件包含了两个数组，分别是 nodes 和 links 。而每个数组中又包含了不同的映射对。到此，JSON的语法基本就结束了。下面我们讨论JSON在Java中的应用。

###JSON IN JAVA
JSON在Java上的实现最常用的为Json lib， 其最新版即相关的依赖包的下载地址如下：
	
	http://download.csdn.net/detail/dqsweet/5246564

JSON只有两种数据结构：

1. Map  用 { } 表示
2. Array 用 [ ] 表示

####Map
简单的说就是Java中的Map，名称-值对的形式给出，名称和值之间用“：”隔开，两个Map之间用“，”隔开，一般表示形式如下：
{'key1':'value1','key2':'value2'}


####Array
就是普通意义上的数组，一般形式如下：
['arr1','arr2','arr3'];

####要点：

1. JSON的数据结构只有两种；
2. 可以嵌套表示，比如Array中可以嵌套Object等；
3. 记住：Object是以｛｝表示，Array是以[  ]表示；

####JSON Lib
利用JSON lib可以构建和解析json文件。具体的使用方法可以参考其官方api，这里以构建JSON对象为例，介绍JSON lib的基本使用方法：
	
	http://www.json.org/java/

创建JSON对象

	JSONObject json = new JSONObject();	//创建空白

或
	
	JSONObject json = JSONObject.fromObject(object);//从已有字符串构建

其输出为：
	
	{
		//...
	}

创建JSON数组
	
	JSONArray array = new JSONArray();

其输出为：
	
	[
		//...
	]

一个JSON数组中实际是包含了若干的JSON对象，而一个JSON对象其实包含了若干的JSON键值对。

例如：
	
	JSONObject json = new JSONObject();//the whole document	
	JSONArray array = new JSONArray();//a json object array
	JSONObject element = new JSONObject();
	element.put("name","Allen")
	element.put("school","seu");
	array.add(element);
	json.put("student", array);

输出结果为
	
	{
		"student": [
			{
				"name": "Allen",
				"school": "seu"
			}
		]
	}

###References

1. http://www.ibm.com/developerworks/cn/web/wa-lo-json/
2. http://www.ruanyifeng.com/blog/2009/05/data_types_and_json.html
3. http://www.json.org/java/
4. http://blog.csdn.net/xiazdong/article/details/7059573
