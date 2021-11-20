function next() {
  SEQ=".seq"
  if [[ ! -s $SEQ ]]; then
    echo 1 > $SEQ
  fi
  value=$(cat $SEQ)
  echo $value
  value=`expr $(cat $SEQ) + 1`
  echo ${value} > $SEQ
  
}

next
