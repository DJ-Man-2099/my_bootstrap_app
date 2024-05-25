import $ from 'jquery'

//Use this event to ensure JS scripts are always loaded
//when navigating with Turbo
$(document).on('turbo:load', () => {
	console.log("Testing included JS");
	console.log($(".list-group-item"));

	$(".list-group-item").on({
		mouseenter: (event) => {
			console.log(event.currentTarget);
			$(event.currentTarget).addClass("active");
		},
		mouseleave: (event) => {
			$(event.currentTarget).removeClass("active");
		}
	})
})
