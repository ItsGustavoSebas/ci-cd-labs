#!/bin/bash
# Script de Despliegue Automatizado para Aplicaciones Spring Boot en Producción / HA
# Laboratorio 6 - CI/CD

set -e

APP_DIR="/home/osboxes/opt/spring-boot-app"
VERSIONS_DIR="$APP_DIR/versions"
LOGS_DIR="$APP_DIR/logs"

echo "=== Inicio del Proceso de Despliegue ==="

# 1. Crear directorios necesarios
mkdir -p "$APP_DIR" "$VERSIONS_DIR" "$LOGS_DIR"

# 2. Localizar artefacto JAR entrante
JAR_SRC=${1:-"webapi-0.0.1-SNAPSHOT.jar"}

if [ ! -f "$JAR_SRC" ] && [ ! -f "$APP_DIR/$JAR_SRC" ]; then
    echo "ERROR: No se encontró el archivo JAR '$JAR_SRC'"
    exit 1
fi

if [ -f "$JAR_SRC" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_NAME="webapi_${TIMESTAMP}.jar"
    echo "Guardando versión en historial: $VERSIONS_DIR/$BACKUP_NAME"
    cp "$JAR_SRC" "$VERSIONS_DIR/$BACKUP_NAME"
    cp "$JAR_SRC" "$APP_DIR/app.jar"
fi

cd "$APP_DIR"

# 3. Detener instancias anteriores si están ejecutándose
echo "Deteniendo procesos previos en puertos 8081 y 8082..."
fuser -k 8081/tcp 2>/dev/null || true
fuser -k 8082/tcp 2>/dev/null || true

sleep 2

# 4. Iniciar Instancia 1 (Puerto 8081)
echo "Iniciando Instancia 1 en puerto 8081..."
nohup java -jar app.jar --server.port=8081 > "$LOGS_DIR/app-8081.log" 2>&1 &
PID_8081=$!
echo "Instancia 1 iniciada con PID: $PID_8081"

# 5. Iniciar Instancia 2 (Puerto 8082)
echo "Iniciando Instancia 2 en puerto 8082..."
nohup java -jar app.jar --server.port=8082 > "$LOGS_DIR/app-8082.log" 2>&1 &
PID_8082=$!
echo "Instancia 2 iniciada con PID: $PID_8082"

sleep 5

# 6. Verificación de Salud Local
echo "Verificando estado de ejecución..."
ps aux | grep "app.jar" | grep -v grep

echo "=== Despliegue Finalizado Exitosamente ==="
