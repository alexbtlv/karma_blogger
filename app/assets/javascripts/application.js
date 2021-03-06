// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

if (document.body.className.match('registrations') && document.body.className.match('new'))  {
	$(".top-bar-section .right li").eq(0).addClass("active");
};

if (document.body.className.match('sessions') && document.body.className.match('new'))  {
	$(".top-bar-section .right li").eq(1).addClass("active");
};

if (document.body.className.match('best')) {
	$(".top-bar .left li").first().addClass("active");
};

if (document.body.className.match('fresh')) {
	$(".top-bar .left li").eq(1).addClass("active");
};

if (document.body.className.match('posts') && document.body.className.match('new'))  {
	$(".top-bar .right li").eq(0).addClass("active");
};

if ((document.body.className.match('registrations') && document.body.className.match('new'))||
	document.body.className.match('passwords') ||
	document.body.className.match('sessions')) {
	var t2 = new Trianglify();
	var pattern2 = t2.generate(1920, 1080);
	document.getElementById("wrapper").setAttribute('style', 'background-image: '+pattern2.dataUrl);	
};

if ((document.body.className.match('new') && document.body.className.match('posts') )||
	document.body.className.match('best') ||
	document.body.className.match('fresh') ||
	document.body.className.match('profile') ) {
			var t = new Trianglify();
			var pattern = t.generate(1920, 1080);
			document.getElementById("trianglify").setAttribute('style', 'background-image: '+pattern.dataUrl);
			$(document).ready(function(){
    		$('textarea').autosize();   
});
	};