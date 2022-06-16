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

	text: [dynamic]string,
}

//= Procedures

//- Management
// Initialization
initialize_display :: proc() -> ^Display {
	disp: ^Display = new(Display);
	disp.text = make([dynamic]string);

	// TODO: TEST
	append(&disp.text, "This_is_a_test:", "    ld  a,b", "    ret", "");

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
		cstr: cstring  = raylib.get_clipboard_text();
		str:  string   = strings.clone_from_cstring_bounded(cstr, len(cstr));
		stra: []string = strings.split_lines(str);

		delete(disp.text);
		disp.text = make([dynamic]string);

		for i:=0; i < len(stra); i+=1 {
			append(&disp.text,stra[i]);
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

	//	raylib.draw_text(line, 25, i32(i * 20) + 20, 20, raylib.RAYWHITE);
	//	raylib.draw_text(text, 75, i32(i * 20) + 20, 20, raylib.RAYWHITE);
		
		raylib.draw_text_ex(font, line, raylib.Vector2{25, f32(i * 20) + 20}, 16, 0, raylib.RAYWHITE);
		raylib.draw_text_ex(font, text, raylib.Vector2{75, f32(i * 20) + 20}, 16, 0, raylib.RAYWHITE);
	}
}

//- Utilities