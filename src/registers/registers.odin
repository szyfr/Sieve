package registers



//= Imports

//= Global Variables

//= Constants
registerDMG: ^GameboyRegisters;

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
initialize_DMG :: proc() {
	registerDMG = new(GameboyRegisters);
	registerDMG.stack = make([dynamic]u8);
}
// Free
free_DMG :: proc() {
	delete(registerDMG.stack);
	free(registerDMG);
}