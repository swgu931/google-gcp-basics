#!/bin/bash


#PROJECT_ID=lg-cloud-robot-20200731
PROJECT_ID=lg-cloud-robot-20200908

gcloud container clusters delete cloud-nav2 --project=${PROJECT_ID}

gcloud container clusters describe cloud-nav2


gcloud container clusters delete cloud-test --project=${PROJECT_ID}

gcloud container clusters describe cloud-test