collectionList = [
	'before'
	'before-no-spinner'
	'wait-on'
	'wait-on-no-tick'
	'not-here'
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
				, 1000 * count
		
				future.wait()
