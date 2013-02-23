Admin = function(){
  this.web_calcs = {};
};

Admin.prototype.setupCalculableFields = function(){
  var self = this;
  var regex = new RegExp("[CT]\{(.+?)\}", "g");
  var calculables = $(".calculable");
  var feedback = "<em class='feedback'>No inserts attempted</em>";
  $(feedback).insertAfter(calculables);

  calculables.keyup(function(){
    var calculable = $(this);
    var attempts = [];
    var match = [];
    var calcs = [];
    var not_calcs = [];
    while (match = regex.exec(calculable.attr('value'))){
      var key = match[1];
      if (self.web_calcs[key]){
        if ($.inArray(key, calcs) == -1){
          calcs.push(key);
        }
      }else{
        not_calcs.push(key);
      }
    };
    
    var div = $('<div class="feedback"><p>Calcs to be inserted:</p></div>');
    var list = $('<ul></ul>');
    div.append(list);
    $.each(calcs, function(key,val){
      list.append($('<li>'+val+'</li>'));
    });
    if(not_calcs.length > 0){
      var diff = not_calcs.length;
      var suffix = diff == 1? "" : "s";
      list.append($('<li class="alert">It looks like you have '+diff+' insertion' + suffix + ' that don\'t match a web calc name</li>'));
    };
    if(calcs.length > 0 || not_calcs.length > 0)
      calculable.next('.feedback').replaceWith(div);
    else
      calculable.next('.feedback').replaceWith($(feedback));
  });
};

Admin.prototype.set_web_calcs = function(data){
  var self= this;
  $.each(data, function(key, item){
    var calc = item.web_calc;
    self.web_calcs[calc.name] = calc.operation;
  });
  self.setupCalculableFields();
};

Admin.prototype.getWebCalcs = function(callback){
  var self = this;
  $.getJSON('/web_calcs.json', function(data){
    self.set_web_calcs(data);
  });
};

$(function(){
  var admin = new Admin();

  admin.getWebCalcs(admin.set_web_calcs);
});
