
  function modifyArticleIndexButtons(){
  var articleIndexButtons = document.getElementsByClassName("article-viewer")
  for (var i = 0; i < articleIndexButtons.length; i++) {
    var btn = articleIndexButtons[i]
    btn.onclick = function(){
      btn.style["text-decoration"] = "line-through"
    }
  }
}


function init() {
  var user = document.getElementById("user")
  var body = document.getElementsByTagName("body")[0]
  var isLoggedIn = (user.dataset.checkLogin == "true")
  var image = (document.getElementById("userBackground") ? document.getElementById("userBackground").dataset.userBackground : "")
  if (!isLoggedIn) {
    body.style.background = "#5d687a"
  } else {
    body.style.background = 'url(' + image + ') no-repeat'
    body.style["background-size"] = "cover"

  }

}

function loadDoc() {

  document.addEventListener("turbolinks:load", function(event){
    init();
  });
}

loadDoc()