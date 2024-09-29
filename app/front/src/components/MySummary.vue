<script setup lang="ts">
import IconLinkedIn from './icons/IconLinkedin.vue';

defineProps<{
  name: string
}>()
</script>

<template>
  <div class="greetings">
    <h1 class="green">Jingsong
      <IconLinkedIn />
    </h1>
    <h3>
      Cloud software engineer with a passion for optimizing applications and streamlining processes
    </h3>
  </div>
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
  position: relative;
  top: -10px;
}

h3 {
  font-size: 1.2rem;
}

.greetings h1,
.greetings h3 {
  text-align: center;
}

@media (min-width: 1024px) {

  .greetings h1,
  .greetings h3 {
    text-align: left;
  }
}
</style>
