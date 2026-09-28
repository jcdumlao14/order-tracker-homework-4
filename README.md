# Order Tracker — DataTalksClub AI Dev Tools Zoomcamp Homework 4

## Observability, Incident Response, AI-Assisted Investigation, Security Controls, and Recovery Verification

A complete implementation of **DataTalksClub AI Dev Tools Zoomcamp 2026 — Homework 4**, extending the Order Tracker application with production-style observability, incident response, bounded AI investigation, explicit authorization controls, security auditing, remediation, and recovery verification.

---

## 1. Project Overview

This project demonstrates an end-to-end operational workflow for detecting, investigating, remediating, and verifying a user-impacting application incident.

The implementation adds:

* OpenTelemetry instrumentation
* OpenTelemetry Collector
* Prometheus metrics
* Prometheus alerting
* Grafana dashboards
* Loki logging infrastructure
* Tempo tracing infrastructure
* User-impact 5xx detection
* Incident evidence collection
* AI-assisted first-response investigation
* Explicit responder autonomy policies
* Read-only evidence collection
* Structured responder output
* Incident evidence preservation
* Controlled application remediation
* Recovery verification
* Security audit artifacts
* Operational and security documentation
* Automated validation

The central operational principle is:

> **The model may reason; the system must observe, authorize, verify, and remember.**

---

# 2. Homework 4 Objectives

The implementation addresses the major Homework 4 requirements.

### Observability

* Instrument the Order Tracker application.
* Export application metrics using OpenTelemetry.
* Collect telemetry through an OpenTelemetry Collector.
* Expose metrics to Prometheus.
* Visualize telemetry with Grafana.
* Configure user-impact alerting.
* Provide infrastructure for logs and traces.

### Incident Response

* Detect an application failure.
* Preserve evidence before remediation.
* Collect application, metrics, alert, source, and Git evidence.
* Use a bounded AI responder.
* Prevent unauthorized application modifications.
* Produce structured incident assessments.
* Escalate actions outside the responder's authority.
* Verify recovery after remediation.

### Security

* Define explicit responder capabilities.
* Separate investigation from authorization.
* Prevent arbitrary shell execution.
* Prevent secret access.
* Prevent unauthorized source modification.
* Preserve incident evidence.
* Record security findings and dispositions.

---

# 3. Technology Stack

| Technology              | Purpose                              |
| ----------------------- | ------------------------------------ |
| Python                  | Application and automation           |
| FastAPI                 | Order Tracker API                    |
| Uvicorn                 | Application server                   |
| OpenTelemetry           | Application telemetry                |
| OpenTelemetry Collector | Telemetry collection                 |
| Prometheus              | Metrics storage and alert evaluation |
| Grafana                 | Visualization and alert visibility   |
| Loki                    | Log aggregation                      |
| Tempo                   | Distributed tracing                  |
| Docker                  | Containerization                     |
| Docker Compose          | Local orchestration                  |
| pytest                  | Automated testing                    |
| uv                      | Python dependency management         |
| Codex CLI               | AI-assisted incident response        |
| Git                     | Version control                      |
| GitHub                  | Repository and submission            |

---

# 4. Repository

GitHub repository:

**jcdumlao14/order-tracker-homework-4**

Homework branch from the original repository:

```text
homework-4
```

Final validated Homework 4 commit:

```text
63356b16dc093d201ddf9dd1be3172bcdd0a3d29
```

Commit message:

```text
Complete homework 4 observability incident response
```

The standalone repository is based directly on this validated commit.

---

# 5. Repository Structure

