test -f test.data || echo 0 > test.data
echo "Initial state $(cat test.data)"

function checkpoint() {
  touch "$DVC_ROOT/.dvc/tmp/DVC_CHECKPOINT" &&
  while test -f "$_"; do true; done
}

for iteration in {1..120}; do
    echo $(($(cat test.data)+1)) > test.data
    echo "New state $(cat test.data)"
    checkpoint
    sleep 1
done

echo "Finished!"
