---
title: 基于大数据平台的Web日志分析及可视化
category: works
icon: code-fork
tags: [visualization, hadoop, mongoDB]
figures:
  - src: "/img/project/seu-vislog.PNG"
    height: 180
public: false
---

本项目主要针对B2B网站的大量服务器日志进行分析，基于大数据平台对日志数据进行分析处理，还原用户的访问路径、站点的流量分布，进而分析用户的喜好与行为习惯，最终为网站优化提供决策支持。数据来源于`中国制造网`生产环境中的真实日志数据。

在系统架构方面，我们选择Hadoop作为数据处理平台，MongoDB作为数据存储平台，再次基础上构建B/S架构的日志分析可视化系统，希望将杂乱的日志信息通过可交互图形的方式帮助使用者能够以更直观的方式理解数据分析的结果。本项目为东南大学数据与智能实验室与焦点科技联合开发的实验性项目。