```text
order-tracker-homework-4/
│
├── app/
│   ├── main.py
│   └── telemetry.py
│
├── observability/
│   ├── alerts.yaml
│   ├── collector.yaml
│   ├── compose.yaml
│   ├── dashboard.json
│   │
│   ├── grafana/
│   │   └── provisioning/
│   │       ├── dashboards/
│   │       │   └── dashboards.yaml
│   │       └── datasources/
│   │           └── datasources.yaml
│   │
│   ├── loki/
│   │   └── config.yaml
│   │
│   ├── prometheus/
│   │   └── prometheus.yaml
│   │
│   └── tempo/
│       └── tempo.yaml
│
├── incident-response/
│   ├── autonomy-policy.yaml
│   ├── collect-evidence.sh
│   ├── responder-task.md
│   ├── response.schema.json
│   │
│   ├── incidents/
│   │   └── 20260928T032913Z/
│   │       ├── alert-state.txt
│   │       ├── application-logs.txt
│   │       ├── express-1002-response.txt
│   │       ├── git-metadata.txt
│   │       ├── healthz.txt
│   │       ├── manifest.txt
│   │       ├── prometheus-5xx-increase.txt
│   │       ├── prometheus-order-lookup.txt
│   │       ├── source-context.txt
│   │       ├── responder-assessment.json
│   │       │
│   │       ├── pre-remediation/
│   │       │   └── main.py.before-fix
│   │       │
│   │       └── recovery/
│   │           └── recovery-verification.json
│   │
│   └── runbooks/
│       ├── rollback.sh
│       └── verify-recovery.sh
│
├── security-audit/
│   ├── audit-brief.md
│   ├── capability-table.md
│   ├── findings.schema.json
│   └── runs/
│       └── ORDER-TRACKER-SECURITY-001.md
│
├── docs/
│   └── operations-and-security-report.md
│
├── compose.yaml
├── pyproject.toml
├── uv.lock
└── README.md
```

---

# 6. Application

The Order Tracker is a FastAPI service that provides order tracking functionality.

The main application is implemented in:

```text
app/main.py
```

Telemetry setup is implemented in:

```text
app/telemetry.py
```

---

# 7. Health Endpoint

The application exposes:

```text
GET /healthz
```

The expected response is:

```json
{
  "status": "ok"
}
```

The endpoint was verified to return HTTP 200.

The Homework 4 answer is:

```text
{"status":"ok"}
```

---

# 8. Running the Application

The application is containerized using Docker Compose.

The application uses port `18080` locally to avoid conflicts with another local development stack.

Start the application with:

```powershell
$env:ORDER_TRACKER_PORT="18080"
docker compose up --build -d --wait
```

Check the containers:

```powershell
docker compose ps
```

The application should report as healthy.

---

# 9. Health Check

Test the health endpoint:

```powershell
Invoke-RestMethod http://127.0.0.1:18080/healthz
```

Expected result:

```json
{
  "status": "ok"
}
```

---

# 10. Seeded Orders

The application contains seeded orders used for the incident scenario.

Important orders include:

| Order           | Customer | Item         | Priority | Status    | Created    |
| --------------- | -------- | ------------ | -------- | --------- | ---------- |
| `standard-1001` | Avery    | Notebook     | standard | received  | 2026-09-27 |
| `express-1002`  | Sam      | Headphones   | express  | preparing | 2026-08-31 |
| `standard-1003` | Riley    | Water bottle | standard | shipped   | 2026-09-27 |

The affected order was:

```text
express-1002
```

---

# 11. OpenTelemetry Instrumentation

The application uses OpenTelemetry metrics instrumentation.

Telemetry initialization is implemented in:

```text
app/telemetry.py
```

The application reads the OTLP endpoint from:

```text
OTEL_EXPORTER_OTLP_ENDPOINT
```

and identifies itself with:

```text
OTEL_SERVICE_NAME=order-tracker
```

The OpenTelemetry SDK exports metrics using OTLP.

---

# 12. Order Lookup Metric

The primary Homework 4 metric is:

```text
order_lookup_status_total
```

This is a counter recording order lookup responses by HTTP status.

The relevant attribute is:

```text
http_status_code
```

Examples include:

```text
order_lookup_status_total{http_status_code="200"}
order_lookup_status_total{http_status_code="404"}
order_lookup_status_total{http_status_code="500"}
```

This makes endpoint-level user impact observable through the telemetry pipeline.

---

# 13. Observability Architecture

The overall architecture is:

```text
┌──────────────────────┐
│    Order Tracker     │
│       FastAPI        │
└──────────┬───────────┘
           │
           │ OTLP
           ▼
┌──────────────────────┐
│ OpenTelemetry        │
│ Collector             │
└──────────┬───────────┘
           │
           ├──────────► Prometheus
           │
           ├──────────► Loki
           │
           └──────────► Tempo

Prometheus ────────────► Grafana
Loki ──────────────────► Grafana
Tempo ─────────────────► Grafana
```

