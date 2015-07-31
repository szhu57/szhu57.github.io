---
layout: post
title: Java常问面试题总结
category: knowledge
---

从五六月份就开始着手找实习，我想做的方向是java。买了一本《java面试宝典》看着还可以吧，基本上重要的java内容都覆盖了。 但是觉得不太全面，今天起决定去总结在面试中可能会问到的java知识，一，不仅可以系统的梳理我所学的java知识，二，为以后的面试可以做充足的准备。
<!--more-->
接下来我围绕着面向对象编程和其特征来总结，主要是java的功能、集合、垃圾回收器、异常处理、JDBC、Remote Method Invocation(RMI)、Servlet和JSP。


## 面向对象编程（OOP）

Java 是一个计算机编程语言，具有并发、基于类和面向对象等特点。面向对象的语言有什么优点呢？

* 代码的模块化开发，易于维护和修改

* 代码重用

* 提高代码可靠性和灵活性

* 易于代码理解

面向对象的编程包含许多的特点，像封装、继承、多态和抽象。下面我们一一来分析。

### 封装

封装可以使得对象隐藏自己属性和方法。 每一个对象可能有多个方法，这些方法可以被其他对象所调用从而修改其内部的数据。 在java中有四种修

饰符号：public、默认protected和private。 不同的修饰符所修饰的类可以对其他类（相同包和不同包的类）都会有不同的访问权限。那封装有什么好处呢？

* 对象中的属性可以被保护

* 代码更易于维护，因为一个对象的属性和方法能被独立的改变或者别继承。

* 提高模块化编程，降低对象之间的耦合性。

### 多态

多态就是允许你将父对象设置成为和它的一个或多个子对象相等的技术，赋值之后，父对象就可以根据当前的赋值给它的子对象的特性以不同的运作方式。

简单来说就是允许将子类类型的引用赋值给父类类型的引用。

	
	class A {
		public void method(){
		System.out.println("a");
		}
		// public void method_1(){
		// 	System.out.println("a");
		// }
		}
	class B extends A {
		public void method(){
		System.out.println("B");
		}
	}

	public class polo{
	public static void main(String[] args){

		A a = new B();
		//a.method_1();
		a.method();//输出为B

	}
	}

如上面的例子，如果子类覆盖了父类的方法，那些在多态的机制下，将调用的是子类的方法。如果此时调用的父类的独有方法，将调用父类中的方法。

如果调用子类中特有的方法，那么将出现编译错误。如果想正常的调用子类的方法可以用`B(a).method()`的方式。

### 继承

继承是一个类通过关键字`extends`的方式获得另外一个类中的方法和属性。继承的类叫做子类，被继承的类叫做基类或者父类。

### 抽象

抽象是从具体实例相反的一个一个理念，因此定义一个抽象的类是根据其实现的功能，而不是其实现的细节。java支持这种抽象的类露出出其接口而不内部无需实现所有的方法。

## General Questions about Java

**1**.**什么是JVM?为什么java又称为独立平台的开发语言?**

 JVM 是一个能够执行java字节码的虚拟机。 每一个java的源文件被编译成为一个字节码（class）文件， 可以被JVM执行。

Java具有“writer once run everywhere”的特性，而实现这种特性的基础是jvm，因为当java编译器编译成java程序时，生成的是与平台无关的

字节码，这些字节码不面向任何具体的平台，它只面向jvm。 不同平台的jvm都是不同的，但他们都提供相同的接口。


 

**2**. **JDK和JRE的区别？**

The Java Runtime Environment（JRE）是JVM执行java程序的基础。 它也可以在浏览器作为插件执行applet。TheJava Development Kit

(JDK)是具有所有java的软件开发工具，包括JRE、编译工具（`javac`,`java`), 以便开发人员开发、编译和执行java 应用程序。

* `static`关键字表示什么意思？ 在java中 可以覆盖`private`或者`static`方法吗？

`static`表示一个成员变量或方法，可以不直接获取成员变量或者调用方法而不需要实例化一个对象（在内存中是存储在全局共享变量中）。不能直接覆盖一个静态的方法，因为方法的覆盖是在运行时动态链接的，而静态方法是在编译时期静态链接的。

**3**.** 非静态变量能被静态的成员所访问吗？**

不能，静态成员存储在一个静态区里面，静态变量在被JVM装载的时候已经初始化。如果要访问一个非静态的变量而在没有实例化的情况之下，编译器会报错。因为那些非静态变量都还没有被创建。

**4**. **java支持什么数据类型？什么是自动装箱和拆箱？**

		byte

		short

		int

		long

		float

		double

		boolean

		char

自动装箱时指基本数据类型被java编译器自动的转换为期对应的包装类对象。 例如，编译器把`int`类型转换成为`integer`,`double`转换成`Double`。相反则称之为。自动拆箱。

**5**. **什么是覆盖(overriding)和和重载(overloading)？**

方法的重载是在相同类当中的两个或者多个方法，其方法名字相同但是参数不同。方法的覆盖是子类重定义父类的方法，覆盖的方法必须是具有相同的方法名、参数列表和返回值类型。

**6**.**什么是构造器、构造器的重载和拷贝构造器？**

