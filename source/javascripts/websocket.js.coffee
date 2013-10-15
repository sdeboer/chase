ChaseApp = angular.module 'ChaseApp'

host = 'ws://localhost:10100/ws'

callbacks = {}
callbackId = 0

getCallbackId = ->
	if callbackId > 10000
		callbackId = 0
	else
		callbackId += 1

SocketConstructor = ($q, $rootScope)->
	ws = new WebSocket host

	ws.onopen = -> console.log "Websocket opened"

	ws.onmessage = (msg)->
		data = JSON.parse msg.data
		console.log "received", data
		cid = data.callback_id

		if cid of callbacks
			$rootScope.$apply ->
				callbacks[data.callback_id].cb.resolve data.data

				delete callbacks[cid]

	SocketService = {}

	sendRequest = (request)->
		defer = $q.defer()
		cid = getCallbackId()
		callbacks[cid] =
			time: Date.now()
			cb: defer

		request.callback_id = cid
		console.log "sending", request
		ws.send JSON.stringify(request)
		defer.promise

	SocketService.sendRequest = sendRequest

	SocketService

ChaseApp.factory 'WebsocketService', ['$q', '$rootScope', SocketConstructor]
