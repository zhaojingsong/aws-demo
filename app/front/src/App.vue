<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import MySummary from './components/MySummary.vue'
import AppFooter from './components/AppFooter.vue';
</script>

<template>
  <header>
    <img alt="Vue logo" class="photo" src="@/assets/photo.png" />

    <div class="wrapper">
      <MySummary name="Cloud software engineer" />

      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/skill">Skills</RouterLink>
        <RouterLink to="/contact">Contact</RouterLink>
      </nav>
    </div>
  </header>

  <RouterView />
  <AppFooter/>
</template>

<style scoped>
header {
  line-height: 1.5;
  max-height: 100vh;
}

.photo {
  width: 125px;
  height: 125px;
  margin: auto;
  display: block;
  border-radius: 50%;
  padding: 1%;
}

nav {
  width: 100%;
  font-size: 1.2rem;
  text-align: center;
  margin-top: 2rem;
}

nav a.router-link-exact-active {
  color: var(--color-text);
}

nav a.router-link-exact-active:hover {
  background-color: transparent;
}

nav a {
  display: inline-block;
  padding: 0 1rem;
  border-left: 1px solid var(--color-border);
}

nav a:first-of-type {
  border: 0;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  nav {
    text-align: left;
    margin-left: -1rem;
    font-size: 1rem;

    padding: 1rem 0;
    margin-top: 1rem;
  }
}
</style>
