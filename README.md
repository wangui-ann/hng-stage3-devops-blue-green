This is a simple Node.js applications that sets up a blue/green deployment architecture using Docker Compose. It runs two Node.js apps (Blue and Green) behind an Nginx reverse proxy. Nginx automatically fails over to the healthy app if one goes down.

**Project Structure**

- `app_blue` → Node.js app (v1.0.0) on port 8081  
- `app_green` → Node.js app (v1.0.1) on port 8082  
- `nginx` → Reverse proxy on port 8080 with automatic failover

  
**How to clone the project and set up:**
git clone https://github.com/wangui-ann/hng-stage3-devops-blue-green on your terminal
cd into the project folder
Set your env variables

**Starting the stack**
docker-compose up -d --build
(Ensure you have Docker engine running on your machine)

**Accessing and testing the app**
curl -i http://localhost:8080/version


**Chaos testing**
Start chaos test on blue:
curl -X POST http://localhost:8081/chaos/start?mode=error

Then run:
curl -i http://localhost:8080/version
- This should validate that nginx has failed over from blue to green
  
Stop chaos test:
curl -X POST http://localhost:8081/chaos/stop
