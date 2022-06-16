package registers



//= Imports

//= Global Variables

//= Constants

//= Enumerations

//= Structures
GameboyRegisters :: struct {
	a,b,c,d,e,f: u8,
	hl,sp:       u16,

	stack: [dynamic]u8,
}

//= Procedures

//- Management
// Initialization
initialize_DMG :: proc() -> ^GameboyRegisters {
	dmg: ^GameboyRegisters = new(GameboyRegisters);
	dmg.stack = make([dynamic]u8);

	return dmg;
}
// Free
free_DMG :: proc(ptr: ^GameboyRegisters) {
	delete(ptr.stack);
	free(ptr);
}