"
Start a new server on localhost:1701

"
Class {
	#name : #TictactoeServer,
	#superclass : #Object,
	#instVars : [
		'games'
	],
	#category : #Tictactoe
}

{ #category : #accessing }
TictactoeServer >> games [
	^games.
]

{ #category : #accessing }
TictactoeServer >> start [ 
	<script: 'self new start. 
	 WebBrowser openOn: ''http://localhost:1701''
	'>
	games:= OrderedCollection new.
	(ZnServer startDefaultOn: 1701) 
		delegate: (TictactoeDelegate new
			directory: 'pharo-local\iceberg\TicTaeToe-Game\server docs\' asFileReference; 
			games: games;
			yourself).	
			
	
]

{ #category : #accessing }
TictactoeServer >> stop [
	<script: 'self new stop'>
	ZnServer stopDefault
	
]
