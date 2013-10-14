@DelayedCollections =
	one   : new Meteor.Collection 'delayed-collection1'
	two   : new Meteor.Collection 'delayed-collection2'
	three : new Meteor.Collection 'delayed-collection3'
	four  : new Meteor.Collection 'delayed-collection4'

if Meteor.isServer
	Future = Npm.require 'fibers/future'

	Meteor.publish 'delayed-collection1', ->
		future = new Future

		Meteor.setTimeout ->
			future.return DelayedCollections.one.find()
		, 1000

		future.wait()

	Meteor.publish 'delayed-collection2', ->
		future = new Future

		Meteor.setTimeout ->
			future.return DelayedCollections.two.find()
		, 2000

		future.wait()


	Meteor.publish 'delayed-collection3', ->
		future = new Future

		Meteor.setTimeout ->
			future.return DelayedCollections.three.find()
		, 3000

		future.wait()

	Meteor.publish 'delayed-collection4', ->
		future = new Future

		Meteor.setTimeout ->
			future.return DelayedCollections.four.find()
		, 4000

		future.wait()
