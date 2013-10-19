@DelayedCollections =
	one   : new Meteor.Collection 'delayed-collection1'
	two   : new Meteor.Collection 'delayed-collection2'
	three : new Meteor.Collection 'delayed-collection3'
	four  : new Meteor.Collection 'delayed-collection4'
	five  : new Meteor.Collection 'delayed-collection5'
	six   : new Meteor.Collection 'delayed-collection6'

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
		, 1000

		future.wait()

	Meteor.publish 'delayed-collection3', ->
		future = new Future

		Meteor.setTimeout ->
			future.return DelayedCollections.three.find()
		, 2000

		future.wait()

	Meteor.publish 'delayed-collection4', ->
		future = new Future

		Meteor.setTimeout ->
			future.return DelayedCollections.four.find()
		, 3000

		future.wait()

	Meteor.publish 'delayed-collection5', ->
		future = new Future

		Meteor.setTimeout ->
			future.return DelayedCollections.five.find()
		, 3000

		future.wait()

	Meteor.publish 'delayed-collection6', ->
		future = new Future

		Meteor.setTimeout ->
			future.return DelayedCollections.six.find()
		, 3000

		future.wait()
