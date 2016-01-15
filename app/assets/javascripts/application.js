// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//
// bootstrap-material-design
//= require bootstrap/dist/js/bootstrap
//= require bootstrap-material-design/dist/js/material
//= require bootstrap-material-design/dist/js/ripples
//
//
//= require nprogress/nprogress
//
//= require turboboost

// register NProgress animations with turbolinks events
$(document).on('page:fetch',   function() { NProgress.start(); });
$(document).on('page:change',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });
NProgress.configure({ showSpinner: false });
// handle flash message from back-end

$(document).on('turboboost:success', function(e, flash) {
  var alertInjectTarget = $('.flash-turboboost-alert .inject');
  var noticeInjectTarget = $('.flash-turboboost-notice .inject');

  // empty injection targets
  alertInjectTarget.empty();
  noticeInjectTarget.empty();

  // show flash if it has > 1 in length
  if (flash["alert"] && flash["alert"].length > 0) {
    $('.flash-turboboost-alert').show();
  } else {
    $('.flash-turboboost-alert').hide();
  }

  if (flash["alert"] instanceof Array){
    for(var i=0; i<flash["alert"].length; i++) {
      alertInjectTarget.append($('<li>').text(flash["alert"][i]));
    }
  } else {
    alertInjectTarget.append($('<li>').text(flash["alert"]));
  }

});
