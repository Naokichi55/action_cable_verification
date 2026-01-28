import consumer from "./consumer"


document.addEventListener('DOMContentLoaded', function(){
// constにて変数を定義
  const racketElement = document.querySelector('[data-racket-id]');
  const racketId = racketElement?.dataset.racketId;
//データを受け取った時の処理について記載。
//constにて変数を定義

  console.log('Racket Id', racketId);
  console.log('Racket Element:', racketElement);

if(racketId){
  const subscription = consumer.subscriptions.create({
  channel: "CommentsChannel",
  racket_id: racketId
  }, {
    connected() {
      console.log("Connected to comments channel for racket")
      //サブスクリプションがサーバー上で使用可能になった時に呼び出される。
    },
    //接続が切断された時の処理。デバックとして記録
    disconnected() {
      console.log("Disconnected from comments channel")
      //サブスクリプションがサーバー上で終了した時に呼び出される
    },
//データを受け取った時の処理について記載。
  received(data){
      console.log("Received data:", data);
      //リアルタイムでコメントを追加
      //table-commentをracket-idに変更すると投稿がワンクリックで2回コメントが投稿される。
    const  commentsContainer = document.getElementById('table-comment')
    console.log("Comments container:", commentsContainer);

    if(commentsContainer && data.comment) {
      commentsContainer.insertAdjacentHTML('afterbegin', data.comment);
      console.log("Comment add successfully");
    }else{
      console.error("Comments container not found or no comment data");
     }
    }
    });
  }else{
    console.log("No");
    //チャンネルのWebSocketで受信データがあるときに呼び出される。
  }
  });

// 元々記載していた内容をコメントアウト
// import consumer from "./consumer"
// window.addEventListener('load',function(){

// consumer.subscriptions.create("CommentsChannel", {
//   connected() {
//     // Called when the subscription is ready for use on the server
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the servere
//   },

//   received(data) {
//     const html = `<div id="test-$(data.id)">
//     <p><a href="/users/${data.user.id}">@${data.user.name}</a></p>
//     <span style="font-weight:bold;">${data.body.body}</span>
//     &nbsp;${data.data}
//     &nbsp;<a id="delete-btn",data-method="delete" href="/posts/${data.post.id}/comments/${data.id}"><button id="${data.id}">削除</button></a>
//     <div>`;

//     const message = document.getElementById('collapseExample');
//     const newMessage = document.getElementById('comment_content');
//     message.insertAdjacentHTML('beforeend', html);
//     newMessage.value='';
//       var countComment = document.getElementById('collapseExample').length;
//       console.log(countComment)
//     // Called when there's incoming data on the websocket for this channel
//   }
// });
// })


