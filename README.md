# Healthcare Analytics Engineering Platform

## Overview

This project demonstrates the design and implementation of an end-to-end healthcare analytics platform using **dbt Core**, **Snowflake**, **SQL**, and **GitHub Actions**.

The platform transforms raw healthcare data into tested, documented, and business-ready datasets that support patient care gap reporting, clinical outreach, and operational analytics.

The project follows a layered Analytics Engineering architecture that separates source cleanup, reusable business logic, dimensional modeling, and reporting outputs.

---

## Architecture

```text
Sources
    ↓
Staging
    ↓
Intermediate
    ↓
Facts & Dimensions
    ↓
Reporting
    ↓
Dashboard Exposure
```

---

## Technologies

- dbt Core
- Snowflake
- SQL
- Git
- GitHub
- GitHub Actions

---

## Business Use Case

This project models a healthcare workflow for identifying patients who require preventive care outreach.

The reporting layer combines care gap status with patient demographics, provider information, care gap reasons, and upcoming appointment details to support care management teams.

Primary reporting outputs include:

- Diabetes A1C Care Gap
- Lead Screening Care Gap
- All Care Gaps
- Care Gaps Due
- Care Gap Outreach Worklist
- Care Gap History

---

## Data Models

### Sources

Synthetic source data representing:

- Patients
- Providers
- Visits
- Appointments
- Laboratory Orders

### Staging

- Data type conversions
- Column renaming
- Basic data cleaning
- Source standardization

### Intermediate

Reusable business logic including:

- Current patient age
- Patient age groups
- Valid patient visits
- Resulted laboratory orders
- Latest laboratory results
- Care gap qualification
- Next appointment logic

### Marts

- Patient Dimension
- Provider Dimension
- Visit Fact
- Appointment Fact
- Laboratory Results Fact

### Reporting

- Latest A1C by Patient
- Latest Lead Screening by Patient
- Diabetes Care Gap
- Lead Screening Care Gap
- All Care Gaps
- Care Gaps Due
- Next Appointment by Patient
- Care Gap Outreach Worklist
- Care Gap History

---

## Project Highlights

- Layered Analytics Engineering architecture using dbt
- Modular SQL models built with dbt `ref()` dependencies
- Dimensional modeling with reusable fact and dimension tables
- Reusable dbt macro for patient age calculation
- Incremental laboratory results model
- Historical snapshots using dbt Snapshots
- Downstream dashboard exposure
- 120+ automated dbt data quality tests
- Automated documentation with dbt Docs
- End-to-end model lineage visualization
- GitHub Actions continuous integration
- Snowflake RSA key-pair authentication for CI
- Version control using Git and GitHub

---

## Continuous Integration

The project includes a GitHub Actions workflow that automatically validates every code push.

The workflow:

1. Installs Python and dbt
2. Creates a temporary dbt profile
3. Authenticates to Snowflake using RSA key-pair authentication
4. Runs `dbt debug`
5. Runs `dbt deps`
6. Runs `dbt parse`
7. Runs `dbt build`

This ensures SQL models, snapshots, tests, and dependencies remain valid throughout development.

---

## dbt Lineage

The project includes fully documented model lineage generated using **dbt Docs**.

![dbt Lineage](images/dbt-lineage.png.jpg)

The lineage graph illustrates how raw healthcare data flows through staging, intermediate transformations, dimensional models, and reporting models to produce business-ready datasets.

---

## Repository Structure

```text
.
├── .github/
│   └── workflows/
├── images/
├── macros/
├── models/
│   ├── staging/
│   ├── intermediate/
│   ├── marts/
│   └── reporting/
├── snapshots/
├── tests/
├── dbt_project.yml
└── README.md
```

---

## Data Quality

The project includes over **120 automated dbt tests**, including:

- Not Null
- Unique
- Accepted Values
- Relationships
- Source Validation
- Business Rule Validation

---

## Data Disclaimer

This portfolio project uses synthetic data created solely for demonstration and educational purposes.

No real patient information, protected health information (PHI), or proprietary employer data is included.