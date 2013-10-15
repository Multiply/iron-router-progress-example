Router.configure
	autoRender       : false
	layoutTemplate   : 'layout'
	notFoundTemplate : 'notFound'

Router.map ->
	@route 'home',
		path : '/'

	@route 'delay',
		path   : '/delay'
		waitOn : ->
			[
				Meteor.subscribe 'delayed-collection4'
				Meteor.subscribe 'delayed-collection1'
			]

	@route 'delayNoTick',
		path                : '/delay-no-tick'
		disableProgressTick : true
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
