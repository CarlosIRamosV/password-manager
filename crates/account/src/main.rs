use actix_web::web::ServiceConfig;
use actix_web::{get, HttpResponse, Responder};
use common::server;

#[get("/")]
async fn hello() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    fn config(cfg: &mut ServiceConfig) {
        cfg.service(hello);
    }
    server::create(config).await
}
