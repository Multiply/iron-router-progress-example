Router.configure
	layoutTemplate   : 'layout'
	notFoundTemplate : 'notFound'

# if Meteor.isClient
# 	IronRouterProgress.configure
# 		spinner : true

Router.onBeforeAction 'dataNotFound'

Router.route '/', ->
	@render 'home'

Router.route '/regular'

Router.route '/wait',
	waitOn : ->
		[
			Meteor.subscribe 'wait-collection1'
			Meteor.subscribe 'wait-collection2'
		]

Router.route '/waitOn',
	loadingTemplate : 'loading'
	waitOn          : ->
		[
			Meteor.subscribe 'waiton-collection1'
			Meteor.subscribe 'waiton-collection2'
		]

# Example of using the before with no spinner
Router.route '/noSpinner',
	progressSpinner : false
	waitOn : ->
		[
			Meteor.subscribe 'no-spinner-collection1'
			Meteor.subscribe 'no-spinner-collection2'
		]

Router.route '/noTick',
	progressTick : false
	waitOn   : ->
		[
			Meteor.subscribe 'no-tick-collection1'
			Meteor.subscribe 'no-tick-collection2'
		]

Router.route '/delay',
	progressDelay : 1500
	waitOn   : ->
		[
			Meteor.subscribe 'delay-collection1'
			Meteor.subscribe 'delay-collection2'
		]

Router.route '/stop',
	onBeforeAction : ->
		@render 'stopped'
		@stop()

Router.route '/notHere',
	notFoundTemplate : 'notFound'
	waitOn           : ->
		DelayedCollections['not-here-collection1'].findOne()

Router.route '/disabled',
	progress : false
