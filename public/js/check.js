
$('#pass2').keyup(function() {
  if ( $("#pass2").val() == $("#pass1").val()) {
  	$("#mensaje-password").empty();
  } else {
  	$("#mensaje-password").html("Las contraseñas deben ser iguales");
  }
  
  }
);

