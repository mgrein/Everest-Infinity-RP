resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
	"data/handling.meta",
	"data/vehiclelayouts.meta",
	"data/vehicles.meta",
	"data/carcols.meta",
	"data/carvariations.meta",
	"data2/handling.meta",
	"data2/vehiclelayouts.meta",
	"data2/vehicles.meta",
	"data2/carcols.meta",
	"data2/carvariations.meta"
}

client_script "data/tuning.lua"

data_file "HANDLING_FILE" "data/handling.meta"
data_file "VEHICLE_LAYOUTS_FILE" "data/vehiclelayouts"
data_file "VEHICLE_METADATA_FILE" "data/vehicles.meta"
data_file "CARCOLS_FILE" "data/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/carvariations.meta"
data_file "HANDLING_FILE" "data2/handling.meta"
data_file "VEHICLE_LAYOUTS_FILE" "data2/vehiclelayouts"
data_file "VEHICLE_METADATA_FILE" "data2/vehicles.meta"
data_file "CARCOLS_FILE" "data2/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data2/carvariations.meta"