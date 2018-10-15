#define N 3

int flags[N] = -1;
int turn[N];

int major_pid = 0;
bool print[N] = false;

active [N] proctype P1() {
  int this_pid = major_pid+1;

  int count;


  do
  //Unlocking
  ::  for(count : 0 .. N-1) {
        flags[this_pid] = count;
        turn[count] = 0;

        bool result = false;
        int k;
        do
        :: result == true ->
          break;
        :: else -> {
            int valid = 0;

            for (k : 0 .. N-1) {
              if
                :: k == this_pid
                :: else ->
                  if
                  :: flags[k] <= count -> valid++;
                  fi;
              fi;
            };

            // If all bar this process is covered
            if
            :: valid == N - 1 -> result = true;
            fi;
          }
      od;
    }

    print[this_pid] = true;

    printf("process %d locking", this_pid);
    printf("\n\n%d\n\n", this_pid);
    printf("process unlocking", this_pid);
    print[this_pid] = false;
    //Locking
    flags[this_pid] = -1;
  od;
}

int neverVarI = 0;
int neverVarJ = 0;
bool toContinue = true;

never {
  do
  :: toContinue ->
      for (neverVarI : 0 .. N) {
        for(neverVarJ : neverVarI + 1 .. N) {
          if
            :: ((neverVarI != neverVarJ) && (print[neverVarI] == true) && (print[neverVarJ] == true))
            -> toContinue = false;
            :: else -> skip;
          fi;
        }
      }
      neverVarI = 0;
      neverVarJ = 0;
  :: !toContinue -> break;
  od;
}
