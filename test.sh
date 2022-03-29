a=`docker ps | grep fckurethn/my-flask-app | awk '{print $1}'`; [ "$a" != "" ] && docker stop $a || echo 'There is no running container, go further'
