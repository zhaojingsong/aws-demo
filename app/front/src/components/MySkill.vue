<template>
    <div class="skills">
        <h3>Languages</h3>
        <div v-for="(level, language) in languages" :key="language" class="skill-item">
            <span>{{ language }}</span>
            <div class="progress-bar">
                <div class="progress" :style="{ width: level + '%' }" :aria-valuenow="level" aria-valuemin="0"
                    aria-valuemax="100"></div>
            </div>
        </div>

        <h3>Frameworks</h3>
        <div v-for="(level, framework) in frameworks" :key="framework" class="skill-item">
            <span>{{ framework }}</span>
            <div class="progress-bar">
                <div class="progress" :style="{ width: level + '%' }" :aria-valuenow="level" aria-valuemin="0"
                    aria-valuemax="100"></div>
            </div>
        </div>


        <h3>Certifications</h3>
        <div>
            AWS Certified Developer - Associate (2023)
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
    name: "MySkill",
    data() {
        return {
            languages: {
                Java: 80,
                Scala: 60,
                SQL: 60,
                Terraform: 50,
                Python: 50,
                Typescript: 50,
            },
            frameworks: {
                Spring: 70,
                Akka: 75,
                Spark: 60,
                Angular: 50,
                Vuejs: 8,
            },
        };
    },
});
</script>

<style scoped>
.skills {
    max-width: 600px;
    margin: auto;
}

.skill-item {
    margin: 10px 0;
}

h3 {
    font-size: 1.5em;
    line-height: 1.2;
    font-weight: 800;
    margin: 20px 0;
}

.progress-bar {
    background-color: #e0e0e0;
    border-radius: 5px;
    overflow: hidden;
    height: 10px;
}

.progress {
    height: 100%;
    background-color: rgb(100, 123, 113);
    transition: width 0.5s;
}
</style>