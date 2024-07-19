CREATE TABLE IF NOT EXISTS segment (
	segment_id TEXT NOT NULL, 
	link_id TEXT NOT NULL, 
	ref_node_id TEXT NOT NULL, 
	start_lr FLOAT NOT NULL CHECK (start_lr >= 0), 
	end_lr FLOAT NOT NULL CHECK (end_lr >= 0), 
	grade FLOAT CHECK (grade >= -100) CHECK (grade <= 100), 
	capacity FLOAT CHECK (capacity >= 0), 
	free_speed FLOAT CHECK (free_speed >= 0) CHECK (free_speed <= 200), 
	lanes INTEGER, 
	l_lanes_added INTEGER, 
	r_lanes_added INTEGER, 
	bike_facility TEXT, 
	ped_facility TEXT, 
	parking TEXT, 
	allowed_uses TEXT, 
	toll FLOAT, 
	jurisdiction TEXT, 
	row_width FLOAT CHECK (row_width >= 0), 
	PRIMARY KEY (segment_id), 
	FOREIGN KEY(ref_node_id) REFERENCES node (node_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id)
)