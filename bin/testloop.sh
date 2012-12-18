while :; do
  npm stop
  npm start
  sleep 2
  echo "Press enter to start tests"
  read input

  npm test

done