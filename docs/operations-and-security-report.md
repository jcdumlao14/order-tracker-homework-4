# Order Tracker Operations and Security Report

## 1. Executive summary

The Order Tracker Homework 4 exercise implemented an observability and
incident-response workflow around a user-impacting order lookup failure.

The workflow connects application metrics to an OpenTelemetry Collector,
Prometheus, Grafana, Loki, and Tempo. A bounded first-responder contract
collects evidence and produces a structured incident assessment before
remediation.

The incident affected the express order `express-1002`.

Before remediation, the lookup returned HTTP 500.

The application logs identified:

`ValueError: day is out of range for month`

The source calculation was:

`placed_at.replace(day=placed_at.day + 2)`

The remediation changed this to:

`placed_at + timedelta(days=2)`

After rebuilding the application, the affected order returned HTTP 200
with:

`estimated_delivery = 2026-09-02`

Prometheus subsequently reported no active five-minute 5xx increase and
the `OrderTrackerLookup5xx` alert was no longer active.

## 2. Observability architecture

The Order Tracker stack uses:

- OpenTelemetry metrics from the application.
- OpenTelemetry Collector as the telemetry receiver.
- Prometheus for metric storage and alert evaluation.
- Grafana for operational visualization.
- Loki and Tempo as supporting observability components.

The application exposes the following operational endpoints:

- `/healthz`
- `/api/orders`
- `/api/orders/{order_id}`

The lookup counter records HTTP status by response code.

The user-impact alert is:

`OrderTrackerLookup5xx`

The alert evaluates whether the five-minute increase in 5xx lookup
responses is greater than zero.

## 3. Incident timeline

### Detection

The express-order lookup produced HTTP 500.

The application health endpoint continued to report:

`{"status":"ok"}`

This demonstrated that service-level health and endpoint-specific user
impact are separate signals.

### Investigation

The responder evidence packet captured:

- health state;
- affected order response;
- Prometheus metrics;
- alert state;
- application logs;
- source context;
- Git metadata.

The responder assessment identified the date calculation as the likely
root cause with high confidence.

### Authorization boundary

The first responder was instructed not to modify source code, database,
configuration, credentials, deployment state, alerts, or observability.

The responder therefore escalated the remediation rather than applying
the fix during investigation.

### Remediation

After the investigation checkpoint and pre-remediation backup, the
application date calculation was changed from direct day replacement to
`timedelta(days=2)` arithmetic.

The application was rebuilt and restarted.

### Recovery verification

The affected express order returned HTTP 200.

The response contained:

`estimated_delivery = 2026-09-02`

The standard order continued to return HTTP 200.

A nonexistent order continued to return HTTP 404.

The health endpoint returned HTTP 200.

Prometheus subsequently showed no active 5xx time series for the
five-minute increase query, and `OrderTrackerLookup5xx` was no longer
active.

## 4. Security controls

The incident-response policy defines a default `propose_only` responder.

The responder is explicitly prohibited from:

- editing application source;
- changing configuration;
- modifying databases;
- changing credentials;
- reading secrets;
- deploying unreviewed code;
- disabling alerts;
- disabling observability;
- executing arbitrary shell commands.

Evidence collection is intended to remain bounded and read-only.

The response schema requires the responder to distinguish evidence,
root cause, confidence, proposed action, autonomy decision, and escalation.

## 5. Auditability

The incident directory preserves:

- the original evidence packet;
- responder assessment;
- pre-remediation source backup;
- recovery verification.

This allows an operator to reconstruct the incident and distinguish
investigation from remediation.

## 6. Operational lessons

A service health check alone cannot establish that every user-facing
operation is healthy.

Endpoint-specific metrics and user-impact alerts provide additional
coverage.

Incident responders should collect evidence before modifying the system.

A model may reason about evidence and recommend a remediation, but the
system should separately control authorization and verify recovery.

## 7. Final status

Application recovery: verified.

Affected express-order lookup: HTTP 200.

Health check: HTTP 200.

Standard order lookup: HTTP 200.

Missing order lookup: HTTP 404.

5xx increase after recovery verification: no active result.

`OrderTrackerLookup5xx`: not active.

Security and autonomy controls: documented.

Incident evidence: preserved.