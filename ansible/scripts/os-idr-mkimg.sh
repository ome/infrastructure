set -e
set -u
TODAY=$(date +%Y%m%d)
DATE=${DATE:-$TODAY}
export DATE
for x in database-db omero-data;
do
    X=$(nova image-list | grep $DATE | grep demo2-$x)
    ID=$(echo $X | cut -f2 -d\| | xargs)
    NAME="$(echo $X | cut -f5 -d\| | xargs)"
    time cinder upload-to-image $NAME $NAME
done
