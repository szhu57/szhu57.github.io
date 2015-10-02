---
layout: post
title: JavaScipt Callback Function
category: database
---
（**学习JavaScript高阶函数，也就是回调函数**）

 在JavaScript中函数是第一类的对象，即函数是一个具有一个类类型的的特征的对象（如，同String，Array，Number等对象无异）。 既然函数实际上是对象，它就可以来“存储”变量，作为一个函数的参数，在一个函数中被创建，也可以在函数中作为返回值。
<!--more-->

因为函数是第一类对象，我们可以将其作为参数传递给其他函数，被传入的函数在其他函数执行后执行或者执行之后被返回。JavaScript的回调函数很重要，在一以下的篇幅中我们将拨开回调函数的迷雾，让你清楚的了解什么是回调函数。

**回调函数**来源于函数式编程语言。在最初，函数式编程就指出函数可用作参数，今天尽管函数式编程没有多大的扩展，但仍然被许多编程者视为一门高深莫测的武功秘籍。

 幸运的是，函数式编程语言已经被像我这样的人理解透彻了。函数式编程的精髓其实就是`callback functions`。你若细细品读此文，你会发现回调函数的实现如作为参数的普通变量并无多大区别。


##  什么是回调（高阶函数）

回调函数即高阶函数，作为参数传递给其他函数，回调函数就称之为其他函数的 `内部函数`。一个回调函数从本质上来讲其实就是一个模式，因此也常被人称之为`回调模式`。

  来看一下在`jQurey`中常见的回调函数

 	//Note that item in the click method' parameter is a function, not variable
	//The item is a callback function
	$('#btn_1').click(function(){
	alert("Btn 1 Clicked");
	});

上面的例子中，我们传递了一个函数作为`click`方法的参数。 `click`方法将调用这个回调函数。这个栗子阐述了JavaScript回调函数典型的用法，同时也是`jQeury`中用的比较广泛的。






 细思另外一个经典的回调函数：

	var friends =["Mike","Stacy",“Andy”,"Rick"];
	
	friends.forEach(function(eachName,index){
	console.log(index +1 +"."+eachName);// 1.Mike.2.Stacy,3Andy，4.Rick
	})；

我们注意到传递给`forEach`方法的参数是匿名函数。

目前为止我们传递了匿名函数作为其他函数或者方法的参数。待我们在深入一个更具体的例子来创建我们自己的回调函数之前，我们先理解回调函数是如何工作的。

## How Callback Functions Work?

当我们传递一个回调函数作为参数给另外一个函数的时候，我们仅仅传递的是函数的声明。我们并没有在参数中执行这个函数。 换句话说，我们没有在作为参数的函数中加上`()`(括号)使得函数能立即执行。

既然其他函数有一个函数声明的函数参数，其他函数就可以在任何时候执行回调函数。

注意回调函数不是立即执行的，正如起名字一样“回调”，它是在一个函数的内部当中等着被调用。所以，即使像第一个`jQuery`的例子：

	//The anonymous function is not being executed there in the parameter
	//The item is a callback function
	$('#btn_1').click(function(){
	alert("Btn 1 Clicked");
	});


匿名的函数在一个函数的内部等着被调用，即使函数没用名字，仍然可以通过`argument`对象接受。


### 回调函数是闭包

