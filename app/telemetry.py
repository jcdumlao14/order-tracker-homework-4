import os

from opentelemetry import metrics
from opentelemetry.exporter.otlp.proto.grpc.metric_exporter import (
    OTLPMetricExporter,
)
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader
from opentelemetry.sdk.resources import Resource


def setup_metrics():
    endpoint = os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT")

    if not endpoint:
        return None

    resource = Resource.create(
        {
            "service.name": os.getenv(
                "OTEL_SERVICE_NAME",
                "order-tracker",
            ),
        }
    )

    exporter = OTLPMetricExporter(
        endpoint=endpoint,
        insecure=True,
    )

    reader = PeriodicExportingMetricReader(
        exporter,
        export_interval_millis=5000,
    )

    provider = MeterProvider(
        resource=resource,
        metric_readers=[reader],
    )

    metrics.set_meter_provider(provider)

    return metrics.get_meter("order-tracker")