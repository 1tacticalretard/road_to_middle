# road_to_moddle -- Terraform subrepo

What do we have here is (surprise surprise) my work on Terraform manifests, modules, and related infrastructure stuff.

## Table of contents

* [tests](https://github.com/1tacticalretard/road_to_middle/tree/master/terraform/tests) - basically a folder where test manifests are present. Any sort of novelty comes here and being tested firstly.

* [modules](https://github.com/1tacticalretard/road_to_middle/tree/master/terraform/modules/) - the folder for modules. Currently consists of:
    * [roadtomiddle_aws_networking](https://github.com/1tacticalretard/road_to_middle/tree/master/terraform/modules/roadtomiddle_aws_networking) - a highly customizable, self-written module for creating a simple, yet reliable network configuration for my infrastructure.
* [ha_dr_monitoring](https://github.com/1tacticalretard/road_to_middle/tree/master/terraform/modules/roadtomiddle_aws_networking) - **H**igh **A**vailability, **D**isaster **R**ecovery installation template that comes with CloudWatch **mon**itoring & Classic Load Balancer from box.
* [prometheus](https://github.com/1tacticalretard/road_to_middle/tree/master/terraform/prometheus) - the installation template for Prometheus.
* [webapp_with_hc-vault](https://github.com/1tacticalretard/road_to_middle/tree/master/terraform/webapp_with_hc-vault) - a simple application named [todo-app](https://github.com/harshsinghvi/todo-app) that has HashiCorp Vault integration. Manual MongoDB URI adding to Vault is required.
