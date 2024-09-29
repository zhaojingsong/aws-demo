<template>
    <div class="contact-me">
        <form @submit.prevent="handleSubmit">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" v-model="formData.name" required />
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" v-model="formData.email" required />
            </div>
            <div class="form-group">
                <label for="telephone">Telephone:</label>
                <input type="tel" v-model="formData.telephone" required />
            </div>
            <div class="form-group">
                <label for="message">Message:</label>
                <textarea v-model="formData.message" required></textarea>
            </div>
            <button type="submit" :disabled="isSubmitted">Send</button>
        </form>
        <div v-if="responseMessage" class="response-message">{{ responseMessage }}</div>
    </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import axios from 'axios';

export default defineComponent({
    name: 'ContactMe',
    setup() {
        const formData = ref({
            name: '',
            email: '',
            telephone: '',
            message: ''
        });
        var isSubmitted = ref(false);

        const responseMessage = ref('');

        const handleSubmit = async () => {
            try {
                isSubmitted.value = true
                await axios.post('/prod/api/contact-us', formData.value);
                responseMessage.value = 'Your message has been sent successfully!';
                formData.value = {
                    name: '',
                    email: '',
                    telephone: '',
                    message: ''
                };
            } catch (error) {
                responseMessage.value = 'There was an error sending your message. Please try again.';
                console.error(error);
            }
        };

        return {
            formData,
            handleSubmit,
            responseMessage,
            isSubmitted
        };
    }
});
</script>

<style scoped>
.contact-me {
    max-width: 600px;
    margin: 5% auto;
    padding: 1rem;
    border: 1px solid #ccc;
    border-radius: 8px;
    background-color: #f9f9f9;
}

.form-group {
    margin-bottom: 1rem;
}

label {
    display: block;
    margin-bottom: 0.5rem;
}

input,
textarea {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button {
    padding: 0.5rem 1rem;
    background-color: rgb(100, 123, 113);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:disabled {
    background-color: grey;
    cursor: not-allowed;
}

button:not(:disabled):hover {
    background-color: #0056b3;
}

.response-message {
    margin-top: 1rem;
    font-weight: bold;
}
</style>