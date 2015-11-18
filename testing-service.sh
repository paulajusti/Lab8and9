COL_BLUE="\x1b[34;01m"
COL_RESET="\x1b[39;49;00m"



echo -e $COL_BLUE"1. Checking connection to webserver on virtual machine endpoint: "$COL_RESET
echo ""
wget -q --spider http://ec2-52-30-48-90.eu-west-1.compute.amazonaws.com:8080/containers
if [ $? -eq 0 ]; then
    echo "Server is Running"


    ##########################################################

    echo -e $COL_BLUE"2. Lists all containers: "$COL_RESET

    read
    echo ""

    curl -s -X GET -H 'Accept: application/json' http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"3. List running containers: "$COL_RESET
    read
    curl -s -X GET -H 'Accept: application/json' http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers?state=running | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"4. Inspect a container (please, type the id of it): "$COL_RESET
    read id_container
    curl -s -X GET -H 'Accept: application/json' http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers/$id_container | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"5. Delete a container (please, type the id of it): "$COL_RESET
    read id_container
    curl -s -X DELETE -H 'Accept: application/json'  http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers/$id_container | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"6. Delete all containers: "$COL_RESET
    read
    curl -s -X DELETE -H 'Accept: application/json'  http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"7. Create container from image(please, type the name or id of it): "$COL_RESET
    read id_image
    curl -s -X POST -H 'Content-Type: application/json'  http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers -d '{"image": "'$id_image'"}' | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"8. Restart a container (please, type the name or id of it): "$COL_RESET
    read container_id
    curl -s -X PATCH -H 'Content-Type: application/json'  http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers/$container_id -d '{"state": "running"}' | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"9. Stop a container (please, type the name or id of it): "$COL_RESET
    read container_id
    curl -s -X PATCH -H 'Content-Type: application/json'  http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers/$container_id -d '{"state": "stopped"}' | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"10. Show logs from a container (please, type the id of it): "$COL_RESET
    read container_id
    curl -s -X GET -H 'Accept: application/json'  http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers/$container_id/logs | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"Exclusion of all containers (necessary for next exercises"$COL_RESET
    curl -s -X DELETE -H 'Accept: application/json'  http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/containers | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"11. List all images: "$COL_RESET
    read
    curl -s -X GET -H 'Accept: application/json'  http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/images | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"12. Delete an image (please, type the id of it): "$COL_RESET
    read image_id
    curl -s -X DELETE -H 'Accept: application/json' http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/images/$image_id | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"13. Delete all images: "$COL_RESET
    read image_id
    curl -s -X DELETE -H 'Accept: application/json' http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/images | python -mjson.tool

    ##########################################################
   
    echo ""
    echo "Creation of an image for next exercise"
    curl -H 'Accept: application/json' -F file=@./TestApp/SimpleApp/Dockerfile http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/images

    echo -e $COL_BLUE"14. Tag an image: "$COL_RESET
    echo -e $COL_BLUE" Type the id of it: "$COL_RESET
    read image_id
    echo -e $COL_BLUE"Type the tag you want to put: "$COL_RESET
    read image_tag

    curl -s -X PATCH -H 'Content-Type: application/json' http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/images/$image_id -d '{"tag": "'$image_id':'$image_tag'"}' | python -mjson.tool

    ##########################################################

    echo ""

    echo -e $COL_BLUE"15. Creating a image from a local file (./TestApp/SimpleApp/Dockerfile): "$COL_RESET
    read
    curl -H 'Accept: application/json' -F file=@./TestApp/SimpleApp/Dockerfile http://ec2-52-30-39-38.eu-west-1.compute.amazonaws.com:8080/images

    ##########################################################
else
    echo "Cointainer is Offline"
fi

echo ""
echo -e $COL_BLUE"================================================================"$COL_RESET
