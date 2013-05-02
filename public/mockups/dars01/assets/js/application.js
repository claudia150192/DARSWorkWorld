$(document).ready(function() {
   
  $('#logRegTabs .btn').click(function () {
      $('#logRegTabs .btn').removeClass('active');
      $(this).addClass('active');
      $('.logingTabWrap, .registerTabWrap').toggleClass('active');
  });
 
});