一个对象被创建的时候会调用构造器。在每个类中都要有构造器，可以不写(利用默认的构造器)。构造器的重载类似于函数的重载。不同的构造器创建不同的类对象，每个构造器都有不同的参数列表。java支持复制构造函数，但是必须手动去写。


**7**. **java支持多继承吗？**

不支持。每个类只能继承一个类，但可以实现多个接口。

**8**. **接口和抽象类的区别？**


* 接口中所有方法都是抽象的。抽象类中的方法可以包含抽象和非抽象方法

* 一个类可以实现多个接口，但只能继承一个抽象类

* 一个类所实现的接口必须实现接口中全部方法，类所继承的抽象类中可以不实现其全部抽象方法，但必须声明为抽象类。

* 抽象类可以实现一个接口可以不提供实现接口中的全部方法。

	 	  //接口
		interface Window{

             public void draw();

             public void putColor();

             public void setPosition();

  	    }
	  	 /**

    	  *抽象类，不实现需要的方法。而实现的不需要的方法的方法体设为空，

     		 */   
	 	 abstract class DesignedPage implements Window{

             public void draw(){}

             public void putColor(){}

  		 	  }
		 /**

      		 * 具体实现类，实现特定的方法，该类中只有需要的方法

   	  	  */

    	  public class DesingedPageA  extends DesignedPage{

             public void setPosition(){

                   //set the window position

             }   

  	 	 }
	

* 接口中变量的声明默认是`final`,抽象类可以实非`final`。

* 接口中的成员默认的修饰符是`public`,抽象类中可以实其他的修饰符。

* 接口和抽象类都不能被实例化。

**10**. **java中是传递引用还是值？**

不管java的参数类型是什么一律传递参数的副本。

> When you're passing primitives into a method, you get a distinct copy of the primitive, when you 
> passing a reference into a method, you get a copy of the reference.——Thinking in java

当传递值的时候，实际上是传递的值的副本，因此无论在方法函数中怎么修改其值，其结果都是改变的副本的值，而不是原值。

当传递的是引用时，实际上传递的是引用的副本。引用的副本指向的是对象的地址，通过引用的副本找到地址中的值，也就修改了对象。

## Java Threads

**11**. **线程和进程的区别？**

进程是一个程序的执行。进程是资源分配的基本单位，也是调度运行的基本单位。

线程：轻量级进程。一个进程可以包含多个线程，并且至少有一个主线程，同时同一进程的线程共享更多的资源heap，stack。（有自己的私有堆栈）

线程是处理机调度的基本单位。

**12** **创建线程的两种方式，那种方式好一些？**

* a class extends the `Thread`类。

		class MyThread extends Thread{
	

				public void run(){
					//code 
						}
		}
		//start Thread
		MyThread t1 = new MyThread();
		t1.start();
* a class implements the `Runnable` interface

		class MyThread2 implements Runnable{
	
		public void run(){}
		}
		//start Thread
		
		new Thread(new MyThread2()).start();

利用实现`Runnable`接口好一些，一方面，这样就不需要继承`Thread`类。这种情况下就可以实现“多继承”的特点，另一方面，实现接口比较容易。

**13**.** 线程的生命周期状态？**

* `new`： 线程处于就绪状态，但是没有立即开启运行。

* `Runnable`: JVM正在执行线程代码

* `Blocked`:线程处于阻塞状态，等待监视锁。

* `Waiting`: 线程等待另外一个线程完成指定的操作（如notify，notifyAll）

* `Timed_Waiting`: 一个线程等待另外一个线程来执行特定的操作直到指定的等待时间（sleep）

* `Terminated`: 线程执行结束

![Thread_State](/img/posts/Thread.png)

Source: <http://www.tutorialspoint.com/java/java_multithreading.html>

**14**. **synchronized 方法和synchronized代码块的区别？**

在Java编程语言中，每个对象有一把锁。 线程可以通过关键字`synchronized`获取对象从而获得对象锁。`synchronized`可以应用于方法上加锁（粗粒度）可以在代码块加锁（细粒度）。

	 synchronized void writeLogEntry() {...}
	
	 synchronized(anObject) { ... }

**15**. **什么是死锁？ **

当两个进程相互等待对方结束释放资源，其结果是两个进程无穷的等待下去。

## Java Collections

**16.** **几个基本集合框架？**

java容器类一共有两种类型：`Collection`和`Map`.

Collection 和 `Map`的区别在于容器内每个槽所存储的元素个数不同。

`Collection`类型中，每个槽有一个元素；`Map`中持有key-value（键值对）

* `Collection`子类：

1 --List：元素有序存放，允许重复

   ---ArraList： 类似于数组，擅长随机访问，但是删除添加元素较慢

   ---LinkList: 类似于单链表，删除元素移动元素方便，随机访问元素较慢

2 --Set：元素无序，不能含有重复元素。
 
   ---HashSet： 使用散列表

   ---TreeSet： 使用红黑树

   ---LinkedHashSet： 使用链表结合散列表

3 --Queue： 先进先出的容器

* `Map`子类：

-- HashMap： 

-- HashTable

-- TreeMap
   