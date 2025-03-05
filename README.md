## taylor series  - estimate function values from differential equations

run `go.sh` and it will tell you how to use it.

### how it works?

I use python to take derivatives of the function you give, and write them to the C header file and the C source file (derivatives.h & derivatives.c) as functions.   
Then, I compile those files, link them with the actual Taylor Polynomial implementation (pre-compiled, it doesn't change) (main.c), and run it and it spits a number.'


![chart](https://github.com/user-attachments/assets/7860fd06-11cc-441d-a8e0-52e456188964)

The chart shows accuracy. The x axis the the amount of degrees. The y axis is the estimated value of the function. The plateau is the accurate approximation (but it swings off to lands far far away when the amount of degrees gets too big.)


#### other stuff

`go.sh` is what you run to use it. It does all the glueing.  
data.txt is for chart visualization.  
graph.sh is the script for gathering data and putting it in data.txt  
Don't use my executables - compile your own using `go.sh`.
