# Copyright (c) 2019  Arista Networks, Inc.  All rights reserved.
# Arista Networks, Inc. Confidential and Proprietary.

FROM openjdk:8-jdk AS builder

COPY . /hadoop-connector
RUN cd hadoop-connector && ./mvnw clean package -DskipTests -Dhadoop.version=3.1.4

FROM openjdk:8-jre-slim as final

COPY --from=builder --chown=1000:1000 /hadoop-connector/gcs/target/gcs-connector-3.0.0-SNAPSHOT-shaded.jar /gcs-connector-shaded.jar
