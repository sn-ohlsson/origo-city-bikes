package origo_city_bikes.plugins

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting() {
	routing {
		get("/") {
			call.respond(HttpStatusCode.OK)
		}

		get("/origo") {
			// TODO: Call city bike API, serialize data and send some nice JSON to Elm
			call.respond("Stuff here!")
		}
	}
}
