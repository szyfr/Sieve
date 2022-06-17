package registers



//= Imports
import "core:fmt"
import "core:strings"
import "../raylib"

//= Global Variables

//= Constants
registerDMG: ^GameboyRegisters;

//= Enumerations

//= Structures
GameboyRegisters :: struct {
	a,b,c,d,e,f: u8,
	hl,sp:       u16,
	stack: [dynamic]u8,

	
	background: raylib.Texture,
}

//= Procedures

//- Management
// Initialization
initialize_DMG :: proc() {
	registerDMG       = new(GameboyRegisters);
	registerDMG.stack = make([dynamic]u8);

	img: raylib.Image      = raylib.gen_image_color(400, 720, raylib.Color{ 40, 40, 40, 255 });
	registerDMG.background = raylib.load_texture_from_image(img);

	registerDMG.a  = 0xFF;
	registerDMG.hl = 0xFFFF;
	raylib.unload_image(img);
}
// Free
free_DMG :: proc() {
	delete(registerDMG.stack);
	free(registerDMG);
}

//- Updating / Drawing
// Update
update_dmg :: proc() {}
// Draw
draw_dmg :: proc(font: raylib.Font) {
	raylib.draw_texture(registerDMG.background, 1280 - registerDMG.background.width, 0, raylib.WHITE);

	builder: strings.Builder;

	regLine1s: string  = fmt.sbprintf(&builder, "%X\n%X\n\n%X\n%X\n\n%X\n%X", registerDMG.a, registerDMG.f, registerDMG.b, registerDMG.c, registerDMG.d, registerDMG.e);
	regLine1c: cstring = strings.clone_to_cstring(regLine1s);

	strings.reset_builder(&builder);

	regLine2s: string  = fmt.sbprintf(&builder, "%X\n\n\n%X", registerDMG.hl, registerDMG.sp);
	regLine2c: cstring = strings.clone_to_cstring(regLine2s);

	// Registers
	raylib.draw_text_ex(font, "A:\nF:\n\nB:\nC:\n\nD:\nE:", raylib.Vector2{1320 - f32(registerDMG.background.width), 40}, 16, 0, raylib.RAYWHITE);
	raylib.draw_text_ex(font, regLine1c,                    raylib.Vector2{1370 - f32(registerDMG.background.width), 40}, 16, 0, raylib.RAYWHITE);

	raylib.draw_text_ex(font, "HL:\n\n\nSP:",               raylib.Vector2{1520 - f32(registerDMG.background.width), 40}, 16, 0, raylib.RAYWHITE);
	raylib.draw_text_ex(font, regLine2c,                    raylib.Vector2{1590 - f32(registerDMG.background.width), 40}, 16, 0, raylib.RAYWHITE);
	

//	free(regLine1c);
//	free(regLine2c)
}