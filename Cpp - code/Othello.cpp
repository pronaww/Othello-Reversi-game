#include <stdio.h>
int arr[8][8];
int Player1 =2;
int Player2 =2;
// int Player2_total =2;
// int Player1_total =2;

bool valid(int i, int j, int turn){
    if (arr [i][j] != 0){
        return false;
    }
    else{
        int total = 0;
        int p,q;
        //Check up
        if(i>1){
            p=i;
            if(arr[i-1][j]!=turn && arr[i-1][j]!= 0){
                while (arr[p-1][j] != turn &&  arr[p-1][j]!= 0 && p > 1){
                    p = p-1;
                }
                p--;
                if (arr[p][j] == turn){
                    total = total + i - p - 1;
                    for (int z = p+1; z< i; z++){
                        arr[z][j]=turn;
                    }
                }
               
            }
            //printf("u %d\n", total );
        }
        //Check down
        if (i < 6){
            p=i;
            if(arr[i+1][j]!=turn && arr[i+1][j]!= 0){
                while (arr[p+1][j] != turn &&  arr[p+1][j]!= 0 && p < 6){
                    p = p+1;
                }
                p=p+1;
                //printf("%d\n", p);
                    if (arr[p][j] == turn){
                        total = total + p - i - 1;
                        for (int z = i+1; z< p; z++){
                            arr[z][j]=turn;
                        }
                    }
               
            }  
                      //printf("d %d\n", total );

        }
        //check left
        if(j>1){
            q=j;
            if(arr[i][j-1]!=turn && arr[i][j-1]!= 0){
                while (arr[i][q-1] != turn &&  arr[i][q-1]!= 0 && q > 1){
                    q = q-1;
                }
                q--;
                if (arr[i][q] == turn){
                    total = total + j - q - 1;
                    for (int z = q+1; z<j; z++){
                        arr[i][z]=turn;
                    }
                }
               
            }
            //printf("l %d\n", total );
        }
        //check right
        if (j < 6){
            q=j;
            if(arr[i][j+1]!=turn && arr[i][j+1]!= 0){
                while (arr[i][q+1] != turn &&  arr[i][q+1]!= 0 && q < 6){
                    q = q+1;
                }
                q++;
                if (arr[i][q] == turn){
                    total = total + q - j - 1;
                    for (int z = j+1; z< q; z++){
                        arr[i][z]=turn;
                    }
                }
               
            }
            //printf("r %d\n", total );

        }
        //check up, left
        if (i>1 && j>1){
            p=i;
            q=j;
            if(arr[i-1][j-1]!=turn && arr[i-1][j-1]!= 0){
                while (arr[p-1][q-1] != turn &&  arr[p-1][q-1]!= 0 && q > 1 && p > 1){
                    q = q-1;
                    p= p-1;
                }
                q--;
                p--;
                if (arr[p][q] == turn){
                    total = total + j - q - 1;
                    for (int z = 1; z< j-q; z++){
                        arr[p+z][q+z]=turn;
                    }
                }
               
            }
            //printf("u l %d\n", total );
           
        }
        //check down right
        if (i<6 && j<6){
            p=i;
            q=j;
            if(arr[i+1][j+1]!=turn && arr[i+1][j+1]!= 0){
                while (arr[p+1][q+1] != turn &&  arr[p+1][q+1]!= 0 && q < 6 && p< 6){
                    q = q+1;
                    p= p+1;
                }
                q++;
                p++;
                if (arr[p][q] == turn){
                    total = total + q - j - 1;
                    for (int z = 1; z< q-j; z++){
                        arr[p-z][q-z]=turn;
                    }
                }
               
            }
            //printf("r d %d\n", total );
           
        }
        //check up right
        if (i>1 && j<6){
            p=i;
            q=j;
            if(arr[i-1][j+1]!=turn && arr[i-1][j+1]!= 0){
                while (arr[p-1][q+1] != turn &&  arr[p-1][q+1]!= 0 && q < 6 && p > 1){
                    q = q+1;
                    p= p-1;
                }
                q++;
                p--;
                if (arr[p][q] == turn){
                    total = total + q - j - 1;
                    for (int z = 1; z< q-j; z++){
                        arr[p+z][q-z]=turn;
                    }
                }
               
            }
            //printf("u r %d\n", total );
           
        }
        //check left down
        if (i<6  && j>1){
            p=i;
            q=j;    
            if(arr[i+1][j-1]!=turn && arr[i+1][j-1]!= 0){
                while (arr[p+1][q-1] != turn &&  arr[p+1][q-1]!= 0 && p < 6 && q > 1){
                    q = q-1;
                    p= p+1;
                }
                q--;
                p++;
                if (arr[p][q] == turn){
                    total = total + j - q - 1;
                    for (int z = 1; z< j-q; z++){
                        arr[p-z][q+z]=turn;
                    }
                }
               
            }
            //printf("l d %d\n", total );
           
        }
        if (total > 0){
            if(turn ==1){
                Player1+=total+1;
                Player2-=total;
            }
            else{
                Player2+=total+1;
                Player1-=total;
            }
            arr[i][j] = turn;
            return true;
        }
        else return false;
       
    }
}
void reset(){
    for (int r=0; r < 8; r++){
        for (int s=0; s<8; s++){
            arr[r][s] =0;
        }
    }
    arr[3][4] = 1;
    arr[4][3] = 1;
    arr[3][3] = 2;
    arr[4][4] = 2;
}

void board(){
    printf(" ");
    for(int i=0;i<8;i++){
        printf(" %d", i);
    }
    printf("\n");
    for(int i=0;i<8;i++){
        printf("%d ", i);
        for(int j=0;j<8;j++){
            printf("%d ",arr[i][j]);
        }
        printf("\n");
    }
}
int main()
{
    reset();
    int turn = 1;
    int pass = 0;

    board();
    bool possible;
    while(pass!=2&&(Player1+Player2!=64)){
        if(turn == 1){
            printf("Player1\n");
        }
        else{
            printf("Player2\n");
        }
        int i,j;
        scanf("%d%d",&i,&j);
        possible = valid(i,j,turn);
        if(possible==true){
            pass=0;
            if(turn ==1){
                turn=2;
            }
            else{
                turn =1;
            }
        }
        else
            pass++;
        board();
        printf("Player2: %d Player1: %d\n", Player2, Player1);
        printf("pass: %d\n", pass);
    }
    printf("%s\n", "The game is over!");
        if(pass==2){
            if(turn ==1){
                printf("Player2 wins\n");
            }
            else{
                printf("Player1 wins\n");
                            }
        }
        else{
            if(Player1>Player2){
                printf("%s\n", "Player1 wins");
            }
            else{
                printf("%s\n", "Player2 wins");
            }
        }
      
    return 0;
   
}
