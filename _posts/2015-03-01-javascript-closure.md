---
layout: post
title: 详解JavaScript的函数闭包
category: technique
---

闭包是关于独立变量的函数。换句话说，定义在闭包中的函数能够‘记住’它所被创建的环境。

<!--more-->

###词法作用域
考虑下面这个[例子（在JSFIDDLE查看）](http://jsfiddle.net/xAFs9/3/)

	function init() {
	    var name = "Mozilla"; // name is a local variable created by init
	    function displayName() { // displayName() is the inner function, a closure
	        alert (name); // displayName() uses variable declared in the parent function    
	    }
	    displayName();    
	}
	init();

函数init()中创建了一个局部变量`name`和内部函数`displayName()`。displayName()是一个内部函数，因此只在init()函数体内有效。displayName()本身没有任何的局部变量，但是它却能够访问父函数init()中定义的 name 变量。

这个例子简单清晰的说明了JavaScript中的词法作用域：

- JS中所定义的变量作用范围由其所处的源代码位置所决定
- 内部函数可以访问外部函数中定义的局部变量


###闭包
现在考虑下面这个[例子](http://jsfiddle.net/wwsun/tyyqjn4y/)：

	function makeFunc() {
		var name = "Mozilla";
		function displayName() {
			alert(name);
		}
		return displayName;
	}
	
	var myFunc = makeFunc();
	myFunc();

如果你运行上面的代码，其运行结果和前面`init()`例子中的结果是一样的。但不一样的是，内函数`displayName()`在执行之前被外函数返回了。

上面的代码可能不够直观。通常，函数内的局部变量只存在于函数运行期间，一旦`makeFunc()`结束运行，那么可以认为变量`name`不再能被访问到。但是，这个例子中我们依然能够工作，显然这与我们的预期有所不同。

对这一问题的解释就是，`myFunc`成为了闭包。闭包是一种特殊类型的对象，闭包将函数和函数所被创建的环境结合到了一起。这里的环境包括闭包所被创建时其范围内的所有局部变量。在上面的例子中，闭包`myFunc`包含了函数`displayName`和字符串`Mozilla`。

下面是一个[更有趣的例子](http://jsfiddle.net/wwsun/kzmLLrg3/)，一个`makeAddr`函数：

	function makeAddr(x) {
	    return function(y) {
	        return x+y;    
	    };
	}
	
	var add5 = makeAddr(5);
	var add10 = makeAddr(10);
	
	alert(add5(2)); // 7
	alert(add10(2)); // 12

在这个例子中，我们定义了函数`makeAddr(x)`, 其接收唯一的参数x，并且返回了一个新的函数。被返回的函数也接收唯一的参数y，并返回x和y的和。

本质上，`makeAddr`可以认为是一个函数工厂——它创建了一个函数族，可以通过指定参数用来增加一个指定值。在上面的例子中，我们使用这个函数工厂创建了两个新的函数，分别为add5和add10，一个用来增加5，另一个用来增加10。

`add5`和`add10`都是闭包。它们共享相同的函数体定义，但是存放了不同的环境。在add5的环境中，x的值为5, 而在add10的环境中，x的值为10。

###闭包实战
下面我们试着在实际开发中使用闭包。闭包允许你将一些数据（也就是环境）和操作这些数据的函数结合在一起。这非常向面向对象编程中的对象，OOP中的对象将一些数据（对象的属性）和一个或多个对象方法进行联结在一起。

因此，你可以在任何可以使用仅包含一个方法的对象中使用闭包进行类比/替换。

下面我们举一个在web页面开发中常见的例子。web通常是基于事件模型的，我们使用JavaScript代码将行为与事件相绑定，当用户触发这些事件（click, keypress等）时，行为代码被执行。我们的代码通常被作为回调函数执行：当事件发生时，用于响应事件的函数，也成为Event Handler。

[这个例子](http://jsfiddle.net/vnkuZ/)是这样的：假设我们想通过增加一些按钮来调整页面字体的大小。一种方法是通过指定body元素在像素单位下的font-size，然后设置页面中其他元素使用`em`作为单位。

CSS代码如下：

	body {
	  font-family: Helvetica, Arial, sans-serif;
	  font-size: 12px;
	}
	
	h1 {
	  font-size: 1.5em;
	}
	h2 {
	  font-size: 1.2em;
	}

我们通过点击按钮来改变body元素的字体大小，因为页面其他元素使用了相对单位`em`，因此字体大小会相应的被调整。JavaScript代码如下：

	function makeSizer(size) {
	  return function() {
	    document.body.style.fontSize = size + 'px';
	  };
	}
	
	var size12 = makeSizer(12);
	var size14 = makeSizer(14);
	var size16 = makeSizer(16);
	
函数`size12`, `size14`, `size16`分别用来调整body文本的大小为12，14， 16像素。然后，我们可以将其与按钮元素绑定，如下：

	document.getElementById('size-12').onclick = size12;
	document.getElementById('size-14').onclick = size14;
	document.getElementById('size-16').onclick = size16;

html代码如下：

    <p>Some paragraph text</p>
    <h1>some heading 1 text</h1>
    <h2>some heading 2 text</h2>

    <a href="#" id="size-12">12</a>
    <a href="#" id="size-14">14</a>
    <a href="#" id="size-16">16</a>

###使用闭包来仿造私有方法
在Java中你可以声明私有方法，私有方法表示只能在当前类中使调用该方法。

JavaScript并没有提供一个直接的方法去声明私有方法，但是可以使用闭包来仿造私有方法。私有方法的作用不仅仅在于可以有效的限制代码的访问，也为管理你的全局命名空间提供了一种强有力的方式，使得无关的方法不被公开的暴露出来。

下面来看如何定义可以访问私有函数和变量的公共函数，我们使用闭包来达到这一目的，这也被称为[模块模式](https://www.google.com.hk/search?q=javascript+module+pattern&gws_rd=cr)：

	var counter = (function() {
		var privateCounter = 0;
		function changeBy(val) {
			privateCounter += val;
		}
		
		return {
			increment: function() {
				changeBy(1);
			},
			decrement: function() {
				changeBy(-1);
			},
			value: function() {
				return privateCounter;
			}
		};
	})();
	
	alert(counter.value()); /* Alerts 0 */
	counter.increment();
	counter.increment();
	alert(counter.value()); /* Alerts 2 */
	counter.decrement();
	alert(counter.value()); /* Alerts 1 */

在前面的例子中，每个闭包都拥有自己的环境。这里，我们创建了一个单一环境用来被三个函数共享，分别是：`counter.increment`, `counter.decrement`, `counter.value`。

被共享的环境是在一个匿名函数的函数体内被创建的，这将会在其被定义后立即执行（立即执行函数）。这个共享环境包含两个私有项：变量`privateCounter`和函数`changeBy`，外界无法直接访问匿名函数内部的这两个私有项。取而代之的是，只能通过访问三个公开的接口函数，也就是被匿名函数返回的三个函数。

这三个公共函数即为闭包，它们共享相同的环境。得益于JavaScript的词法范围机制，这三个函数都可以访问变量`privateCounter`, 函数`changeBy`。

你会注意到，我们定义了一个创建计数器的匿名函数，然后立即调用这个匿名函数，并且将结果分配给`counter`变量。我们可以将这个函数存放在一个单独的变量`makeCounter`，然后使用它创建多个计数器。

	var counter1 = makeCounter();
	var counter2 = makeCounter();
	alert(counter1.value()); /* Alerts 0 */
	counter1.increment();
	counter1.increment();
	alert(counter1.value()); /* Alerts 2 */
	counter1.decrement();
	alert(counter1.value()); /* Alerts 1 */
	alert(counter2.value()); /* Alerts 0 */

可以发现，这两个计数器是彼此独立的，它们的环境在函数`makeCounter()`在调用期间是彼此不同的。闭包变量`privateCounter`在每一次包含不同的实例。

利用这种方式使用闭包可以向OOP编程一样提供非常多的好处，尤其是数据隐藏和封装。

###在循环中创建闭包：一个常常会犯的错误
考虑下面[这个例子](http://jsfiddle.net/v7gjv/)：

HTML代码如下：

	<p id="help">Helpful notes will appear here</p>
	<p>E-mail: <input type="text" id="email" name="email"></p>
	<p>Name: <input type="text" id="name" name="name"></p>
	<p>Age: <input type="text" id="age" name="age"></p>

JavaScript代码如下：

	function showHelp(help) {
	  document.getElementById('help').innerHTML = help;
	}
	
	function setupHelp() {
	  var helpText = [
	      {'id': 'email', 'help': 'Your e-mail address'},
	      {'id': 'name', 'help': 'Your full name'},
	      {'id': 'age', 'help': 'Your age (you must be over 16)'}
	    ];
	
	  for (var i = 0; i < helpText.length; i++) {
	    var item = helpText[i];
	    document.getElementById(item.id).onfocus = function() {
	      showHelp(item.help);
	    }
	  }
	}
	
	setupHelp();

在`helpText`数组中我们定义了三个提示信息，每个都使用ID与html文档中的输入域相关联。通过循环来迭代这些提示信息，将其分别与三个输入框的`onfocus`事件绑定，以在用户聚焦在不同的输入框时提示不同的信息。

如果你试着运行这些代码，会发现其并不会正常工作，无论你的焦点在哪个输入框中，提示都是关于年龄的那条信息。

原因在于被指定给`onfocus`的函数是闭包。它们包括函数定义和从`setupHelp`函数范围中捕获的环境。循环会创建三个闭包，但每一个却都共享了相同的环境。当`onfocus`的回调被执行的时候，循环被执行，并最终指向了`helpText`列表的最后一项。

解决这个问题的方法是使用更多的闭包：特别的，可以使用前面提及的函数工厂。

	function showHelp(help) {
	  document.getElementById('help').innerHTML = help;
	}
	
	function makeHelpCallback(help) {
	    return function() {
	        showHelp(help);   
	    }
	}
	
	function setupHelp() {
	  var helpText = [
	      {'id': 'email', 'help': 'Your e-mail address'},
	      {'id': 'name', 'help': 'Your full name'},
	      {'id': 'age', 'help': 'Your age (you must be over 16)'}
	    ];
	
	  for (var i = 0; i < helpText.length; i++) {
	    var item = helpText[i];
	    document.getElementById(item.id).onfocus = makeHelpCallback(item.help);
	  }
	}
	
	setupHelp();


现在一切工作正常。这里与前面不一样的是，`makeHelpCallback`函数为每一次事件绑定都创建了新的环境。[完整代码](http://jsfiddle.net/wwsun/grp341z3/)。

###性能问题
当某个问题用不到闭包的时候，在函数中嵌套函数是一件非常不明智的选择，因为这无谓的消耗了程序的运行速度和内存消耗。

举例而言，但创建一个新对象/类的时候，方法通常会被关联到对象的原型（prototype）上，而不是定义在对象构造器上。原因在于，无论构造器如何被调用，方法都可以被重新指定。

可以考虑一下下面的这个例子：

	function MyObject(name, message) {
	  this.name = name.toString();
	  this.message = message.toString();
	  this.getName = function() {
	    return this.name;
	  };
	
	  this.getMessage = function() {
	    return this.message;
	  };
	}

这里的代码中并没有得到任何有关闭包的好处，因此可以重构为：

	function MyObject(name, message) {
	  this.name = name.toString();
	  this.message = message.toString();
	}
	MyObject.prototype = {
	  getName: function() {
	    return this.name;
	  },
	  getMessage: function() {
	    return this.message;
	  }
	};

但是，重新定义原型显然也不是什么好方法，并且也是不被推荐的。因此，更好的做法是将方法追加到已有原型上：

	function MyObject(name, message) {
	  this.name = name.toString();
	  this.message = message.toString();
	}
	MyObject.prototype.getName = function() {
	  return this.name;
	};
	MyObject.prototype.getMessage = function() {
	  return this.message;
	};

在前面的例子中，被继承的原型可以被所有对象所贡献，并且方法定义也无需在每个对象创建时重新书写。你可以参考JavaScirpt的[对象模型](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Details_of_the_Object_Model)了解更多的内容。

###References

1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures