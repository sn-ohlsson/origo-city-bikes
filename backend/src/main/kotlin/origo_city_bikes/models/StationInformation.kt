package origo_city_bikes.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable
data class StationInformation(
	@SerialName("last_updated")
	val lastUpdated: Long,
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
	@SerialName("station_id")
	val stationID: String,
	val name: String,
	val address: String,
	@SerialName("cross_street")
	val crossStreet: String?,
	val lat: Double,
	val lon: Double,
	@SerialName("is_virtual_station")
	val isVirtualStation: Boolean,
	val capacity: Int,
	@SerialName("station_area")
	val stationArea: StationArea,
	@SerialName("rental_uris")
	val rentalUris: RentalUris
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