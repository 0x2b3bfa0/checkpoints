# Automatic checkpoint pushing mechanism for DVC
# See https://github.com/iterative/cml/issues/560#issuecomment-852250748

FLAG="$DVC_ROOT/.dvc/tmp/DVC_CHECKPOINT"

while true; do sleep 10
  dvc exp list --names-only | while read experiment; do
    dvc exp push origin "$experiment"
  done
done &
