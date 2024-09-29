<script setup lang="ts">
import MyExperience from './MyExperience.vue'
import SacemIcon from './icons/IconSacem.vue'
import CgiIcon from './icons/IconCGI.vue'
import ScutIcon from './icons/IconScut.vue'
import PolytechIcon from './icons/IconPolytech.vue'
</script>

<template>
  <MyExperience>
    <template #icon>
      <SacemIcon />
    </template>
    <template #heading>Cloud software engineer</template>
    <template #time>July 2020 - Present</template>
    <div class="experience">
      <p> Transformation of a legacy application into a microservices architecture (
        <span class="weighted">Amazon ECS,SQS,S3, SNS, RDS, Elasticsearch, Java, Spring Boot, Docker</span>)
        to optimize music search, achieving a search throughput of 20,000 lines per second.
      </p>
      <p> Automated management of application autoscaling and Elasticsearch with
        <span class="weighted">Step Functions, Lambda (Python), and CloudWatch</span>
        to ensure optimal performance and efficient resource utilization.
      </p>
      <p> Implementation of monitoring solutions with
        <span class="weighted">Grafana</span> and <span class="weighted">CloudWatch </span>
        to monitor the real-time health of applications and track ongoing processing
      </p>

      <p>Automation of infrastructure management and deployments with
        <span class="weighted">Terraform</span>
      </p>
      <p>Automation of package creation, testing, package publishing, and continuous integration with
        <span class="weighted">GitLab CI/CD</span>
      </p>
      <p> Design and implementation of an
        <span class="weighted">API Gateway</span> to expose and secure access to internal company APIs
      </p>
      <p> Design and development of a <span class="weighted">Spark Scala </span>application to populate the
        Elasticsearch
        database with data exported
        from Dlake</p>
      <p> Design and implementation of a dedicated <span class="weighted">DynamoDB </span>caching system for search
        APIs,
        increasing query processing
        capacity by 300%.</p>
      <p> Design and development of a front-end web application in <span class="weighted">Angular</span> and <span
          class="weighted">TypeScript</span>.</p>
    </div>
  </MyExperience>

  <MyExperience>
    <template #icon>
      <CgiIcon />
    </template>
    <template #heading>Fullstack developper</template>
    <template #time>February 2018 - May 2020</template>

    <div class="experience">
      <p> Development and implementation of REST APIs using
        <span class="weighted">Elasticsearch</span>
        and
        <span class="weighted">Spring Boot</span>
        to generate billing analyses and reports for SFR
      </p>
      <p>
        Creation of an
        <span class="weighted">Angular 8</span>
        web application serving as the prototype dashboard for the future client space to test the APIs.
      </p>
      <p>
        Building
        <span class="weighted">Spring Batch</span>
        applications to populate billing data from CSV files
      </p>
    </div>.
  </MyExperience>

  <MyExperience>
    <template #icon>
      <PolytechIcon />
    </template>
    <template #heading>Polytech Nantes</template>
    <template #time>2016 - 2018</template>
    <div class="experience">
      <p>
        Engineer's Degrees in Networks-System-Cloud
      </p>
    </div>

  </MyExperience>
  <MyExperience>
    <template #icon>
      <ScutIcon />
    </template>
    <template #heading>South China University of Technology </template>
    <template #time>2012 - 2016</template>
    <div class="experience">
      <p>Bachelor's degree in software enginering</p>
    </div>
  </MyExperience>


</template>

<style>
.experience p {
  text-align: justify;
  line-height: 1.6;
  border-left: 1px solid rgba(60, 60, 60, 0.12);
  padding-left: 1em;
  margin-bottom: 0.4em;
}

.experience p .weighted {
  font-weight: 700;
}
</style>