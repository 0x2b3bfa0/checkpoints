# Automatic checkpoint pushing mechanism for DVC
# See https://github.com/iterative/cml/issues/560#issuecomment-852250748

FLAG="$DVC_ROOT/.dvc/tmp/DVC_CHECKPOINT"

sudo apt install --yes fswatch
fswatch --event Removed "$FLAG" | while read event; do
  dvc exp list --names-only | while read experiment; do
    dvc exp push origin "$experiment"
  done
done &
