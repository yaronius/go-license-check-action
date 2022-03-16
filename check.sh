#!/usr/bin/env bash

echo "allowed_licenses: ${ALLOWED_LICENSES}"
echo "ignored_authors: ${IGNORED_AUTHORS}"

permissiveLicenses=(${ALLOWED_LICENSES//,/ })
ignoredAuthors=()
if [ -n "$IGNORED_AUTHORS" ]; then
  ignoredAuthors=(${IGNORED_AUTHORS//,/ })
fi
data=$(go-licenses csv . 2>/dev/null)
foundProhibited=false
for line in $data; do
  package=$(echo "$line" | cut -d, -f 1)
  packageAuthor=$(echo "$package" | cut -d/ -f 2)
  for i in "${ignoredAuthors[@]}"; do
      if [ "$i" == "$packageAuthor" ] ; then
          continue 2
      fi
  done
  license=$(echo "$line" | cut -d, -f 3)
  for j in "${permissiveLicenses[@]}"; do
      if [ "$j" == "$license" ] ; then
          continue 2
      fi
  done
  foundProhibited=true
  echo "package $package is using prohibited license: $license"
done

if [[ $foundProhibited == true ]] ; then
  echo "Found prohibited licenses"
  exit 1
fi
