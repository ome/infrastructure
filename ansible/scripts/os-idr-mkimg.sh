set -e
set -u
#source settings.env

openstack volume list -f json | jq -r ".[] | select(.[\"Display Name\"] | \
      match(\"^$PREFIX.+(database-db|omero-data).+$DATE\")) | \
    [.ID, .[\"Display Name\"]] | join(\",\")" | \
    while IFS='' read -r line; do
        IFS=, read -a arr <<< "$line"
        echo "Creating image ${arr[1]}"
        # TODO: open a bug
        # openstack image create behaves incorrectly in a script when the shell is non-interactive
        # https://github.com/openstack/python-glanceclient/blob/12e92558e50d0aa200d2ca0f98a7110e0adce922/glanceclient/common/utils.py#L376
        #openstack image create --volume "${arr[0]}" "${arr[1]}"
        time cinder upload-to-image "${arr[0]}" "${arr[1]}"
    done

while [ $(openstack image list -f json | jq -c ".[] | select(.Status==\"saving\")" | wc -l) -ne 0 ]; do
    echo -n .
    sleep 1
done
echo Done