The architecture separates:

1. Application telemetry generation
2. Telemetry collection
3. Metrics storage
4. Log storage
5. Trace storage
6. Visualization
7. Alert evaluation

---

# 14. Dedicated Observability Ports

The Homework 4 observability stack uses:

| Service                       | Address           |
| ----------------------------- | ----------------- |
| Order Tracker                 | `127.0.0.1:18080` |
| Grafana                       | `127.0.0.1:13000` |
| Loki                          | `127.0.0.1:13100` |
| Tempo                         | `127.0.0.1:13200` |
| OTLP gRPC                     | `127.0.0.1:14317` |
| OTLP HTTP                     | `127.0.0.1:14318` |
| Collector Prometheus exporter | `127.0.0.1:18889` |
| Prometheus                    | `127.0.0.1:19090` |

These ports isolate Homework 4 from other local development environments.

---

# 15. Prometheus

Prometheus configuration:

```text
observability/prometheus/prometheus.yaml
```

Prometheus scrapes the OpenTelemetry Collector's Prometheus exporter.

The collector exposes:

```text
otel-collector:8889
```

Prometheus uses a five-second scrape and evaluation interval.

---

# 16. Grafana

Grafana provisioning is located under:

```text
observability/grafana/provisioning/
```

The dashboard is:

```text
observability/dashboard.json
```

Grafana provides visualization of application and user-impact telemetry.

The Homework 4 alert state was also verified through the Prometheus alert API.

---

# 17. Loki and Tempo

The repository contains configurations for:

```text
observability/loki/config.yaml
```

and:

```text
observability/tempo/tempo.yaml
```

Loki provides the log aggregation component of the observability architecture.

Tempo provides the distributed tracing component.

Together with Prometheus and Grafana, they form the intended observability stack:

```text
Metrics → Prometheus
Logs    → Loki
Traces  → Tempo
UI      → Grafana
```

---

# 18. User-Impact Alert

The primary alert is:

```text
OrderTrackerLookup5xx
```

The alert expression is:

```promql
increase(order_lookup_status_total{http_status_code=~"5.."}[5m]) > 0
```

The alert uses:

```text
for: 10s
```

Labels:

```yaml
severity: critical
impact: user
service: order-tracker
```

This means the alert is specifically associated with an observed user-impacting HTTP 5xx condition.

---

# 19. Incident Scenario

The incident involved:

```text
express-1002
```

Before remediation, looking up this order resulted in:

```text
HTTP 500 Internal Server Error
```

The application log contained:

```text
ValueError: day is out of range for month
```

The affected order was created on:

```text
2026-08-31
```

The original implementation attempted to calculate the delivery date with:

```python
estimated_at = placed_at.replace(day=placed_at.day + 2)
```

For August 31, this attempts to construct an invalid calendar date.

---

# 20. Root Cause

The root cause was an unsafe express-order delivery-date calculation.

The buggy calculation treated the calendar day number as if it could simply be increased without considering month boundaries.

For example:

```text
August 31 + 2 day-number
=
August 33
```

August 33 does not exist.

Python therefore raised:

```text
ValueError: day is out of range for month
```

and the order lookup returned:

```text
HTTP 500
```

---

# 21. Incident Evidence

Evidence was preserved before remediation.

The incident directory is:

```text
incident-response/incidents/20260928T032913Z/
```

It contains:

```text
alert-state.txt
application-logs.txt
express-1002-response.txt
git-metadata.txt
healthz.txt
manifest.txt
prometheus-5xx-increase.txt
prometheus-order-lookup.txt
source-context.txt
responder-assessment.json
```

The pre-remediation source was preserved at:

```text
incident-response/incidents/20260928T032913Z/pre-remediation/main.py.before-fix
```

This allows the original failure state to be reconstructed after remediation.

---

# 22. Incident Response Workflow

The implemented workflow is:

```text
Application failure
       ↓
Telemetry
       ↓
Metric
       ↓
Prometheus alert
       ↓
Evidence collection
       ↓
AI-assisted investigation
       ↓
Autonomy/policy decision
       ↓
Authorization
       ↓
Controlled remediation
       ↓
Recovery verification
       ↓
Security audit
       ↓
Incident record
```

