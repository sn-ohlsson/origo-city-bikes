package origo_city_bikes.plugins

import io.ktor.client.*
import io.ktor.client.engine.cio.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.plugins.contentnegotiation.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.json.Json
import origo_city_bikes.models.StationInformation

fun Application.configureSerialization() {
	install(ContentNegotiation) {
		json(Json {
			prettyPrint = true
			isLenient = true
			ignoreUnknownKeys = true
		})
	}

	routing {
		get("/origo") {
			val client = HttpClient(CIO)
			val response: HttpResponse =
				client.request("https://gbfs.urbansharing.com/oslobysykkel.no/station_information.json") {
					method = HttpMethod.Get
					headers {
						append("Client-Identifier", "origo-jobinterview-sn-ohlsson")
					}
				}

			val jsonData = response.bodyAsText()
			val serialised: StationInformation = Json.decodeFromString<StationInformation>(jsonData)

			// TODO: Only send relevant info from serialized data to client

			call.respond(jsonData)
		}
	}
}