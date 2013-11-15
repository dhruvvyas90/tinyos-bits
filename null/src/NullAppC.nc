#include "Null.h" 

configuration SendAppC { 
}
implementation {
	components MainC;
	components NullC as App;
	App.Boot -> MainC;
}
