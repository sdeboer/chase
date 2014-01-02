class WebSocket
	constructor: (@$q, @$rootScope)->
		console.log 'ws start'
		@host = 'ws://localhost:10100/play/'

		@callbacks = {}
		@callbackId = 0

	getCallbackId: ->
		if @callbackId > 10000
			@callbackId = 0
		else
			@callbackId += 1

	setHost: (@host)->

	connect: (id)->
		@ws = new WebSocket(@host + id)

		@ws.onopen = -> console.log "Websocket opened"

		@ws.onmessage = @onMessage

	sendRequest: (request)->
		defer = @$q.defer()
		cid = @getCallbackId()
		@callbacks[cid] =
			time: Date.now()
			cb: defer

		request.callback_id = cid
		console.log "sending", request
		@ws.send JSON.stringify(request)
		defer.promise

	onMessage: (msg)=>
		data = JSON.parse msg.data
		console.log "received", data
		cid = data.callback_id

		if cid of @callbacks
			@$rootScope.$apply ->
				@callbacks[cid].cb.resolve data.data

			delete @callbacks[cid]

		data

class Provider
	constructor: (@$q, @$rootScope)->

	$get: ->
		ws = new WebSocket(@$q, @$rootScope)
		ws

console.log "BE CA"
ChaseApp = angular.module 'ChaseApp'
ChaseApp.provider 'WebSocket', ['$q', '$rootScope', Provider]
console.log "AF CA"
