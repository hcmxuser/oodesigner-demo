namespace: Integrations.AOS_application
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.121
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
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
          - SUCCESS: install_aos
    - install_aos:
        do:
          io.cloudslang.demo.aos.install_aos:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
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
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 92
        'y': 110
      install_tomcat:
        x: 442
        'y': 115
      install_aos:
        x: 622
        'y': 116
        navigate:
          56ba1e20-a928-f30d-42bb-1a2d3d4dcb72:
            targetId: f63bbb8e-bb04-08d0-1f3a-9b71bf8ca44b
            port: SUCCESS
      install_java:
        x: 270
        'y': 120
    results:
      SUCCESS:
        f63bbb8e-bb04-08d0-1f3a-9b71bf8ca44b:
          x: 770.25
          'y': 97.5078125
