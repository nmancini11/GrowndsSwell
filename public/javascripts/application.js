// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
	$( "#search-text" ).autocomplete({
		source: "http://localhost:3000/ajax/users.json",
		minLength: 2
	});
	
	$( "#venue-field" ).autocomplete({
  	source: "http://localhost:3000/ajax/venues.json",
  	minLength: 2,
  	select: function(event, ui) {
      $('#venue_id').val(ui.item.id);
    }
  });
  
  $( "#start_date" ).datetimepicker({
    showButtonPanel: false,
  	stepMinute: 15,
  	showOn: "button",
    buttonImage: "../images/calendar.gif",
    buttonImageOnly: true,
    dateFormat: "yy-mm-dd",
    timeFormat: "hh:mm:ss"
  });
  
  $(".iframe").fancybox({
    'scrolling' : 'no',
    'width'     : 412,
    'height'    : 212 
  });
  
  $(".invite").fancybox({
    'type'      : 'iframe',
    'scrolling' : 'no',
    'width'     : 412,
    'height'    : 370 
  });
  
  $(".settings").fancybox({
    'scrolling' : 'no',
    'type'      : 'iframe',
    'width'     : 590,
    'height'    : 400
  });
  
});