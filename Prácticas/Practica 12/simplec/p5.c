
# example of illegal manipulation of counter in for loop

for (i = 1; i <= 5; i=i+1) {
  i = 3;
  print i;
};

