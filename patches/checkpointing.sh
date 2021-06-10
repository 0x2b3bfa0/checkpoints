# Automatic checkpoint pushing mechanism for DVC
# See https://github.com/iterative/cml/issues/560#issuecomment-852250748

sudo apt install --yes inotify-tools

mkdir --parents "$DVC_ROOT/.dvc/tmp"

inotifywait --monitor --event=delete "$_" |
grep --line-buffered DVC_CHECKPOINT |
while read event; do
  dvc exp push --verbose origin "$EXPERIMENT"
done &

dvc exp pull origin "$EXPERIMENT"
dvc exp apply "$EXPERIMENT"
dvc exp run --name "$EXPERIMENT"
