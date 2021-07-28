namespace: Integrations.hcm202105_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.129
    - target_host_username: root
    - target_host_password:
        default: cloud_1234
        sensitive: true
  workflow:
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_java:
        x: 301
        'y': 78
      install_aos_application:
        x: 619
        'y': 85
        navigate:
          eda14515-6e6c-139d-1887-c198a3d1d34f:
            targetId: 6534c03d-ccd3-fe3f-3f8b-b76684fed43b
            port: SUCCESS
      install_postgres:
        x: 172
        'y': 73
      install_tomcat:
        x: 441
        'y': 79
    results:
      SUCCESS:
        6534c03d-ccd3-fe3f-3f8b-b76684fed43b:
          x: 936
          'y': 72
