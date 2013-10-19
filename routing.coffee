Router.configure
	autoRender       : false
	layoutTemplate   : 'layout'
	notFoundTemplate : 'notFound'

Router.map ->
	@route 'home',
		path : '/'

	# Example of using the before hooks
	@route 'before',
		path   : '/before'
		before : [
			-> @subscribe('delayed-collection1').wait()
			-> @subscribe('delayed-collection6').wait()
		]

	# Examle of using waitOn
	@route 'waitOn',
		path   : '/waiton'
		waitOn : ->
			[
				Meteor.subscribe 'delayed-collection2'
				Meteor.subscribe 'delayed-collection5'
			]

	@route 'waitOnNoTick',
		path                : '/waiton-no-tick'
		disableProgressTick : true
		waitOn              : ->
			[
				Meteor.subscribe 'delayed-collection3'
				Meteor.subscribe 'delayed-collection4'
			]

	@route 'stop',
		path                : '/stop'
		before : ->
			@render 'stopped'
			@stop()

	@route 'notHere',
		path : '/not-here'
		data : ->
			DelayedCollections.one.findOne()
