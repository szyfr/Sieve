package display



//= Imports
import "core:fmt"
import "core:strings"

import "../raylib"

//= Global Variables
display: ^Display;

//= Constants

//= Enumerations

//= Structures
Display :: struct {
	currentPosition: u64,
	cursorTexture: raylib.Texture,

	verticalOffset: i64,

	text: [dynamic]string,
}

//= Procedures

//- Management
// Initialization
initialize_display :: proc() {
	display      = new(Display);
	display.text = make([dynamic]string);

	// TODO: TEST
	append(&display.text, "This_is_a_test:", "    ld  a,b", "    ret", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
}
// Free
free_display :: proc() {
	delete(display.text);
	free(display);
}

//- Updating / Drawing
// Update
update_display :: proc() {
	
	if raylib.is_key_down(raylib.Keyboard_Key.KEY_LEFT_CONTROL) || raylib.is_key_down(raylib.Keyboard_Key.KEY_RIGHT_CONTROL) {
		// CTRL + V
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_V) {
			cstr: cstring  = raylib.get_clipboard_text();
			str:  string   = strings.clone_from_cstring_bounded(cstr, len(cstr));
			stra: []string = strings.split_lines(str);

			delete(display.text);
			display.text = make([dynamic]string);

			for i:=0; i < len(stra); i+=1 {
				append(&display.text, stra[i]);
			}
		}

		// CTRL + UP/DOWN
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_UP) {
			display.verticalOffset = 80;
		}
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_DOWN) {
			display.verticalOffset = (i64(-len(display.text) * 20) + 620)
		}
	} else {
		// UP/DOWN
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_UP) {
			if display.verticalOffset < 80 do display.verticalOffset += 20;
		}
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_DOWN) {
			// TODO: lock this
			display.verticalOffset -= 20;
		}
	}
}
// Draw
draw_display :: proc(font: raylib.Font) {
	for i:=0; i < len(display.text); i+=1 {
		builder: strings.Builder;
		str:     string = fmt.sbprintf(&builder, "%i", i + 1);

		line: cstring = strings.clone_to_cstring(str);
		text: cstring = strings.clone_to_cstring(display.text[i]);
		
		raylib.draw_text_ex(font, line, raylib.Vector2{ 25, f32(i * 20) + 20 + f32(display.verticalOffset)}, 16, 0, raylib.RAYWHITE);
		raylib.draw_text_ex(font, text, raylib.Vector2{100, f32(i * 20) + 20 + f32(display.verticalOffset)}, 16, 0, raylib.RAYWHITE);
	}
}

//- Utilities