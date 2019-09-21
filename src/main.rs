use actix_web::{web, App, HttpRequest, HttpServer, Responder};
use gethostname::*;
use serde_json::*;

fn say_hostname(_: HttpRequest) -> impl Responder {
    json!({
    "message":"你好，世界",
    "hostname": gethostname().to_str().expect("error getting hostname")
    })
    .to_string()
}

fn main() {
    HttpServer::new(|| App::new().route("/", web::get().to(say_hostname)))
        .bind("0.0.0.0:8888")
        .expect("Can not bind to port 8888")
        .run()
        .unwrap();
}
