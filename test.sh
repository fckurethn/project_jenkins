a=`sudo docker ps | grep fckurethn/my-flask-app | awk '{print $1}'`; [ "$a" != "" ] && sudo docker stop $a || echo 'There is no running container, go further'
