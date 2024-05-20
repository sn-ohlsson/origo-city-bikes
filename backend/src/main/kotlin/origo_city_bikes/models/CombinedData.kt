package origo_city_bikes.models

import kotlinx.serialization.Serializable

@Serializable
data class CombinedStationData(
	val last_updated: Long,
	val ttl: Int,
	val version: String,
	val data: List<CombinedStation>
)

@Serializable
data class CombinedStation(
	val station_id: String,
	val name: String,
	val address: String,
	val cross_street: String?,
	val is_virtual_station: Boolean,
	val capacity: Int,
	val num_bikes_available: Int,
	val num_docks_available: Int
)