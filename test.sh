FLAG="$DVC_ROOT/.dvc/tmp/DVC_CHECKPOINT"

function checkpoint() {
  [[ -z "$DVC_ROOT" ]] && return
  touch "$FLAG" && while test -f "$FLAG"; do true; done
}

function push() {
  # DVC requirement: dvc exp push origin --all
  # DVD requirement: dulwich authentication is failing
  dvc exp list --names-only | while read experiment; do
    dvc exp push origin "$experiment"
  done
}

function monitor() {
  fswatch --event Removed "$FLAG" | while read event; do push; done
}

monitor &

test -f test.data || echo 0 > test.data
echo "Initial state $(cat test.data)"

for iteration in {1..60}; do
    echo $(($(cat test.data)+1)) > test.data
    echo "New state $(cat test.data)"
    checkpoint
    sleep 1
done

echo "Finished!"
