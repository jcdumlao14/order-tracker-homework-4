# Order Tracker Security Audit Brief

## Scope

This audit covers the Homework 4 Order Tracker incident-response workflow,
including observability, evidence collection, responder behavior, autonomy
controls, recovery verification, and the separation between investigation
and remediation.

## Security objectives

1. Keep first-response investigation read-only.
2. Prevent the responder from modifying application source code.
3. Prevent arbitrary database, credential, configuration, or deployment
   changes during investigation.
4. Preserve bounded and repeatable incident evidence.
5. Require explicit authorization before operational remediation.
6. Verify recovery after an authorized remediation.
7. Preserve an auditable incident record.

## Evidence reviewed

The incident record contains:

- application health evidence;
- the affected order response;
- Prometheus lookup metrics;
- alert state;
- application logs;
- source-code context;
- Git metadata;
- responder assessment;
- pre-remediation application backup;
- post-remediation recovery verification.

## Observed incident

The express order `express-1002` returned HTTP 500 before remediation.

Application logs identified:

`ValueError: day is out of range for month`

The relevant source calculation used:

`placed_at.replace(day=placed_at.day + 2)`

The calculation was changed to calendar-safe timedelta arithmetic:

`placed_at + timedelta(days=2)`

## Security controls

The responder contract prohibits:

- application source modification;
- configuration modification;
- database modification;
- deletion of files;
- credential changes;
- secret access;
- unreviewed deployment;
- disabling alerts;
- disabling observability;
- arbitrary shell execution.

The default responder level is `propose_only`.

## Residual risks

- Shell-based evidence collection depends on the operator invoking the
  allowlisted workflow correctly.
- Human authorization remains necessary for operational changes.
- The repository should continue to protect credentials and other secrets
  through normal source-control and CI security controls.
- Runbooks should be reviewed when deployment architecture changes.

## Disposition

The incident was investigated before remediation.

The application fix was subsequently applied as an explicitly bounded
remediation step outside the first-response investigation.

Recovery was verified through application checks and Prometheus alert state.