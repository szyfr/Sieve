package main



import "core:fmt"
import "core:strings"

import "raylib"



//= Main
main :: proc() {

	raylib.set_trace_log_level(7);
	raylib.init_window(1280, 720, "Sieve");
	raylib.set_target_fps(60);


	font: raylib.Font = raylib.load_font("data/kongtext.ttf");


	for !raylib.window_should_close() {
		// Updating
		{

		}

		// Drawing
		{
			raylib.begin_drawing();
				raylib.clear_background(raylib.Color{ 20, 20, 20, 255 });
				raylib.draw_text("LD  A,[$5040]",20,20,20,raylib.GRAY);
				raylib.draw_fps(0,0);
			raylib.end_drawing();
		}
	}

	raylib.close_window();
}
