package origo_city_bikes.plugins

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
			call.respondText("Text from backend here")
		}
	}
}