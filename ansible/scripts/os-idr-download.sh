set -e
set -u
export DATE
for x in database-db omero-data;
do
    X=$(nova image-list | grep $DATE | grep demo2-$x)
    ID=$(echo $X | cut -f2 -d\| | xargs)
    FILE="$(echo $X | cut -f3 -d\| | xargs)".raw
    time glance image-download --file $FILE $ID
done
