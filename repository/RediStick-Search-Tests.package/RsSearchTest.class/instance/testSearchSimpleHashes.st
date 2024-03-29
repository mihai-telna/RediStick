tests
testSearchSimpleHashes
	| indexName ep rs content |
	indexName := 'test-index1'.
	ep := stick endpoint.
	self assert: ep ftListIndexes size equals: 0.
	ep ftCreate: indexName schemaUsing: [:sc | 
		sc textFieldNamed: 'name'.
		sc numericFieldNamed: 'id'.
	] optionsUsing: [:opts | opts ].
	self assert: ep ftListIndexes size equals: 1.
	
	self populateDateOn: ep.
	
	rs := ep ftSearch: indexName query: 'Smalltalk'.
	self assert: rs size equals: 4.
	
	rs := ep ftSearch: indexName query: 'Pharo'.
	self assert: rs size equals: 1.
	content := (rs results at: 1) content.
	self assert: (content at: 'id') equals: '1'.
	self assert: (content at: 'name') equals: 'Pharo Smalltalk'.
	
	rs := ep ftSearch: indexName query: 'Visual*'.
	self assert: rs size equals: 2.
	rs := ep ftSearch: indexName query: '"VisualWorks Smalltalk"'.
	self assert: rs size equals: 1.
	
	ep ftDropIndexWithDocuments: indexName.
	self assert: ep ftListIndexes size equals: 0.