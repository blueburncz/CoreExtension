timer = new CE_Timer();

// This one is canceled so it won't show
timer.AddTimeout(function () {
	show_debug_message("Timeout 1!");
}, 1000).Cancel();

timer.AddTimeout(function () {
	show_debug_message("Timeout 2!");
}, 1000);