export DIRS="tasks templates tests vars meta handlers defaults files molecule other"
for DIR in ${DIRS}; do
  find ${DIR} -name '*.yml'|xargs yamlfmt -w; 
done
