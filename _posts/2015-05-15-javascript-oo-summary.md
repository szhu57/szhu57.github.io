---
layout: post
title: JavaScript面向对象小结
category: technique
---

JavaScript 的核心是支持面向对象的，同时它也提供了强大灵活的 OOP 语言能力。本文简要介绍了使用JavaScript进行面向对象编程的基本知识，以及实现对象创建和对象继承的常用方法。

<!--more-->

## 原型

我们创建的每个对象都有一个prototype属性，这个属性是一个指针，指向一个对象，而这个对象的用途是包含可以由特定类型的所有实例共享的属性和方法。也就是说，prototype就是通过调用构造而创建的那个对象实例的原型对象。使用原型对象的好处是可以让所有对象实例共享它所包含的属性和方法。


## 创建对象
在JavaScript中最常用的创建对象的方式为组合使用构造函数模式和原型模式。使用构造函数定义实例属性，而原型模式用于定义方法和共享的属性。结果，每个实习都会有自己的一份实例属性的副本，但同时又共享着对方法的引用，最大限度的节省了内存。此外，你还可以向构造函数传递参数。

下面我们来定义一个`Person`对象，首先我们使用构造函数定义实例属性如下：

	function Person(name, age, job){
		this.name = name;
		this.age = age;
		this.job = job;
	}

这里，我们为`Person`定义了三个属性：`name`,`age`,`job`。为了能够进一步完善Person对象，可以使用原型模式为其添加实例方法`sayName()`：

	Person.prototype = {
		constructor: Person,
		sayName : function () {
			alert(this.name);
		}
	};

`Person.prototype`是一个可以被`Person`的所有实例共享的对象。它是一个名叫原型链（Prototype Chain）的查询链的一部分：当你试图访问一个`Person`没有定义的属性时，解释器会首先检查这个`Person.prototype`来判断是否存在这样一个属性。所以，任何分配给`Person.prototype`的东西对通过`this`对象构造的实例都是可用的。

上面我们完成了对`Person`对象的基本定义，其包括三个实例属性和一个实例方法。最后，我们进行对象的实例化：

	var person1 = new Person(“Nicholas”, 29, “Software Engineer”);
	var person2 = new Person(“Greg”, 27, “Doctor”);
	alert(person1.sayName === person2.sayName); //true

使用关键字`new`创建对象，它和`this`紧密相关。它的作用是创建一个崭新的空对象，然后使用指向那个对象的`this`调用特定的函数。注意，含有`this`的特定函数不会返回任何值，只会修改`this`对象本身。`new`关键字将生成的`this`对象返回给调用方，而被`new`调用的函数成为构造函数，习惯上将这些函数的首字母大写，便于识别。

## 继承

面向对象语言通常有两种继承方式：接口继承和实现继承。因为ECMAScript没有函数签名，因此无法实现接口继承；只支持实现继承，而且其实现继承主要是通过原型链来实现的。

最常用的继承实现方式是组合使用原型链和借用构造函数：使用原型链实现对原型属性和方法的继承，而通过借用构造函数来实现对实例属性的继承。我们以之前定义的`Person`对象为父类，定义其子类`Student`:

    function Student(name, class) {
        Person.call(this, name);
        this.class = class;
    }

上面，我们在`Student`构造函数中掺入了name参数，紧接着又定义了它自己的属性`class`。

    Student.prototype = new People();
    Student.prototype.sayClass = function() {
        alert(this.age);
    };
    
将`People`的实例赋值给`Student`的原型，然后又在该原型上定义了方法`sayClass()`。

组合继承是JavaScript中最常用的继承方式，而且，`instanceof`和`isPrototypeof()`也能够用于识别基于组合继承的创建的对象。


## References

1. https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Introduction_to_Object-Oriented_JavaScript