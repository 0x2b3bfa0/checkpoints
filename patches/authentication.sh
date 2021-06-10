# Dulwich headless authentication patch for GitHub Actions
# See https://github.com/iterative/cml/issues/560#issuecomment-852250748

credentials="$(
  git config --local http.https://github.com/.extraheader |
  awk '{print $3}' |
  base64 --decode
)"

address="$(
  git config --local remote.origin.url |
  sed 's/^https:\/\///'
)"

git config --local remote.origin.url "https://$credentials@$address"
git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"
