MyChat con JQuery, Ajax y Sinatra ![travis](https://travis-ci.org/alu0100700435/my-chat.svg)
=============
Sistemas y Tecnologías web
---------------------------


Objetivo
-----

Crear un chat con registro de usuarios donde no puedan existir dos usuarios con el mismo nombre y dentro del cual deberán aparecer tres contenedores:

1. Contenedor con los nombres de los usuarios.
2. Contenedor con los mensajes.
3. Un input para enviar los mensajes.


Funcionamiento
-----

Hay dos formas posibles de ver el funcionamiento de la aplicación, una mediante la web, gracias a Heroku, y otra desde local.

1. Visualización en Heroku
    
    Para poder ver la aplicación en dicha plataforma, haz click [aquí].
    Una vez ahí, crea tu propia cuenta de usuario y entrarás al chat, donde podrás ver a los usuarios del mismo y además tendrás la posibilidad de enviar mensajes.
    
2. Visualización en local

    Primero se ha de clonar el repositorio de github [mytinyurl], de la siguiente forma: 
    
    ```sh
    user@ubuntu-hp:~$ git clone git@github.com:alu0100700435/my-chat
    ```
    Una vez clonado el repositorio, ejecuta bundler:
    
    ```sh
    user@ubuntu-hp:~/my-chat$ bundle install
    ```
    
    Una vez hecho todo lo anterior, procede a ejecutar *rake server*, y por defecto se empezará a ejecutar.
    
    Una vez en ejecución, abre el navegador y escribe en la barra de direcciones *localhost:9292* y accederás a la web de la aplicación:
    
    ![ejemplo navegador](https://raw.githubusercontent.com/alu0100700435/my-chat/master/public/img/ejemplo.png)

    
[aquí]:http://my-own-chat.herokuapp.com
[mytinyurl]:https://github.com/alu0100700435/my-chat


