"
A TictactoeServerTest is a test class for testing the behavior of TictactoeServer
"
Class {
	#name : #TictactoeServerTest,
	#superclass : #TestCase,
	#category : #'Tictactoe-Tests'
}

{ #category : #tests }
TictactoeServerTest >> testImage [ 
	|server  client |
	server:= TictactoeServer new.
	server start.
	client := ZnClient new.
	client 
		url: 'http://localhost:1701';
		addPath: 'coordinates';
		post.
	self assert: client isSuccess.
	server stop.
	
]

{ #category : #tests }
TictactoeServerTest >> testImageWithPosition [
	| server client |
	server := TictactoeServer new.
	server start.
	self assert: server games isEmpty.
	client := ZnClient new.
	client
		url: 'http://localhost:1701';
		addPath: 'coordinates';
		formAdd: 'x' -> '5';
		formAdd: 'y' -> '8';
		formAdd: 'id' -> '';
		post.
	self assert: client isSuccess.
	self
		assert: server games first asString equals: '
x| | 
- - -
 | | 
- - -
 | | 
'.
	client := ZnClient new.
	client
		url: 'http://localhost:1701';
		addPath: 'coordinates';
		formAdd: 'x' -> '250';
		formAdd: 'y' -> '240';
		formAdd: 'id' -> '1';
		post.
	self assert: client isSuccess.
	self assert: server games first asString equals: '
x| | 
- - -
 |o| 
- - -
 | | 
'.
	server stop
]

{ #category : #tests }
TictactoeServerTest >> testServer [ 
	|server  client |
	server:= TictactoeServer new.
	server start.
	client := ZnClient new.
	client get: 'http://localhost:1701'.
	self assert: client isSuccess.
	server stop.
	
]

{ #category : #tests }
TictactoeServerTest >> testSessions [
	|server  client |
	server:= TictactoeServer new.
	server start.
	self assert: server games isEmpty. 
	client := ZnClient new.
	client 
		url: 'http://localhost:1701';
		addPath: 'coordinates';
		post.
	self assert: client isSuccess.
	self assert: server games isNotEmpty.
	server stop.
	
]
