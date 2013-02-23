var WWWeb = function(){
  this.menu = {};
};

WWWeb.prototype.flash = function(){
  $('div#flash_notice').delay(3000).slideUp();
};

WWWeb.prototype.addDatePickers = function(){
  $('input.textfield.date_time').datepicker({changeMonth:true, changeYear:true, yearRange:'-150:+0'});
}

WWWeb.prototype.bindDefaults = function(){
  $("input[data-bind-default-element]").each(function(){
      var target = $(this);
      var boundTo = $("#"+$(this).attr("data-bind-default-element"));
      boundTo.blur(function(e){
        if(target.attr("value") == "")
          target.attr("value",$(this).attr("value"));
      });
  });
}

WWWeb.prototype.setupSideMenu = function(){
  $('#group_navigation').treeview({unique:true, collapsed:true});

};

WWWeb.prototype.setupMainMenu = function(){ // may need to refactor this into a separate class, getting big.

  var mainMenu = $("ul#main_menu");
  mainMenu.addClass("main").addClass("menu");
  
  function handleMenuKeys(e){
    if(e.which == 27){ // esc key
      cancel(); //("ul.subnav").slideUp('slow');
    }

    if(e.which < 65 || e.which > 90)
            return;

    e.stopPropagation();
    var character = String.fromCharCode(e.which).toUpperCase();
    
    /// TODO: wouldn't it be nice to generalize this some more?
    if(e.shiftKey && e.altKey && ['C','D','S','I'].indexOf(character)!= -1){ 
      var link = $('a[data-accesskey="'+character+'"]');
      if(link){
        link.parent().click();
        $(document.documentElement).keydown(function(e){
            handleCommandKeys(link,e);
        });
      };
      return false;
    };
  };

  function handleCommandKeys(link, e){
      var c = String.fromCharCode(e.which).toUpperCase();
      var parent = link.parent();
      var innerLink = parent.find('ul.subnav li a[data-accesskey="'+c+'"]');
      if (innerLink.length === 0)
        innerLink = parent.find('ul.subnav li a[data-accesskey="'+c.toLowerCase()+'"]');

      if(innerLink && innerLink.attr('href')){
        e.stopPropagation();
        innerLink.click();
      }

  };

  function cancel(){
    $('ul.subnav.open').removeClass('open').slideUp('slow');
    $(document.documentElement).unbind('keydown');
    $(document.documentElement).keydown(handleMenuKeys);
  };

  $("ul#main_menu > li").click(function(e) {
    var subnav = $(this).find("ul.subnav");
    // close any open menus
    if(!subnav.hasClass('open'))
      cancel(); //('ul.subnav').slideUp('slow');
		
    //Following events are applied to the subnav itself (moving subnav up and down)
		
        subnav.slideDown('fast'); //.show(); //Drop down the subnav on click
        subnav.addClass('open');

		$(this).hover(function() {
		}, function(){
			$(this).find("ul.subnav").removeClass('open').slideUp('slow'); //When the mouse hovers out of the subnav, move it back up
		});

		//Following events are applied to the trigger (Hover events for the trigger)
		}).hover(function() {
			$(this).addClass("subhover"); //On hover over, add class "subhover"
		}, function(){	//On Hover Out
			$(this).removeClass("subhover"); //On hover out, remove class "subhover"
	});
  var self = this;
  // this covers all the anchor w/ data access keys
  $("ul#main_menu > li a[data-accesskey]").each(function(index, html){
    var element = $(html);
    self.setVisualForShortCut(element);
  });

  $(document.documentElement).keydown(handleMenuKeys);

  $('A.dialog').fancybox({titleShow:false,
    onStart : cancel,
    onComplete: function(){
        $('#fancybox-content input.autofocus').focus();
        $('#fancybox-content a[rel="prev"]').click(function(){ $.fancybox.close(); });
    }
  });

};

WWWeb.prototype.setupQuestionForms = function(){
    var buttons = $('input[type="submit"][name="accept"]');
    buttons.attr('disabled',true);
    var answers = $('span.question .answer');
    answers.focus(function(e){
        buttons.attr('disabled',true);
        $(this).next().removeAttr('disabled');
    });
    $('.question.new .answer').first().focus();
};

WWWeb.prototype.setupContinueButton = function(){
    var continueForm = $('#continue_button').parent();
    continueForm.click(function(){
       continueForm.find('.hidden.answer').remove();
       $('.textfield.answer').each(function(){
           var el = $(this);
           continueForm.append($("<input type='hidden' name='"+el.attr('name')+"' value='"+el.val()+"'/>"));
       });
    });
}

WWWeb.prototype.setVisualForShortCut = function(element){
  var code = element.attr('data-accesskey');
  if(code)
    element.html(element.html().replace(code, "<em class='accesskey'>"+code+"</em>"));
};

WWWeb.prototype.setupAllInputsUi = function(){
  var answerBoxes = $('.answer');
  var here = window.location.href;
  var caseId = here.slice(here.lastIndexOf('/')).replace('#','');
  var urlbase = '/cases'+caseId+'/situations/';
  kase = {};
  urls = {};

  var new_link = $('a#new_situation_link');
  new_link.attr('href',new_link.attr('href')+'?return_to=all_inputs');

  answerBoxes.addClass('clickable');
  answerBoxes.wrapInner(function(){
    var el = $(this);
    var sid= el.attr('data-situation');
    var qid = el.attr('data-question');
    var sitHandle = 'situation_' + sid; 
    var url = urlbase + sid + '/questions/' + qid;
    var complete = !el.hasClass('.incomplete');

    if(!kase.hasOwnProperty(sitHandle))
      kase[sitHandle] = {id: sid, answers : [], complete : complete};

    kase[sitHandle].answers.push({question : qid, answer : el.text(), accepted : complete});

    if(complete === false){
      kase[sitHandle].complete = false;
    }

    urls[url] = sitHandle;

    return '<a href=\''+ url + '\' />';
  });
  this.kase = kase;
  this.urls = urls;
  $site = this;
  answerBoxes.children('a').fancybox({onStart:function(el){
    var selUrl = $(el).attr('href');
    var situation = $site.kase[urls[selUrl]];
    if($site.current_situation_id && $site.current_situation_id != situation.id){
      return false; // do more?
    }
  },
    onComplete : function(el){
      $('#fancybox-content span.question input[type="submit"]').click(function(e){
        var self = $(this);
        self.next('img').show();
        var url = $(el).attr('href'); 
        var name = url.substring(url.lastIndexOf('/')+1);
        var formUrl = url.substring(0,url.indexOf('/question')) + '/accept_all';
        var form =  $('form[action="'+formUrl+'"]');
        var field = form.children('input[type="hidden"][name$="[questions]['+name+']"]');
        field.attr('value', self.prev().attr('value'));
        form.submit();
      });         
    }
  });

  answerBoxes.click(function(e){
    if(e.target.nodeName.toUpperCase() === 'TD')
      $(this).children('a').click();  
  })

}

$(function(){
  $('#js-notify').hide();

  var site = new WWWeb();
  //createPopups();
  site.addDatePickers();
  site.setupMainMenu();
  site.setupSideMenu();
  site.bindDefaults();
  site.setupQuestionForms();
  site.setupContinueButton();
  site.flash();
  if($('#all_inputs').length === 1){
    site.setupAllInputsUi();
  }
  //$('a.help').fancybox({ 'hideOnContentClick' :true, 'titleShow':false});
});
