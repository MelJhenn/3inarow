# 3inarow
### Stable version
If you wish to install TicTacToe-Game in Pharo 8, go ahead and execute the following code in a Playground:

```Smalltalk
Metacello new
    baseline: 'Tictactoe';
    repository: 'github://MelJhenn/3inarow';
    load.
```
To start the server execute this:
```Smalltalk
TictactoeServer new start. 
WebBrowser openOn: 'http://localhost:1701'.
```
