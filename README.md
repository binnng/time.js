time.js
=======

格式化时间戳模块

### 安装

#### 1. bower

```
bower install binnng/time.js
```

#### 2. component

```
component install binnng/time.js
```

### 使用

#### 1. 直接引用

```html
<html>
<script type="text/javascript" src="time.js"></script>
<script type="text/javascript">
	var time = + new Date;

	Time(time, "%y年%M月%d日%h时%m分%s秒"); // xxxx年xx月xx日xx时xx分xx秒
	Time(time, "%y-%M-%d %h:%m:%s"); //xxxx-xx-xx xx:xx:xx

	Time.ago(time); // 刚刚

</script>
</html>
```

[demo](http://binnng.github.io/time.js/demo/index.html)

#### 2. Angular

```javascript
var myApp = angular.module("myApp", [
	"binnng/time"
]); 
```

##### factory

```javascript

myApp.controller("timeCtrl", function($scope, $time) {  
	var time = + new Date;
	
	$time(time, "%y年%M月%d日%h时%m分%s秒"); // xxxx年xx月xx日xx时xx分xx秒
	$time(time, "%y-%M-%d %h:%m:%s"); //xxxx-xx-xx xx:xx:xx
});
```

##### filter
`time.js`为angular提供了filter，你可以这样使用
```html

<p>{{timeText | date}}</p> <!-- // xxxx年xx月xx日 -->
<p>{{timeText | datetime}}</p> <!-- // xxxx年xx月xx日xx时xx分xx秒 -->
<p>{{timeText | ago}}</p> <!-- x个月前 -->

````

[demo](http://binnng.github.io/time.js/demo/angluar.html)

### API

#### Time()

根据你自定义的格式返回时间字符串

```javascript
Time(time, "%y年%M月%d日%h时%m分%s秒"); // xxxx年xx月xx日xx时xx分xx秒
```

#### Time.ago()

传入的时间戳距离现在有多久

* 刚刚
* 1天前
* 3个月前
* 10年前

```javascript
Time.ago(1413772288388); // 一天前
```

### 源码

[源码](http://binnng.github.io/time.js/docs/time.html)
