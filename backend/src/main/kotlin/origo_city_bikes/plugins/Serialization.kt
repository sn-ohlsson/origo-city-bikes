package origo_city_bikes.plugins

import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.engine.cio.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.json.Json
import origo_city_bikes.models.*

fun Application.configureSerialization() {
	routing {
		get("/origo") {
			val client = HttpClient(CIO) {
				install(ContentNegotiation) {
					json(Json {
						ignoreUnknownKeys = true
					})
				}
			}

			// Fetch station data
			val stationDataResponse: StationInformation =
				client.get("https://gbfs.urbansharing.com/oslobysykkel.no/station_information.json") {
					headers {
						append("Client-Identifier", "origo-jobinterview-sn-ohlsson")
					}
				}.body()

			// Fetch bike data
			val bikeDataResponse: BikeData =
				client.get("https://gbfs.urbansharing.com/oslobysykkel.no/station_status.json") {
					headers {
						append("Client-Identifier", "origo-jobinterview-sn-ohlsson")
					}
				}.body()


			val combinedStations: List<CombinedStation> = stationDataResponse.data.stations.map { station ->
				val bikeData: BikeStation? = bikeDataResponse.data.stations.find { it.stationID == station.stationID }

				CombinedStation(
					station_id = station.stationID,
					name = station.name,
					address = station.address,
					cross_street = station.crossStreet ?: "",
					is_virtual_station = station.isVirtualStation,
					capacity = station.capacity,
					num_bikes_available = bikeData?.numBikesAvailable ?: 0,
					num_docks_available = bikeData?.numDocksAvailable ?: 0
				)
			}

			val combinedStationData = CombinedStationData(
				last_updated = stationDataResponse.lastUpdated,
				ttl = stationDataResponse.ttl,
				version = stationDataResponse.version,
				data = combinedStations
			)

			call.respond(combinedStationData)
		}
	}
}