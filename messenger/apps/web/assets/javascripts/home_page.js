let destroy_after_1_visit = document.getElementById("destroy_after_1_visit");
let destroy_after_1_hour = document.getElementById("destroy_after_1_hour");
let destroy_after_hours = document.getElementById("destroy_after_hours");
let btn_create = document.getElementById("btn_create");
let message_text = document.getElementById("message-text");
let message_password = document.getElementById("message-password");

function destroyAfterFirstVisit(){
	destroy_after_1_hour.checked = false;
	destroy_after_hours.value = 1;
	if (destroy_after_1_visit.checked && message_text.value.length > 1 && message_password.value.length > 1){
		btn_create.disabled = false;
	}
	else{
		btn_create.disabled = true;
	}
}

 destroy_after_1_visit.addEventListener("change", destroyAfterFirstVisit);

 function destroyAfterHour(){
	destroy_after_1_visit.checked = false;
	destroy_after_hours.value = 1;
	if (destroy_after_1_hour.checked && message_text.value.length > 1 && message_password.value.length > 1){
		btn_create.disabled = false;
	}
	else{
		btn_create.disabled = true;
	}
}

 destroy_after_1_hour.addEventListener("change", destroyAfterHour);

 function destroyAfterHours(){
 		destroy_after_1_visit.checked = false;
		destroy_after_1_hour.checked = false;
	if (destroy_after_hours.value > 1 && message_text.value.length > 1 && message_password.value.length > 1){
		btn_create.disabled = false;
	}
	else{
		btn_create.disabled = true;
	}
}

 destroy_after_hours.addEventListener("input", destroyAfterHours);










 