当我们传递一个函数作为参数给其他函数的时候，回调函数的执行是在其他函数当中的内部，好像回调函数的是定义在一个函数的内部一样。这就意味着**回调函数就是闭包**。如果你不知道什么是闭包推荐你读一下这篇文章 [闭包](https://developer.mozilla.org/cn/docs/Web/JavaScript/Closures)。正如我们所知，闭包可以获取到函数主体(containing funciton)的域（scope）。因此回调函数可以获取到主体函数的变量，当然亦可以获得到全局变量。

##实现回调函数的基本原则

回调虽不复杂，但是有几点原则我们还是要知道的。

### 用名字或者匿名的函数作为回调

在以上的jQuery和forEach例子中，我们都是利用的匿名函数最为回调，这是一个较为常用的模式。而另外一种方式是声明一个有名字的函数作为一个回调函数：

	 	// global variable
	var allUserData = [];
		// generic logStuff function that prints to console
	function logStuff (userData) {
    if ( typeof userData === "string")
    {
        console.log(userData);
    }
    else if ( typeof userData === "object")
    {
        for (var item in userData) {
            console.log(item + ": " + userData[item]);
        }

    }

	}

	// A function that takes two parameters, the last one a callback function
	function getInput (options, callback) {
    allUserData.push (options);
    callback (options);

	}

	// When we call the getInput function, we pass logStuff as a parameter.
	// So logStuff will be the function that will called back (or executed) inside the getInput function
	getInput ({name:"Rich", speciality:"JavaScript"}, logStuff);
	//  name: Rich
	// speciality: JavaScript

### 给回调函数传递参数

既然回调函数执行的时候与普通函数无异，我们当然可以给它传递参数。我们可以传递主体函数中任意的属性或者全局属性给回调函数。在上面的例子中我们传递的是主体函数中的变量。下面我们传递一个全局变量。

	//Global variable​
	​var generalLastName = "Clinton";
	​
	​function getInput (options, callback) {
	    allUserData.push (options);
	​// Pass the global variable generalLastName to the callback function​
	    callback (generalLastName, options);
	}


###确保回调函数是一个函数


 在调用回调函数之前去检查它是否是一个函数是明智的。
下面就重构一下`getInput`	函数以确保它是一个函数。

	function getInput(options, callback) {
	    allUserData.push(options);
	​
	    // Make sure the callback is a function​
	    if (typeof callback === "function") {
	    // Call it, since we have confirmed it is callable​
	        callback(options);
	    }
	}
如果没有去检查，那么`getInput`所调用的回调函数可能不是一个函数，如果传递给getInput函数的参数不是一个函数，那么则会发生运行时异常。

###  Callback 函数中作为方法去使用有this对象所产生的问题

当回调函数作为方法去用到this对象的时候，我们必须得改变this对象所指向的位置。否则，this对象将指向全局的windows对象，如果回调被传递的是指向windows对象this，我们将得不我我们想要的结果。
让我们用如下的代码解释：

	// Define an object with some properties and a method​
	​// We will later pass the method as a callback function to another function​
	​var clientData = {
	    id: 094545,
	    fullName: "Not Set",
	    // setUserName is a method on the clientData object​
	    setUserName: function (firstName, lastName)  {
	        // this refers to the fullName property in this object​
	      this.fullName = firstName + " " + lastName;
	    }
	}
	​
	​function getUserInput(firstName, lastName, callback)  {
	    // Do other stuff to validate firstName/lastName here​
	​
	    // Now save the names​
	    callback (firstName, lastName);
	}

在如下的代码例子中，当`clientData.setUserName`执行之后，`this.fullName`将不会在`clientData`对象中设置`fullName`的属性，而是在`windows`对象中被设置。这种情况的发生是因为`this`对象指向了`windows`对象。

	getUserInput ("Barack", "Obama", clientData.setUserName);
	​
	console.log (clientData.fullName);// Not Set​
	​
	​// The fullName property was initialized on the window object​
	console.log (window.fullName); // Barack Obama


### 利用Call或者Apply函数去保存this
 
每一个函数都`Call`,和`Apply`。 这两个方法是用于设置内部函数的this对象和传递参数给函数。如果对于call和apply不熟悉，这篇文章可以帮到你。[Apply and Call](http://www.cnblogs.com/KeenLeung/archive/2012/11/19/2778229.html)

下面我们就用Apply来修正我们的代码：

	//Note that we have added an extra parameter for the callback object, called "callbackObj"​
	​function getUserInput(firstName, lastName, callback, callbackObj)  {
	    // Do other stuff to validate name here​
	​
	    // The use of the Apply function below will set the this object to be callbackObj​
	    callback.apply (callbackObj, [firstName, lastName]);
	}
	​

利用Apply函数我们可以正确的设置this 对象，正确的执行我们的回调函数，和fullName的设置。

	// We pass the clientData.setUserName method and the clientData object as parameters. The clientData object will be used by the Apply function to set the this object​
	 getUserInput ("Barack", "Obama", clientData.setUserName, clientData);
	​
	​// the fullName property on the clientData was correctly set​
	console.log (clientData.fullName); // Barack Obama



### 多个回调函数的调用时允许的

我们可以传递不止一个函数作为参数给另外一个函数，就像我们可以传递多个变量一样。
下面是一个经典的jQuery 的AJAX 函数。

	function successCallback() {
	    // Do stuff before send​
	}


	function successCallback() {
	    // Do stuff if success message received​
	}
	​
	​function completeCallback() {
	    // Do stuff upon completion​
	}
	​
	​function errorCallback() {
	    // Do stuff if error received​
	}
	​
	$.ajax({
	    url:"http://fiddle.jshell.net/favicon.png",
	    success:successCallback,
	    complete:completeCallback,
	    error:errorCallback
	​
	});


## “回调地狱”问题和解决方案

在异步代码的执行中，代码是可以按照任意顺序执行的，有时候用大量的回调层来扩展代码是很
 正常的。下面的例子被称之为`callback hell`,因为太多的回调导致代码显得很复杂。

	var p_client = new Db('integration_tests_20', new Server("127.0.0.1", 27017, {}), {'pk':CustomPKFactory});
	p_client.open(function(err, p_client) {
	    p_client.dropDatabase(function(err, done) {
	        p_client.createCollection('test_custom_key', function(err, collection) {
	            collection.insert({'a':1}, function(err, docs) {
	                collection.find({'_id':new ObjectID("aaaaaaaaaaaa")}, function(err, cursor) {
	                    cursor.toArray(function(err, items) {
	                        test.assertEquals(1, items.length);
	​
	                        // Let's close the db​
	                        p_client.close();
	                    });
	                });
	            });
	        });
	    });
	});

也许你不会遇到这样的代码，但这里提供了两个解决方法：

* 给你的回调函数命名，而不是作为一个匿名的回调函数。

* 模块化： 把你的代码模块化，这样你就可以导出每个特殊用处的代码块。然后你可以导入这些代码块到你的大型应用中。


## 创建自己的回调函数

现在你你能已经能理解到JavaScript的回调函数了，你应该知道回调函数十分的简单但是很有用。下面一个例子中，创建了一个函数可以完成以下任务： 取回用户数据，创建一个诗容器，和欢迎用户。

	
	// First, setup the generic poem creator function; it will be the callback function in the getUserInput function below.​
	​function genericPoemMaker(name, gender) {
	    console.log(name + " is finer than fine wine.");
	    console.log("Altruistic and noble for the modern time.");
	    console.log("Always admirably adorned with the latest style.");
	    console.log("A " + gender + " of unfortunate tragedies who still manages a perpetual smile");
	}
	​
	​//The callback, which is the last item in the parameter, will be our genericPoemMaker function we defined above.​
	​function getUserInput(firstName, lastName, gender, callback) {
	    var fullName = firstName + " " + lastName;
	​
	    // Make sure the callback is a function​
	    if (typeof callback === "function") {
	    // Execute the callback function and pass the parameters to it​
	    callback(fullName, gender);
	    }
	}


调用getUserInput函数传递genericPoemMaker函数作为回调函数：

	getUserInput("Michael", "Fassbender", "Man", genericPoemMaker);
	​// Output​
	​/* Michael Fassbender is finer than fine wine.
	Altruistic and noble for the modern time.
	Always admirably adorned with the latest style.
	A Man of unfortunate tragedies who still manages a perpetual smile.
	 */

因为，getUserInput函数仅仅是取回数据，我们亦可以传递任意的回调函数给它。例如 我们可以传递一个greetUser 函数：

	function greetUser(customerName, sex)  {
	   var salutation  = sex && sex === "Man" ? "Mr." : "Ms.";
	  console.log("Hello, " + salutation + " " + customerName);
	}
	​
	​// Pass the greetUser function as a callback to getUserInput​
	​getUserInput("Bill", "Gates", "Man", greetUser);
	​
	​// And this is the output​
	Hello, Mr. Bill Gates

我们和之前一样所调用的函数是getUserInput，但是它所完成的的任务是不一样的。

正如你所见，回调函数有很大的用处。

下面是在JavaScript中使用回调函数较为频繁的场景：

* 异步执行（例如读文件和发送http请求）

* 事件监听/处理

* setTimeout 和setInterval 方法

* 泛化： 代码的简化


## 总结

本文主要谈到了什么是回调函数，以及如何使用回调函数。

JavaScript 回调函数是能强大的，可以在构建你的web应用时候提供很多便利。你因该使用回调函数当你需要为你的代码做抽象化，可读性，可维护性。

本文翻译自

 >http://javascriptissexy.com/understand-javascript-callback-functions-and-use-them/

## References

<http://c2.com/cgi/wiki?FirstClass>

<https://github.com/mongodb/node-mongodb-native>

<http://callbackhell.com/>
