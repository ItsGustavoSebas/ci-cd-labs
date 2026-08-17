# Repositorio de Laboratorios de CI/CD (ci-cd-labs)

Este repositorio contiene las prácticas y laboratorios del módulo de **Integración Continua y Despliegue Continuo (CI/CD)**.

## Estructura del Repositorio

```text
ci-cd-labs/
├── README.md
├── app/
│   └── hello.txt
└── .github/
    └── workflows/
        └── pipeline.yml
```

## Laboratorio 1: Primer Pipeline de Integración Continua

### Objetivos
- Comprender la estructura básica de un pipeline de CI/CD.
- Configurar un repositorio en GitHub para ejecutar pipelines automáticos con GitHub Actions.
- Implementar un pipeline utilizando *Pipeline as Code* (`.github/workflows/pipeline.yml`).
- Analizar los resultados de ejecución y registros generados por cada commit.

### Verificación del Pipeline
El pipeline está configurado en `.github/workflows/pipeline.yml` y se ejecuta automáticamente en cada `push` realizado hacia la rama `main`.

---
*Desarrollado para el módulo de Integración y Despliegue Continuo.*

