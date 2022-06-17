package main



import "core:fmt"
import "core:strings"

import "display"
import "registers"

import "raylib"




//= Main
main :: proc() {

	raylib.set_trace_log_level(7);
	raylib.init_window(1280, 720, "Sieve");
	raylib.set_target_fps(60);


	display.initialize_display();
	registers.initialize_DMG();


	font: raylib.Font = raylib.load_font("data/kong.ttf");


	for !raylib.window_should_close() {
		// Updating
		{
			display.update_display();
		}

		// Drawing
		{
			raylib.begin_drawing();
				raylib.clear_background(raylib.Color{ 20, 20, 20, 255 });
				
				display.draw_display(font);

				raylib.draw_fps(0,0);
			raylib.end_drawing();
		}
	}

	display.free_display();
	registers.free_DMG();
	raylib.unload_font(font);
	raylib.close_window();
}
