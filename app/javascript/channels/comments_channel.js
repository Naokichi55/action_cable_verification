import consumer from "./consumer"

consumer.subscriptions.create("CommentsChannel", {
  connected() {
    Called when the subscription is ready for use on the server
  },

  disconnected() {
    Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<div id="test-$(data.id)">
    <p><a href="/users/${data.user.id}">@${data.user.name}</a></p>
    <span style="font-weight:bold;">${data.content.content}</span>
    &nbsp;${data.data}
    &nbsp;<a id="delete-btn",data-method="delete" href="/posts/${data.post.id}/comments/${data.id}"><button id="${data.id}">削除</button></a>
    <div>`;

    const message = document.getElementById('collapseExample');
    const newMessage = document.getElementById('comment_content');
    message.insertAdjacentHTML('beforeend', html);
    newMessage.value='';
      var countComment = document.getElementById('collapseExample').length;
      console.log(countComment)
    // Called when there's incoming data on the websocket for this channel
  }
});
