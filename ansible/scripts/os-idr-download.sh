set -e
set -u
#source settings.env

openstack image list -f json | jq -r ".[] | select(.Name | \
      match(\"^$PREFIX.+(database-db|omero-data).+$DATE\")) | \
    [.ID, .Name] | join(\",\")" | \
    while IFS='' read -r line; do
        IFS=, read -a arr <<< "$line"
        echo "Downloading image ${arr[1]}"
        time openstack image save --file "${arr[1]}.raw" "${arr[0]}"
    done
