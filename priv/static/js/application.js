;(() => {
  class myWebsocketHandler {
    setupSocket() {
      this.socket = new WebSocket('ws://localhost:8080/ws/chat')

      this.socket.addEventListener('message', (event) => {
        if (!event.data) return
        const chatDialogItem = document.createElement('li')
        chatDialogItem.className = 'dialog-item'
        const chatDialog = document.createElement('p')
        chatDialog.className = 'dialog'
        chatDialog.innerHTML = event.data
        chatDialogItem.append(chatDialog)

        document.querySelector('.chat-content-js').append(chatDialogItem)
      })

      this.socket.addEventListener('close', () => {
        this.setupSocket()
      })
    }

    submit(event) {
      event.preventDefault()
      const input = document.getElementById('message')
      const message = input.value
      input.value = ''

      if (!message) return
      this.socket.send(
        JSON.stringify({
          data: { message: message },
        })
      )
    }
  }

  const WebSocketHandler = new myWebsocketHandler()
  WebSocketHandler.setupSocket()
  document
    .getElementById('button')
    .addEventListener('click', (event) => WebSocketHandler.submit(event))
})()
