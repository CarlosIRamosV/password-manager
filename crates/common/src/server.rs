use actix_web::middleware::Logger;
use actix_web::web::ServiceConfig;
use actix_web::{App, HttpServer};
use env_logger::Env;
use std::env;

pub async fn create(config: fn(&mut ServiceConfig)) -> std::io::Result<()> {
    env_logger::init_from_env(Env::default().default_filter_or("info"));

    HttpServer::new(move || {
        App::new()
            .wrap(Logger::new("%a %r %s %b %{User-Agent}i %T"))
            .configure(config)
    })
    .bind((host(), port()))?
    .run()
    .await
}

fn host() -> String {
    env::var("HOST").unwrap_or("127.0.0.1".to_string())
}

fn port() -> u16 {
    env::var("PORT")
        .ok()
        .and_then(|p| p.parse().ok())
        .unwrap_or(8080)
}
