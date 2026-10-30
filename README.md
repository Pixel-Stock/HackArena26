# CI/CD Final Project

A Python Flask sample application with a GitHub Actions CI workflow and an OpenShift Pipelines (Tekton) delivery pipeline.

## Project overview

- **Application:** Flask HTTP service listening on port 8000.
- **Health response:** `SERVICERUNNING`.
- **Quality gates:** Flake8 linting and Nose unit tests.
- **CI:** GitHub Actions in `.github/workflows/workflow.yml`.
- **CD:** Tekton tasks and pipeline definitions in `.tekton/`.
- **Container:** Buildah builds the application image.
- **Deployment:** OpenShift deploys the image and exposes the application on port 8000.

## Run locally

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
flake8 app.py tests
nosetests -v
python app.py
```

Open `http://localhost:8000`. The response should contain `SERVICERUNNING`.

## GitHub Actions

The workflow runs on pushes and pull requests. It installs dependencies, runs Flake8, and executes the Nose test suite.

## OpenShift prerequisites

Create a project in an OpenShift cluster with OpenShift Pipelines installed. The cluster must have the `skills-network-learner` StorageClass and permission to run Buildah and deploy workloads.

Create the 1Gi PVC:

```bash
oc apply -f openshift/pvc.yaml
oc get pvc
```

Apply the Tekton tasks and pipeline:

```bash
oc apply -f .tekton/tasks.yml
oc apply -f .tekton/pipeline.yml
```

Update the image reference in `.tekton/pipeline.yml` to a registry writable by your OpenShift project, then start a PipelineRun using the repository URL and image parameter.

## Important course-environment note

The PVC StorageClass `skills-network-learner` is specific to the course cluster. GitHub Actions can be verified from the repository's Actions tab; the OpenShift PVC, Pipeline, PipelineRun, and application logs must be captured from the actual course cluster. No cluster execution or screenshot is implied by the presence of these manifests.
