package origo_city_bikes.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class BikeData(
	@SerialName("last_updated")
	val lastUpdated: Long,
	val ttl: Int,
	val version: String,
	val data: StationStatusData
)

@Serializable
data class StationStatusData(
	val stations: List<BikeStation>
)

@Serializable
data class BikeStation(
	@SerialName("station_id")
	val stationID: String,
	@SerialName("is_installed")
	val isInstalled: Boolean,
	@SerialName("is_renting")
	val isRenting: Boolean,
	@SerialName("is_returning")
	val isReturning: Boolean,
	@SerialName("last_reported")
	val lastReported: Long,
	@SerialName("num_vehicles_available")
	val numVehiclesAvailable: Int,
	@SerialName("num_bikes_available")
	val numBikesAvailable: Int,
	@SerialName("num_docks_available")
	val numDocksAvailable: Int,
	@SerialName("vehicle_types_available")
	val vehicleTypesAvailable: List<VehicleType>
)

@Serializable
data class VehicleType(
	@SerialName("vehicle_type_id")
	val vehicleTypeID: String,
	val count: Int
)