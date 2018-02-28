Class {
	#name : #ClapMeaningsTest,
	#superclass : #TestCase,
	#category : #'Clap-Tests-Integration'
}

{ #category : #tests }
ClapMeaningsTest >> match: aParameter on: arguments [
	^ aParameter matchOn: (ClapContext on: arguments)
]

{ #category : #tests }
ClapMeaningsTest >> testArgFlagBasicMeaning [
	| flag match |
	flag := (ClapFlag withName: 'foo')
		addPositional: (ClapPositional withName: 'bar').

	match := self match: flag on: #('--foo' 'whatever').
	self assert: match value.

	match := self match: flag on: #().
	self deny: match value.

]

{ #category : #tests }
ClapMeaningsTest >> testArgFlagScalarMeaning [
	| flag match |
	flag := (ClapFlag withName: 'foo')
		addPositional: ((ClapPositional withName: 'bar') defaultMeaning: ['oops']);
		meaningScalar.

	match := self match: flag on: #('--foo' 'whatever').
	self assert: match value equals: 'whatever'.

	match := self match: flag on: #('--foo').
	self assert: match value equals: 'oops'.

	match := self match: flag on: #().
	self assert: match value equals: 'oops'.

]

{ #category : #tests }
ClapMeaningsTest >> testSimpleFlagBasicMeaning [
	| flag match |
	flag := ClapFlag withName: 'foo'.

	match := self match: flag on: #('--foo').
	self assert: match value.

	match := self match: flag on: #().
	self deny: match value.

]