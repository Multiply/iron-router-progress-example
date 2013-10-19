Router.configure
	autoRender       : false
	layoutTemplate   : 'layout'
	notFoundTemplate : 'notFound'

Router.map ->
	@route 'home',
		path : '/'

	@route 'delay',
		path   : '/delay'
		# Example of using the before hooks
		before : [
			-> @subscribe('delayed-collection4').wait()
			-> @subscribe('delayed-collection1').wait()
		]

	@route 'delayNoTick',
		path                : '/delay-no-tick'
		disableProgressTick : true
		# Examle of using waitOn
		waitOn              : ->
			[
				Meteor.subscribe 'delayed-collection2'
				Meteor.subscribe 'delayed-collection3'
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
