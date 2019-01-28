JENKINS_CONTAINER="$(docker ps | grep fpm | awk '{print $1; exit}')"

docker stop "${JENKINS_CONTAINER}"

docker rm "${JENKINS_CONTAINER}"

docker build . -t roelof:jenkins

docker run -v data:/var/jenkins_home -p 8000:8080 -itd roelof:jenkins
