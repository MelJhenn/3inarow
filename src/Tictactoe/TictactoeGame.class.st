"
A simple tic tac toe game.

"
Class {
	#name : #TictactoeGame,
	#superclass : #Object,
	#instVars : [
		'matrix',
		'turn'
	],
	#category : #Tictactoe
}

{ #category : #testing }
TictactoeGame >> areThere3InARow [
	^ (self areThere3InARowfor: 'x') or: [self areThere3InARowfor: 'o'] .

]

{ #category : #testing }
TictactoeGame >> areThere3InARowfor: symbol [
	^ self areThere3InARowfor: symbol inAllPositions: 
	{
	{1@1. 2@1. 3@1.}.
	{1@2. 2@2. 3@2.}.
	{1@3. 2@3. 3@3.}.
	{1@1. 1@2. 1@3.}.
	{2@1. 2@2. 2@3.}.
	{3@1. 3@2. 3@3.}.
	{1@1. 2@2. 3@3.}.
	{3@1. 2@2. 1@3.}.
	}
	
]

{ #category : #testing }
TictactoeGame >> areThere3InARowfor: symbol inAllPositions: allPositions [
	^ allPositions
		anySatisfy: [ :positions | self areThere3InARowfor: symbol inPositions: positions ]
]

{ #category : #testing }
TictactoeGame >> areThere3InARowfor: symbol inPositions: positions [
	1 to: 3 do: [ :index| 
		|position value|
		position:= positions at: index.
		value:= matrix at: position y at: position x.
		symbol=value 
			ifFalse: [ ^false ] 
		].
	^true 
]

{ #category : #converting }
TictactoeGame >> asForm [
	<script: 'self new asForm inspect'>
	|canvas formCanvas morph |
	formCanvas := FormCanvas extent: 500@500.
	canvas := self canvas.
	morph := canvas createMorph.
	morph extent: 500@500.
	morph drawOn: formCanvas.
	^formCanvas form.
]

{ #category : #accessing }
TictactoeGame >> at: aPoint place: aSymbol [
	| value res|
	value := matrix at: aPoint y at: aPoint x.
	res:= value isNil.
	value ifNil: [ matrix at: aPoint y at: aPoint x put: aSymbol ].
	^res.
]

{ #category : #accessing }
TictactoeGame >> canvas [
	| canvas |
	canvas:= RSCanvas new.
	self renderOn: canvas.
	canvas when: RSMouseClick do: [ :event |
		self processPosition: event position. 
	   self renderOn: canvas.
		].
	
	^ canvas. 
	
]

{ #category : #rendering }
TictactoeGame >> colorFor: value [
	^ value = 'x'
		ifTrue: [ Color magenta ]
		ifFalse: [ value = 'o'
			ifTrue: [ '#BFFF00'  ] 
			ifFalse: [ Color gray ]
		].
]

{ #category : #rendering }
TictactoeGame >> inform: anArray inCanvas: canvas [
	|bigLabel box smallLabel group|
	box:= RSBox new.
	box 
		position: 45@45;
		color: (Color white alpha: 0.9);
		cornerRadius: 5;
		border: (RSBorder new color: Color black ).
	bigLabel:= RSLabel new.
	bigLabel
		fontName: 'Courier New';
		text: anArray first key;
		fontSize: anArray first value;
		position: 45@35;
		color: (self colorFor: anArray first key).
	smallLabel:= RSLabel new.
	smallLabel 
		text: anArray second  key;
		fontSize: anArray second value;
		position: 45@55.
	group:= RSGroup new.
	group add: bigLabel; add: smallLabel. 
	box width: group width +5.
	box height: group height. 
	canvas add: box.
	canvas add: bigLabel.
	canvas add: smallLabel.
	
	
	
	
]

{ #category : #initialization }
TictactoeGame >> initialize [ 
	matrix:= Array2D rows: 3 columns: 3.
	turn:= true.
]

{ #category : #testing }
TictactoeGame >> isItADraw [
	^matrix allSatisfy: [ :each| each notNil  ]
]

{ #category : #opening }
TictactoeGame >> open [ 
	<script: 'self new open'>
	
	^ self canvas open. 
	
	
]

{ #category : #printing }
TictactoeGame >> printOn: stream [ 
	stream cr.
	(1 to: 3) do: [ :row| 
		(1 to: 3) do: [:column| 
			|value|
			value:= matrix at: row  at: column.
			value ifNil:  [ value:= ' ' ]. 
			stream nextPutAll: value.  
			]	separatedBy: [ stream nextPutAll: '|' ]
		] separatedBy: [
			stream cr. 
			stream nextPutAll: '- - -' .
			stream cr.
			].
	
	stream cr.
]

{ #category : #events }
TictactoeGame >> processPosition: position [
	|symbol hasChanged|
	self areThere3InARow ifTrue: [^ self restart ].
	self isItADraw  ifTrue: [^ self restart ].
	"(self areThere3InARow or: [self isItADraw]) ifTrue: [^ self restart ]."
	symbol:= turn ifTrue: ['x'] ifFalse: [ 'o' ].
	hasChanged:= self putValue: symbol  fromScreen: position. 
	hasChanged ifTrue: [ turn:= turn not. ]
	
	
]

{ #category : #accessing }
TictactoeGame >> putValue: aSymbol fromScreen: aPoint [ 
	|newPosition |
	newPosition := (aPoint/30) asIntegerPoint +1.
	^self at: newPosition  place: aSymbol. 
	
]

{ #category : #rendering }
TictactoeGame >> renderBoardOn: canvas [
	|line1 line2 line3 line4 | 
	line1:= RSLine new.
	line2:= RSLine new.
	line3:= RSLine new.
	line4:= RSLine new.
	line1 startPoint: 30@0 .
	line1 endPoint: 30@90.
	line2 startPoint: 60@0 .
	line2 endPoint: 60@90.
	line3 startPoint: 90@30 .
	line3 endPoint: 0@30.
	line4 startPoint: 0@60 .
	line4 endPoint: 90@60.
	canvas add: line1. 
	canvas add: line2.
	canvas add: line3.
	canvas add: line4.
	
]

{ #category : #rendering }
TictactoeGame >> renderMatrixOn: canvas [
	| label value color |
	1 to: 3 do: [ :row | 
		1 to: 3 do: [ :column | 
			value := matrix at: row at: column.
			value
				ifNotNil: [ color := self colorFor: value.
					label := RSLabel new.
					canvas add: label.
					label text: value.
					label color: color.
					label position: column @ row * 30 - 15.
					label fontSize: 28.
					label fontName: 'Courier New' ] ] ]
]

{ #category : #rendering }
TictactoeGame >> renderOn: canvas [ 
	|symbol|
	canvas shapes do: [:shape| shape remove].
	self renderBoardOn: canvas.
	self renderMatrixOn: canvas.
	symbol:= turn ifTrue: [ 'o' ] ifFalse: [ 'x' ].
	(self areThere3InARowfor: symbol)  ifTrue: [ 
		self inform: { symbol -> 20. 'You are the winner ' -> 8 }  inCanvas: canvas.
	] ifFalse: [
		self isItADraw ifTrue: [ 
			self inform: { 'xo' -> 20. 'DRAW' -> 8 }  inCanvas: canvas. ].
	].
	canvas camera zoomToFit: canvas extent
		rectangle: (Rectangle origin: 0@0 corner: 90@90).
	canvas signalUpdate.  
]

{ #category : #events }
TictactoeGame >> restart [
	matrix:= Array2D rows: 3 columns: 3.
	
	
	
	
]
