package origo_city_bikes

import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.plugins.cors.routing.*
import origo_city_bikes.plugins.configureSerialization

fun main() {
	embeddedServer(Netty, port = 8080, host = "localhost", module = Application::module)
		.start(wait = true)
}

fun Application.module() {
	install(CORS) {
		allowHost("localhost:1234")
	}
	configureSerialization()
}
