#!/usr/bin/env bash

# TODO inject the list of permitted licenses
permissiveLicenses=("MIT" "Apache-2.0" "BSD-2-Clause" "BSD-3-Clause")
data=$(go-licenses csv . 2>/dev/null)
foundProhibited=false
for line in $data; do
  package=$(echo "$line" | cut -d, -f 1)
  license=$(echo "$line" | cut -d, -f 3)
  for i in "${permissiveLicenses[@]}"; do
      if [ "$i" == "$license" ] ; then
          continue 2
      fi
  done
  foundProhibited=true
  echo "package $package is using prohibited license: $license";
done

if [[ $foundProhibited == true ]] ; then
  echo "Found prohibited licenses"
  exit 1
fi
