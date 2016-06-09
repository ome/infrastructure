set -e
set -u

if [ $# -ne 2 ]; then
    echo "USAGE: $(basename "$0") image-name file-path"
    echo "Uploads the given image to Openstack as a new image using glance"
    exit 1
fi
NAME=$1
FILE=$2
# Upload
exec glance image-create --name "$NAME" --disk-format=qcow2 --container-format=bare --file="$FILE" --progress
