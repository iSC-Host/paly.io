cat tmp/pids/unicorn.pid | xargs kill -QUIT
rm tmp/pids/unicorn.pid
