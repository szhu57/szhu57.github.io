---
title: 一个分布式的数据可视化方案
category: works
icon: code-fork
tags: [node.js, AngularJS, hadoop, restful, mongoDB]
figures:
  - src: "/img/project/distributed-vis.jpg"
    height: 180
public: false
---

本项目是针对大型数据集的一个分布式数据可视化方案，该方案由三部分组成，可视化前端、数据服务端、以及数据预处理和存储端。

- 可视化前端基于AngularJS和D3进行图形可视化界面的开发，并运行于Node.js运行时环境中，消费来自数据服务端的数据。
- 数据服务端是一个Java RESTful服务，是对数据集进行数据分析与挖掘的一组功能的打包，包括常规的统计量分析与计算、关联规则挖掘、聚类分析等。
- 数据预处理基于Hadoop集群，使用Map/Reduce脚本程序对输入数据进行预处理，输出数据存储到MongoDB中，为数据服务端提供数据。