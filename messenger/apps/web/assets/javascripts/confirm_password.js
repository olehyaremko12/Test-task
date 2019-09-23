
let btn_show = document.getElementById("btn_show");
let confirm_password = document.getElementById("confirm_password");
let password = document.getElementById("password");
let content = document.getElementById("content");
let text_write_password = document.getElementById("text_write_password");

function myFunction(){
  if(password.innerHTML == confirm_password.value ){
  	content.hidden = false;
  	btn_show.style.display = 'none';
  	confirm_password.style.display = 'none';
  	text_write_password.style.display = 'none';
  }
  else{
  	alert("Wrong password. Try again")
  }
}

 btn_show.addEventListener("click", myFunction);