package origo_city_bikes.plugins

import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.serialization.gson.*
import io.ktor.server.application.*
import io.ktor.server.plugins.contentnegotiation.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureSerialization() {
	install(ContentNegotiation) {
		gson {
		}
	}

	routing {
		get("/origo") {

			val client = HttpClient()
			// TODO: Consider client.use due to single request being made
			// TODO: Replace url
			// TODO: Separate paths for separate requests/endpoints

			val response: HttpResponse = client.request("https://gbfs.urbansharing.com/oslobysykkel.no/gbfs.json") {
				method = HttpMethod.Get
				headers {
					append("Client-Identifier", "origo-jobinterview-sn-ohlsson")
				}
			}

			call.respondText("Text from backend here")
		}
	}
}