This creates a bounded operational loop rather than allowing an AI agent to directly modify the system without authorization.

---

# 23. AI First Responder

The project uses the Codex CLI as the AI-assisted incident responder.

The responder receives bounded incident evidence and produces a structured assessment according to:

```text
incident-response/response.schema.json
```

The assessment contains:

* Incident ID
* Summary
* Impact
* Evidence
* Root cause
* Confidence
* Proposed action
* Autonomy decision
* Escalation requirement
* Final response line

The responder assessed the incident with:

```text
confidence: high
```

and:

```text
autonomy_decision: escalate
```

with:

```text
escalation_required: true
```

---

# 24. Responder Autonomy Policy

The policy is defined in:

```text
incident-response/autonomy-policy.yaml
```

The default level is:

```text
propose_only
```

The responder is allowed to investigate but is not authorized to modify application source.

---

## Observe Only

Allowed capabilities include:

```text
read_application_health
read_order_status
read_prometheus_metrics
read_alert_state
read_recent_logs
read_git_metadata
```

No system modification is permitted.

---

## Propose Only

The responder can additionally:

```text
propose_remediation
```

but cannot execute the remediation.

---

## Allowed

Only explicitly allowlisted operational actions may be executed.

The project allows:

```text
verify_recovery
```

Application source modification remains prohibited.

---

## Escalate

The responder may:

```text
collect_evidence
prepare_escalation_packet
```

but does not modify the system.

---

# 25. Forbidden Actions

The policy explicitly forbids:

```text
edit_application_source
delete_files
modify_database
change_credentials
read_secrets
deploy_unreviewed_code
disable_alerts
disable_observability
execute_arbitrary_shell_commands
```

This establishes a clear security boundary around AI-assisted operations.

---

# 26. Responder Assessment

The responder concluded that the incident was confirmed for `express-1002`.

The responder proposed that the application owner review and remediate the express-order date calculation.

The responder did not apply the fix because application source modification was outside its authorized autonomy.

The final line of the responder assessment was:

> The incident is confirmed for express-1002; remediation is recommended for owner review and is not authorized under the first-responder policy.

---

# 27. Why the Responder Escalated

The responder was intentionally prevented from directly modifying application source.

This establishes the distinction between:

```text
Diagnosis
```

and:

```text
Authorization
```

The responder could determine:

* what failed
* why it failed
* what remediation should be considered

but it could not independently:

* edit source
* deploy unreviewed code
* modify the database
* execute arbitrary shell commands

The remediation therefore remained separately authorized.

---

# 28. Remediation

The unsafe calculation:

```python
estimated_at = placed_at.replace(day=placed_at.day + 2)
```

was replaced with calendar-safe arithmetic:

```python
estimated_at = placed_at + timedelta(days=2)
```

This correctly handles month boundaries.

For the affected order:

```text
2026-08-31
```

the corrected estimated delivery date is:

```text
2026-09-02
```

---

# 29. Recovery Verification

After remediation, the application was rebuilt successfully.

The affected order was tested again:

```text
GET /api/orders/express-1002
```

The result became:

```text
HTTP 200
```

with:

```json
{
  "id": "express-1002",
  "customer": "Sam",
  "item": "Headphones",
  "priority": "express",
  "status": "preparing",
  "created_at": "2026-08-31T01:24:46.688379+00:00",
  "estimated_delivery": "2026-09-02"
}
```

---

# 30. Post-Recovery Observability

After remediation:

```text
5xx increase over 5 minutes: 0
```

The `OrderTrackerLookup5xx` alert was no longer firing.

The recovery record confirms:

```json
{
  "express_order_recovered": true,
  "five_xx_increase_is_zero": true,
  "alert_is_not_firing": true
}
```

Recovery was therefore verified through both application behavior and observability.

---

# 31. Recovery Runbook

The read-only recovery verification script is:

```text
incident-response/runbooks/verify-recovery.sh
```

It checks:

* Application health
* Affected order lookup
* Recovery state

It does not modify application state.

---

# 32. Rollback Runbook

The rollback artifact is:

```text
incident-response/runbooks/rollback.sh
```

The runbook intentionally does not perform an automatic rollback.

Rollback requires explicit authorization.

