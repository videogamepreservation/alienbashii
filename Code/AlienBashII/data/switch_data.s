
MAX_EVENTS	EQU	30
MAX_SWITCHES	EQU	20

*Switch data

*Each level can have up to 20 switches, for each level a table
*shall be constructed containing the switches, there shall be 20
*switch blocks, each of these will have a correspoding pointer in 
*the table - these will be copied into the table in here


switch_table
	ds.l	MAX_SWITCHES
	
event_table
	ds.l 	MAX_EVENTS

