package display



//= Imports
import "core:fmt"
import "core:strings"

import "../raylib"

//= Global Variables

//= Constants

//= Enumerations

//= Structures
Display :: struct {
	currentLine: u64,
	verticalOffset: i64,

	text: [dynamic]string,
}

//= Procedures

//- Management
// Initialization
initialize_display :: proc() -> ^Display {
	disp: ^Display = new(Display);
	disp.text = make([dynamic]string);

	// TODO: TEST
	append(&disp.text, "This_is_a_test:", "    ld  a,b", "    ret", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

	return disp;
}
// Free
free_display :: proc(ptr: ^Display) {
	delete(ptr.text);
	free(ptr);
}

//- Updating / Drawing
// Update
update_display :: proc(disp: ^Display) {
	
	if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_V) && raylib.is_key_down(raylib.Keyboard_Key.KEY_LEFT_CONTROL) {
		
	}
	
	if raylib.is_key_down(raylib.Keyboard_Key.KEY_LEFT_CONTROL) || raylib.is_key_down(raylib.Keyboard_Key.KEY_RIGHT_CONTROL) {
		// CTRL + V
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_V) {
			cstr: cstring  = raylib.get_clipboard_text();
			str:  string   = strings.clone_from_cstring_bounded(cstr, len(cstr));
			stra: []string = strings.split_lines(str);

			delete(disp.text);
			disp.text = make([dynamic]string);

			for i:=0; i < len(stra); i+=1 {
				append(&disp.text,stra[i]);
			}
		}
		// CTRL + UP/DOWN
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_UP) {
			disp.verticalOffset = 80;
		}
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_DOWN) {
			disp.verticalOffset = (i64(-len(disp.text) * 20) + 620)
		}
	} else {
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_UP) {
			if disp.verticalOffset < 80 do disp.verticalOffset += 20;
		}
		if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_DOWN) {
			// TODO: lock this
			disp.verticalOffset -= 20;
		}
	}
}
// Draw
draw_display :: proc(disp: ^Display, font: raylib.Font) {
	for i:=0; i < len(disp.text); i+=1 {
		builder: strings.Builder;
		str:     string = fmt.sbprintf(&builder, "%i", i + 1);

		line: cstring = strings.clone_to_cstring(str);
		text: cstring = strings.clone_to_cstring(disp.text[i]);
		
		raylib.draw_text_ex(font, line, raylib.Vector2{25, f32(i * 20) + 20 + f32(disp.verticalOffset)}, 16, 0, raylib.RAYWHITE);
		raylib.draw_text_ex(font, text, raylib.Vector2{75, f32(i * 20) + 20 + f32(disp.verticalOffset)}, 16, 0, raylib.RAYWHITE);
	}
}

//- Utilities