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

var t = new Trianglify();
var t2 = new Trianglify();
var pattern = t.generate(1920, 1080);
var pattern2 = t2.generate(1920, 1080);

if (document.body.className.match('registrations') ||
	document.body.className.match('passwords') ||
	document.body.className.match('sessions')) {
	document.getElementById("trianglify-register").setAttribute('style', 'background-image: '+pattern2.dataUrl);	
};

if (document.body.className.match('new') ||
	document.body.className.match('index') ||
	document.body.className.match('profile') ) {
			document.getElementById("trianglify").setAttribute('style', 'background-image: '+pattern.dataUrl);
	};