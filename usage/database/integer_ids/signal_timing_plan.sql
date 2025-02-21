CREATE TABLE IF NOT EXISTS signal_timing_plan (
	timing_plan_id INTEGER NOT NULL, 
	controller_id INTEGER NOT NULL, 
	timeday_id INTEGER, 
	time_day TEXT, 
	cycle_length FLOAT CHECK (cycle_length <= 600) CHECK (cycle_length >= 0), 
	PRIMARY KEY (timing_plan_id), 
	FOREIGN KEY(controller_id) REFERENCES signal_controller (controller_id), 
	FOREIGN KEY(timeday_id) REFERENCES time_set_definitions (timeday_id)
)