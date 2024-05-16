package origo_city_bikes.models

import kotlinx.serialization.Serializable

@Serializable
data class StationInformation(
	val last_updated: Long,
	val ttl: Int,
	val version: String,
	val data: StationData
)

@Serializable
data class StationData(
	val stations: List<Station>
)

@Serializable
data class Station(
	val station_id: String,
	val name: String,
	val address: String,
	val cross_street: String,
	val lat: Double,
	val lon: Double,
	val is_virtual_station: Boolean,
	val capacity: Int,
	val station_area: StationArea,
	val rental_uris: RentalUris
)

@Serializable
data class StationArea(
	val type: String,
	val coordinates: List<List<List<List<Double>>>>
)

@Serializable
data class RentalUris(
	val android: String,
	val ios: String
)