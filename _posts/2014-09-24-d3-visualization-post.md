---
layout: post
title: 使用D3进行数据可视化
category: technology
---

> 先给出一个大小合适、筛选得当的概要，然后根据需要展示细节。 —— Ben Shneiderman

###D3基础知识

D3是一个JS库，用于创建数据可视化图形，能够实现交互可视化，而交互可视化能够把那些原本会对相关主题和数据视而不见的人吸引过来。 D3的全程为 Data-Driven Documents（数据驱动的文档）。D3的项目地址为：

	https://github.com/mbostock/d3/

D3的运行后过程如下：

1. 将数据加载到浏览器的内存空间
2. 把数据绑定到文档中的元素，根据需要创建新元素
3. 解析每个元素的范围资料并为其设置相应的可视化属性，实现元素的变换
4. 响应用户输入实现元素状态的过渡

需要注意的是，D3不隐藏你的原始数据。D3代码在客户端执行（即用户浏览器），因此你想要可视化的数据必须发送到客户端。假如你的数据不能共享，就不要使用D3了。


###加载和绑定数据

在D3中，为了实现映射规则，需要把数据输入值绑定到DOM中的元素。绑定即把数据“附加”或关联到特定的元素，以便将来引用数据的值和应用映射规则。D3通过 selection.data() 方法把数据绑定到DOM元素。

D3可以直接加载外部数据，如CSV或JSON，这里以JSON为例，加载外部数据的格式如下：

	var dataset;
	d3.json("graph.json", function(json) {
		console.log(json);
	});

json()接收两个参数：文件路径和用作回调函数的匿名函数。为了应对可能的数据加载异常，更通用的使用如下方式载入数据。在回调函数中增加一个可选的error参数。如果加载文件遇到问题，error中将包含web服务器返回的错误消息，data就是undefined。

	vardataset;
	d3.csv("food.csv", function(error, data) {
		if(error) { //如果error不是null，肯定出错了
			console.log(error); //输出错误消息
		} else { //如果没出错，说明加载文件成功了
			console.log(data); //输出数据
			//包含成功加载数据后要执行的代码
			dataset = data;
			generateVis();
			hideLoadingMsg();
		}
	});


未完待续。。。