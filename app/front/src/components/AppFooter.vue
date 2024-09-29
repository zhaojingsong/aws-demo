<template>
    <footer class="footer">
      <p>
        This website's source code is available at
        <a :href="githubUrl" target="_blank" rel="noopener noreferrer">GitHub</a>
      </p>
    </footer>
  </template>
  
  <script lang="ts">
  import { defineComponent } from 'vue';
  
  export default defineComponent({
    name: 'AppFooter', 
    data() {
      return {
        githubUrl: 'https://github.com/zhaojingsong/aws-demo/' 
      };
    }
  });
  </script>
  
  <style scoped>
  .footer {
    background-color: #f8f9fa;
    padding: 0.4rem;
    text-align: center; /* Center the text horizontally */
    font-size: 13px;
    border-top: 1px solid #e7e7e7;
    position: fixed; /* Ensure the footer sticks to the bottom */
    bottom: 0;
    left: 0;
    right: 0;
  }
  
  .footer a {
    color: #007bff;
    text-decoration: none;
  }
  
  .footer a:hover {
    text-decoration: underline;
  }
  </style>