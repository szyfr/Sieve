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

	img: raylib.Image     = raylib.load_image("data/cursor.png");
	display.cursorTexture = raylib.load_texture_from_image(img);
	raylib.unload_image(img);

	// TODO: TEST
	append(&display.text, "This_is_a_test:", "    ld  a,b", "    ret", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
}
// Free
free_display :: proc() {
	delete(display.text);
	raylib.unload_texture(display.cursorTexture);
	free(display);
}

//- Updating / Drawing
// Update
update_display :: proc() {
	keyUp:   bool = raylib.is_key_pressed(raylib.Keyboard_Key.KEY_UP)   || raylib.is_key_pressed(raylib.Keyboard_Key.KEY_W);
	keyDown: bool = raylib.is_key_pressed(raylib.Keyboard_Key.KEY_DOWN) || raylib.is_key_pressed(raylib.Keyboard_Key.KEY_S);
	
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
		if keyUp {
			display.verticalOffset = 80;
		}
		if keyDown {
			display.verticalOffset = (i64(-len(display.text) * 20) + 620)
		}
	} else {
		// UP/DOWN
		if keyUp {
			if display.verticalOffset < 80 do display.verticalOffset += 20;
		}
		if keyDown {
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
		
		raylib.draw_text_ex(font, line, raylib.Vector2{ 50, f32(i * 20) + 20 + f32(display.verticalOffset)}, 16, 0, raylib.RAYWHITE);
		raylib.draw_text_ex(font, text, raylib.Vector2{125, f32(i * 20) + 20 + f32(display.verticalOffset)}, 16, 0, raylib.RAYWHITE);
	}
	raylib.draw_texture(display.cursorTexture, 25, i32(display.currentPosition * 20) + 20 + i32(display.verticalOffset), raylib.WHITE)
}

//- Utilities