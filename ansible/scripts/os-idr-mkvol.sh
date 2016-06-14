set -e
set -u
#source settings.env

openstack snapshot list -f json | jq -r ".[] | select(.Name | \
      match(\"^$PREFIX.+(database-db|omero-data).+$DATE\")) | \
    [.ID, .Name, .Size|tostring] | join(\",\")" | \
    while IFS='' read -r line; do
        IFS=, read -a arr <<< "$line"
        description="Created $TODAY from Snapshot ${arr[0]} ${arr[1]}"
        echo "Creating volume ${arr[1]}"
        time openstack volume create --snapshot "${arr[0]}" "${arr[1]}" \
            --size "${arr[2]}" --description "$description"
    done

while [ $(openstack volume list -f json | jq -c ".[] | select(.Status==\"creating\")" | wc -l) -ne 0 ]; do
    echo -n .
    sleep 1
done
echo Done
