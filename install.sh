export GEMNAME="openskip-skip_embedded"
rm -rf ./pkg && rake package && gem install pkg/${GEMNAME} --no-rdoc --no-ri && gem clean ${GEMNAME}

