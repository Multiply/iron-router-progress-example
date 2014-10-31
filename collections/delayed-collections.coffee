collectionList = [
	'wait'
	'waiton'
	'no-spinner'
	'no-tick'
	'not-here'
	'delay'
]

@DelayedCollections = []

if Meteor.isServer
	Future = Npm.require 'fibers/future'

for item in collectionList
	item = "#{item}-collection"
	for count in [1, 2]
		@DelayedCollections["#{item}#{count}"] = new Meteor.Collection "#{item}#{count}"

		if Meteor.isServer
			Meteor.publish "#{item}#{count}", ->
				future = new Future
		
				Meteor.setTimeout ->
					future.return DelayedCollections["#{item}#{count}"].find()
				, 1000 * count + 3
		
				future.wait()
