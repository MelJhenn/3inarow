"
Handle request, get information, coordinates and return an image.
"
Class {
	#name : #TictactoeDelegate,
	#superclass : #ZnStaticFileServerDelegate,
	#instVars : [
		'games',
		'sessionId'
	],
	#category : #Tictactoe
}

{ #category : #public }
TictactoeDelegate >> convertToText: image [ 
	|stream base64|
	stream := WriteStream on: ByteArray new.
	PNGReadWriter putForm: image onStream: stream.
	base64 := Base64MimeConverter mimeEncode: stream contents readStream multiLine: false.
	^base64 contents.

	
]

{ #category : #accessing }
TictactoeDelegate >> currentGame [
	^ sessionId ifNil: [  
		|game|	
		game:= TictactoeGame new.
		games add: game. 
		sessionId := games size.
		game 
	] ifNotNil: [
		games at: sessionId.	
	]. 
	


	
]

{ #category : #accessing }
TictactoeDelegate >> games [
	^ games
]

{ #category : #accessing }
TictactoeDelegate >> games: aCollection [
	games := aCollection
]

{ #category : #public }
TictactoeDelegate >> handleRequest: request [
	^request method = #POST
		ifTrue:[
			self processCoordinates: request
			]
		ifFalse: [ 
			super handleRequest: request
			 ]
]

{ #category : #public }
TictactoeDelegate >> positionFrom: request [
	|fields x y|
	request entity ifNil: [^nil].
	fields:= request entity fields.
	sessionId := fields at: 'id'.
	sessionId := sessionId 
		ifEmpty: [ nil] 
		ifNotEmpty: [sessionId asNumber].
	x:= fields at: 'x' ifAbsent: [^nil].
	y:= fields at: 'y'.
	x:= x asNumber.
	y:= y asNumber.
	^x@y *90/500.


]

{ #category : #public }
TictactoeDelegate >> processCoordinates: request [
	|image base64 position entity|
	position:= self positionFrom: request.
	position ifNotNil: [ 
		self currentGame processPosition: position.
		 ].
	image:= self currentGame asForm . 
	base64:= self convertToText: image.
	entity:= ZnEntity text: base64, ',', sessionId asString.
	sessionId := nil.
	^ ZnResponse ok: entity .
	
	
]
