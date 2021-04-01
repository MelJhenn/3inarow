Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'Tictactoe-Tests'
}

{ #category : #tests }
GameTest >> test3InARow [
	| game |
	game:= TictactoeGame new.
	self assert: game asString equals: '
 | | 
- - -
 | | 
- - -
 | | 
'.
	game at: 1@2 place: 'x'.
	game at: 2@2 place: 'x'.
	game at: 2@3 place: 'x'.
	self assert: game asString equals: '
 | | 
- - -
x|x| 
- - -
 |x| 
'.
	self deny: game areThere3InARow.
	game:= TictactoeGame new.
	game at: 1@1place: 'x'.
	game at: 2@2 place: 'x'.
	game at: 3@3 place: 'x'.
	self assert: game asString equals: '
x| | 
- - -
 |x| 
- - -
 | |x
'.
	self assert: game areThere3InARow.
	game:= TictactoeGame new.
	game at: 1@2place: 'x'.
	game at: 2@2 place: 'x'.
	game at: 3@2 place: 'x'.
	self assert: game asString equals: '
 | | 
- - -
x|x|x
- - -
 | | 
'.
	self assert: game areThere3InARow.
	
	game:= TictactoeGame new.
	game at: 1@2place: 'o'.
	game at: 2@2 place: 'o'.
	game at: 3@2 place: 'o'.
	self assert: game asString equals: '
 | | 
- - -
o|o|o
- - -
 | | 
'.
	self assert: game areThere3InARow.

	
]

{ #category : #tests }
GameTest >> testBasic [
	| game window |
	game:= TictactoeGame new.
	window:= game open.
	self assert: window isDisplayed.
 	window delete.
]

{ #category : #tests }
GameTest >> testBasic2 [
	| game |
	game:= TictactoeGame new.
	self assert: game asString equals: '
 | | 
- - -
 | | 
- - -
 | | 
'.
	game at: 2@2 place: 'x'.
	self assert: game asString equals: '
 | | 
- - -
 |x| 
- - -
 | | 
'.
]

{ #category : #tests }
GameTest >> testCanvas [
	|game image|
	game:= TictactoeGame  new.
	image:= game asForm.
	self assert: image class equals: Form.
]

{ #category : #tests }
GameTest >> testDoubleClick [
	| game |
	game:= TictactoeGame new.
	self assert: game asString equals: '
 | | 
- - -
 | | 
- - -
 | | 
'.
	game processPosition: 10@10.
	self assert: game asString equals: '
x| | 
- - -
 | | 
- - -
 | | 
'.
	game processPosition: 45@40.
	self assert: game asString equals: '
x| | 
- - -
 |o| 
- - -
 | | 
'.
	game processPosition: 47@46.
	self assert: game asString equals: '
x| | 
- - -
 |o| 
- - -
 | | 
'.
	game processPosition: 35@10.
	self assert: game asString equals: '
x|x| 
- - -
 |o| 
- - -
 | | 
'.
]

{ #category : #tests }
GameTest >> testDraw [ 
	| game |
	game:= TictactoeGame new.
	game at: 1@2place: 'x'.
	game at: 2@2 place: 'x'.
	self assert: game asString equals: '
 | | 
- - -
x|x| 
- - -
 | | 
'.
	self deny: game isItADraw.
	game:= TictactoeGame new.
	game at: 1@2place: 'x'.
	game at: 2@2 place: 'x'.
	game at: 3@2 place: 'o'.
	game at: 1@1place: 'o'.
	game at: 2@1 place: 'x'.
	game at: 3@1 place: 'o'.
	game at: 1@3place: 'x'.
	game at: 2@3 place: 'x'.
	game at: 3@3 place: 'o'.
	self assert: game asString equals: '
o|x|o
- - -
x|x|o
- - -
x|x|o
'.
	self assert: game isItADraw.

]

{ #category : #tests }
GameTest >> testOnly1InACell [
	|game|
	game:= TictactoeGame new.
	game at: 1@2place: 'o'.
	game at: 2@2 place: 'o'.
	game at: 3@2 place: 'o'.
	self assert: game asString equals: '
 | | 
- - -
o|o|o
- - -
 | | 
'.
	self assert: game areThere3InARow.
	game at: 2@2 place: 'x'.
	self assert: game asString equals: '
 | | 
- - -
o|o|o
- - -
 | | 
'.
	
]

{ #category : #tests }
GameTest >> testPutValueFromScreen [
	|game|
	game:= TictactoeGame new.
	game putValue: 'x' fromScreen: 75.4@15.099999999999998. 
	self assert: game asString equals: '
 | |x
- - -
 | | 
- - -
 | | 
'.
]
