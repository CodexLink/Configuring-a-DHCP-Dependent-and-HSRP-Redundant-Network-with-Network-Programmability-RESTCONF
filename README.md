# DevOps `(CPE 028)` Final Case Study

A Final Case Study of DevOps - Application of Network Automation and Programmability, also known as: **Configuring a DHCP-Dependent and Redundant Network with Network Programmability (*RESTCONF*)**

[![Run in Postman](https://run.pstmn.io/button.svg)](https://god.gw.postman.com/run-collection/15624637-ec62310f-f31c-41b4-80af-ac431ffe342e?action=collection%2Ffork&collection-url=entityId%3D15624637-ec62310f-f31c-41b4-80af-ac431ffe342e%26entityType%3Dcollection%26workspaceId%3D1749f222-a6e9-422b-96ef-5fdd04dfd9f5)

## Introduction

This repository (case study) contains the resources needed to accomplish a laboratory activity that utilizes the capabilities of RESTCONF on Cisco Devices equipped with IOS-XE software. This repository also contains the generated outputs produced from the script.

### Host Requirements

When attempting to do this case study, please consider the following:

- Based on the configuration on topology, this requires **16GBs of RAM** or more, for worst case scenario.
- The simulation software used is **GNS 3**.
- The CPU of the host is an **Intel Core i5-10300H @ 2.50Ghz**, please consider this as it may throttle your host machine if attempted and have the lower spec than the provided.

> This case study requires extensive amount of memory. Please adjust accordingly.

### Repository Context

Each folder in this repository contains use-case and its context were categorized.

- ***media/*** — Contains images that is related to this case study.
- ***results/*** — Contains the produced results from running the `run-tests.sh`
- ***restconf/*** — Contains json queries incorporated on a particular configuration and endpoint.

## Final Case Study Context

The following context provides more information about the case study.

### Background / Scenario

As a final requirement for the DevOps (CPE 028), you will be required to configure a topology with RESTCONF under one territory that heavily relies on DHCP servers for addressing, with redundancy added for both DHCP and HSRP, incorporated from one another; and also OSPF as an alternative for IP routing. Default and static configuration are prohibited from this activity.

### Topology

[![Network Topology](https://github.com/CodexLink/devops_final_case_study/blob/latest/media/network_topology.png)](https://github.com/CodexLink/devops_final_case_study)

### Devices in Topology

The topology has the following devices and its configuration:

- **3x** *CSR1000v VM* — Configuration: 2.5GB of RAM, 3x Paravirtualized Network Drivers (virtio-net)
- **3x** *DEVASC-VM* — SideA and SideB ClientN: 512 MB of RAM, Admin Client: 2048 MB, can be lowered.
- **3x** *Ethernet Switch* — With VLANs limited to N of devices connected.

### Pre-configuration

To be documented later. Right after the generation of documentation in Google Docs.

### RESTCONF Overview

To be documented later. Right after the generation of documentation in Google Docs.

### Generation of Test Cases

To be documented later. Right after the generation of documentation in Google Docs.

## Resources

This section contains anything you need from (*unprepared*) demo to documentation, container and so much more. Links are provided without masking to ensure that these do not redirect to potentially dangerous websites.

- Video (Demo) Link: <https://drive.google.com/file/d/1yKpMuaaVJs3mJLk8imrrv1BgD3ZG1A5a/view?usp=sharing>
- Documentation Link: <https://docs.google.com/document/d/e/2PACX-1vQUnIVfRlQKLADVRjS9kmbw7C-X5ZvZMC4H01uRBBXPNZ7ecg7tETqUSVnOFeDGqGiFQ2ik7A_kO5A8/pub>
- Drive Container: <https://drive.google.com/drive/folders/1ElAn947_k8qUFcsax5M4j5FYFqHQO3OW?usp=sharing>

> ! These resources are publicized because I know that this is going to be used for activities which I do not agree despite the case study is labelled to be documented in laboratory activity format. But I herby publish it in a way that it may help people instead.

### Credits

These are the links that helped me throughout the development of the case study. Will fix later under APA format.

- https://docs.gns3.com/docs/using-gns3/advanced/connect-gns3-internet/
- https://herdingpackets.net/2014/02/06/using-the-cisco-csr1000v-in-gns3-with-virtualbox/comment-page-1/
- https://social.technet.microsoft.com/Forums/en-US/a4e5c780-7920-49e0-908f-aee0987ad41b/how-to-install-microsoft-loopback-adapter-on-windows-10?forum=win10itpronetworking
- https://www.gns3.com/community/featured/vbox-same-uuid-error
- https://stackoverflow.com/questions/53687051/ping-google-com-temporary-failure-in-name-resolution
- https://serverfault.com/questions/42799/how-do-i-force-linux-to-reacquire-a-new-ip-address-from-the-dhcp-server
- https://unix.stackexchange.com/questions/29999/why-are-my-two-virtual-machines-getting-the-same-ip-address
- https://unix.stackexchange.com/a/519220
- https://www.cisco.com/c/en/us/td/docs/routers/csr1000/software/configuration/b_CSR1000v_Configuration_Guide/b_CSR1000v_Configuration_Guide_chapter_01010.pdf
- https://gns3.com/community/support/csr1000v-no-interfaces-can-be-found
- https://developer.cisco.com/codeexchange/github/repo/bigevilbeard/Interface_Up_Restconf
- https://www.grandmetric.com/knowledge-base/design_and_configure/static-routing-configuration/
- https://community.cisco.com/t5/switching/question-about-hsrp-and-dhcp/td-p/2343302
- https://www.ripe.net/about-us/press-centre/IPv4CIDRChart_2015.pdf
- https://blogs.cisco.com/developer/pyats-genie-beneath-the-surface
- https://community.cisco.com/t5/networking-documents/ospf-routers-do-not-form-neighbor-relationship-due-to-a-mismatch/ta-p/3131411