This prevents an incident-response agent from performing uncontrolled operational changes.

---

# 33. Security Audit

Security artifacts are stored under:

```text
security-audit/
```

The directory contains:

```text
audit-brief.md
capability-table.md
findings.schema.json
runs/ORDER-TRACKER-SECURITY-001.md
```

The audit addresses:

* Responder permissions
* Evidence collection boundaries
* Application modification restrictions
* Arbitrary command restrictions
* Secret handling
* Recovery verification
* Incident evidence preservation
* Authorization boundaries

---

# 34. Security Findings

The security audit recorded findings covering:

### First-responder modification boundary

The responder is prohibited from modifying application source during first response.

Disposition:

```text
Mitigated
```

### Recovery verification

Recovery is explicitly verified after remediation.

Disposition:

```text
Closed
```

### Incident evidence preservation

Pre-remediation evidence is preserved.

Disposition:

```text
Closed
```

The overall workflow maintains a bounded first-response model with separately authorized remediation.

---

# 35. Operations and Security Report

The consolidated operational report is:

```text
docs/operations-and-security-report.md
```

It documents:

* Deployed application state
* User impact
* Observability evidence
* Alert state
* AI responder assessment
* Proposed remediation
* Authorization boundary
* Remediation
* Recovery verification
* Security controls
* Security findings
* Auditability
* Operational lessons

---

# 36. Automated Testing

The final automated test run produced:

```text
3 passed, 2 warnings
```

The warnings did not represent test failures.

Run the tests with:

```powershell
uv run pytest -q
```

---

# 37. Python Compilation

Application Python compilation was also verified:

```powershell
uv run python -m py_compile .\app\main.py .\app\telemetry.py
```

The compilation check passed.

---

# 38. Dependency Lock Verification

The project uses `uv`.

The lockfile is:

```text
uv.lock
```

The dependency lock state was verified using:

```powershell
uv lock --check
```

---

# 39. Final Validation

The complete Homework 4 validation produced:

```text
ALL VALIDATION CHECKS PASSED
SAFE TO PROCEED TO FINAL REVIEW
```

The validation covered:

1. Correct repository
2. Correct branch
3. Required files
4. JSON validity
5. JSON BOM checks
6. YAML validation
7. Automated tests
8. Python compilation
9. Health endpoint
10. Express-order recovery
11. Standard order lookup
12. Missing-order lookup
13. 5xx recovery
14. Alert recovery
15. Recovery record
16. Responder assessment
17. Calendar-safe remediation
18. Credential-pattern checks
19. Git diff
20. Git status

---

# 40. Homework Questions and Answers

The following answers correspond to the **incident state before remediation**.

## Question 1

**What does the health check return?**

```text
{"status":"ok"}
```

## Question 2

**Which HTTP status code does the metric record for this lookup?**

```text
404
```

## Question 3

**Which HTTP status code does the metric show in Grafana?**

```text
500
```

## Question 4

**What state does Grafana show for the 5xx alert?**

```text
Firing
```

This was the state during the incident checkpoint.

After remediation, the alert was verified to be no longer firing.

## Question 5

**What did the agent respond? Include the last line from its answer.**

```text
The incident is confirmed for express-1002; remediation is recommended for owner review and is not authorized under the first-responder policy.
```

## Question 6

**What was the problem?**

```text
express delivery date calculation tried to use a day that does not exist in that month
```

---

# 41. Incident Timeline

```text
1. Unsafe express delivery calculation exists
                ↓
2. express-1002 lookup fails
                ↓
3. HTTP 500 generated
                ↓
4. OpenTelemetry records the 500
                ↓
5. Prometheus detects the 5xx increase
                ↓
6. OrderTrackerLookup5xx fires
                ↓
7. Incident evidence is collected
                ↓
8. Pre-remediation source is preserved
                ↓
9. AI responder investigates
                ↓
10. Root cause is identified
                ↓
11. Remediation is proposed
                ↓
12. Responder escalates because source modification is prohibited
                ↓
13. Authorized remediation is performed
                ↓
14. Application is rebuilt
                ↓
15. express-1002 returns HTTP 200
                ↓
16. estimated_delivery becomes 2026-09-02
                ↓
17. 5xx increase becomes zero
                ↓
18. Alert stops firing
                ↓
19. Recovery evidence is saved
                ↓
20. Security audit and validation are completed
```

