$('#text').keypress(
  function(e){
    if( e.keyCode==13 ){
      $.get('/send',{text:$('#text').val()});
      $('#text').val('');
    } 
  }
);

(function() {
  var last = 0;
  setInterval(
    function(){
      $.get('/update',{last:last},
        function(response){
          last = $('<p>').html(response).find('span').data('last');
          $('#chat').append(response);
        }
      );
    },
  1000);
})();

(function() {
  var last = 0;
  setInterval(
    function(){
      $.get('/users',
        function(response){
        	$('#users').empty();
          	$('#users').append(response);
        }
      );
    },
  1000);
})();
