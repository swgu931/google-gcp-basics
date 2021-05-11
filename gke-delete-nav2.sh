#!/bin/bash


gcloud container clusters delete cloud-nav2 --project=${PROJECT_ID}

gcloud container clusters describe cloud-nav2


gcloud container clusters delete cloud-test --project=${PROJECT_ID}

gcloud container clusters describe cloud-test