FROM jupyter/scipy-notebook
# cambiamos al usuario root es importante ya que como sabras son necesarios los permisos
USER root
# se debe habilitar deb-src /deb-src para que se pueda instalar las dependencias este comando elimina '#' lo que las habilita
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
# se incluye el -y ya que segun recuerdo que si no se incluye el -y no se puede instalar las dependencias
# ya que al construir la imagen no permite que se acepte o rechace la instalacion de las dependencias
RUN apt-get update -y
# lo mismo, solo tengo el detalle que debes salir de el usuario root para ejecutar la instalacion
# con el comando pip install. Para eso el exit del final.
# pero no salio del usuario, asi que eso faltaria solventarlo aun asi funciona
RUN apt-get install -y libxml2-dev libxslt-dev python-dev && \
    apt-get -y build-dep python3-lxml && exit

RUN pip install pandas lxml numpy matplotlib plotly

ENTRYPOINT ["jupyter", "notebook", "--ip", "0.0.0.0", "--no-browser", "--allow-root"]
# nuevo cambio