---

# 42. Operational Safety Model

The project separates:

```text
OBSERVE
   ↓
REASON
   ↓
AUTHORIZE
   ↓
ACT
   ↓
VERIFY
   ↓
AUDIT
```

The AI responder primarily performs:

```text
Observe + Reason
```

Authorization is a separate control.

Operational actions must be:

* Bounded
* Allowlisted
* Authorized
* Verifiable
* Auditable

---

# 43. Key Design Principles

## Evidence Before Action

Evidence is preserved before remediation.

## Read-Only First Response

The initial investigation does not modify application source.

## Explicit Authorization

A proposed remediation does not automatically authorize execution.

## Recovery Must Be Verified

A successful rebuild is not sufficient evidence of recovery.

The affected endpoint and telemetry must be checked again.

## Least Privilege

The responder receives only the capabilities associated with its autonomy level.

## Auditability

Incident evidence, responder output, source snapshots, recovery results, and security findings are retained.

---

# 44. Reproducibility

Clone the repository:

```powershell
git clone https://github.com/jcdumlao14/order-tracker-homework-4.git
cd order-tracker-homework-4
```

Start the application:

```powershell
$env:ORDER_TRACKER_PORT="18080"
docker compose up --build -d --wait
```

Check containers:

```powershell
docker compose ps
```

Test health:

```powershell
Invoke-RestMethod http://127.0.0.1:18080/healthz
```

Run tests:

```powershell
uv run pytest -q
```

Compile application code:

```powershell
uv run python -m py_compile .\app\main.py .\app\telemetry.py
```

---

# 45. Git Workflow

The validated Homework 4 implementation originated from:

```text
jcdumlao14/order-tracker
```

on:

```text
homework-4
```

The validated commit was:

```text
63356b16dc093d201ddf9dd1be3172bcdd0a3d29
```

The standalone Homework 4 repository is:

```text
jcdumlao14/order-tracker-homework-4
```

The standalone repository is intended to provide a clean repository containing the completed Homework 4 implementation.

---

# 46. What This Homework Demonstrates

This project demonstrates how an AI-assisted operational workflow can work together with traditional DevOps and security controls.

Instead of:

```text
AI agent
   ↓
Unrestricted shell
   ↓
Production modification
```

the implemented model is:

```text
Application
   ↓
Telemetry
   ↓
Monitoring
   ↓
Alert
   ↓
Bounded Evidence
   ↓
AI Reasoning
   ↓
Policy Decision
   ↓
Authorization
   ↓
Controlled Remediation
   ↓
Recovery Verification
   ↓
Security Audit
```

The AI agent is therefore used as a reasoning and investigation component rather than an unrestricted operator.

---

# 47. Final Status

| Area                     | Status                                |
| ------------------------ | ------------------------------------- |
| Application              | Complete                              |
| OpenTelemetry            | Complete                              |
| Prometheus               | Complete                              |
| Grafana                  | Complete                              |
| Alerting                 | Complete                              |
| Incident evidence        | Preserved                             |
| AI responder             | Complete                              |
| Autonomy policy          | Complete                              |
| Root-cause investigation | Complete                              |
| Remediation              | Complete                              |
| Recovery verification    | Complete                              |
| Security audit           | Complete                              |
| Operations report        | Complete                              |
| Automated tests          | 3 passed                              |
| Final validation         | Passed                                |
| Git commit               | Complete                              |
| GitHub publication       | Complete                             |

---

# 48. Final Conclusion

Homework 4 transforms the Order Tracker application into an observable, auditable, and security-aware operational workflow.

The completed implementation demonstrates:

* Application telemetry
* Metrics collection
* Monitoring
* Alerting
* Incident evidence collection
* Bounded AI investigation
* Explicit autonomy controls
* Controlled remediation
* Recovery verification
* Security auditing
* Operational documentation
* Reproducible validation

The central principle is:

> **The model may reason; the system must observe, authorize, verify, and remember.**

The validated implementation originated from commit:

```text
63356b16dc093d201ddf9dd1be3172bcdd0a3d29
```

and is published as a standalone Homework 4 repository.

**Homework 4 implementation: COMPLETE**
