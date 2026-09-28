# Incident Responder Capability Table

| Capability | First responder | Authorization required | Application modification |
|---|---:|---:|---:|
| Read application health | Yes | No | No |
| Read affected order | Yes | No | No |
| Read Prometheus metrics | Yes | No | No |
| Read alert state | Yes | No | No |
| Read recent application logs | Yes | No | No |
| Read Git metadata | Yes | No | No |
| Collect bounded evidence | Yes | No | No |
| Propose remediation | Yes | No | No |
| Modify application source | No | Yes | Yes |
| Modify configuration | No | Yes | Yes |
| Modify database | No | Yes | Yes |
| Change credentials | No | Yes | Yes |
| Deploy unreviewed code | No | Yes | Yes |
| Disable alerts | No | Yes | Yes |
| Disable observability | No | Yes | Yes |
| Execute arbitrary shell commands | No | Yes | Potentially |
| Verify recovery | Yes | According to operational policy | No |
| Prepare escalation packet | Yes | No | No |

## Policy interpretation

The responder can reason over bounded evidence and propose an action.

The responder does not receive unrestricted authority to modify the
application or infrastructure.

Operational remediation must be separately authorized and followed by
recovery verification.