Router.configure
#	autoRender       : false
	layoutTemplate   : 'layout'
	notFoundTemplate : 'notFound'

if Meteor.isClient
	IronRouterProgress.configure
		spinner : true

Router.onBeforeAction 'dataNotFound'

Router.map ->
	@route 'home',
		path : '/'

	# Example of using the before hooks
	@route 'before',
		path           : '/before'
		onBeforeAction : [
			-> @subscribe('before-collection1').wait()
			-> @subscribe('before-collection2').wait()
		]

	# Example of using the before with no spinner
	@route 'beforeNoSpinner',
		path     : '/before-no-spinner'
		progress :
			spinner : false
		onBeforeAction : [
			-> @subscribe('before-no-spinner-collection1').wait()
			-> @subscribe('before-no-spinner-collection2').wait()
		]

	# Examle of using waitOn
	@route 'waitOn',
		path   : '/waiton'
		waitOn : ->
			[
				Meteor.subscribe 'wait-on-collection1'
				Meteor.subscribe 'wait-on-collection2'
			]

	@route 'waitOnNoTick',
		path     : '/waiton-no-tick'
		progress :
			tick : true
		waitOn   : ->
			[
				Meteor.subscribe 'wait-on-no-tick-collection1'
				Meteor.subscribe 'wait-on-no-tick-collection2'
			]

	@route 'stop',
		path           : '/stop'
		onBeforeAction : ->
			@render 'stopped'
			@stop()

	@route 'notHere',
		path             : '/not-here'
		notFoundTemplate : 'notFound'
		data             : ->
			DelayedCollections['not-here-collection1'].findOne()

	@route 'disabled',
		path : '/disabled'
		progress :
			enabled : false
