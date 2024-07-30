CREATE TABLE IF NOT EXISTS node (
	node_id INTEGER NOT NULL, 
	name TEXT, 
	x_coord FLOAT NOT NULL, 
	y_coord FLOAT NOT NULL, 
	z_coord FLOAT, 
	node_type TEXT, 
	ctrl_type TEXT, 
	zone_id INTEGER, 
	parent_node_id INTEGER, 
	PRIMARY KEY (node_id), 
	FOREIGN KEY(zone_id) REFERENCES zone (zone_id), 
	FOREIGN KEY(parent_node_id) REFERENCES node (node_id)
)