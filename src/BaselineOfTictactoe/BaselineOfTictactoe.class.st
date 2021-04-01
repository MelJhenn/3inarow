Class {
	#name : #BaselineOfTictactoe,
	#superclass : #BaselineOf,
	#category : #BaselineOfTictactoe
}

{ #category : #baselines }
BaselineOfTictactoe >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
			"Packages"
			spec
				package: 'Tictactoe'with: [ spec requires: 'Roassal3' ];
				package: 'Tictactoe-Tests'.

			"Groups"
			spec 
				group: 'default' with: #('Tictactoe' 'Tictactoe-Tests') ]
]
