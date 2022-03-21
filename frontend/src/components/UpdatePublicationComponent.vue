<script>
export default {
    name: "UpdatePublicationComponent",
    data() {
        return {
            post: {
                message: "",
                id:""
            },
        }
    },
    
    mounted() {
        this.id = this.$route.params.id;
        if (this.$store.state.user.userId == -1) {
            this.$router.push('/register');
            return;
        }
    },

    methods:{
        updatePublication(){
            this.$store.dispatch('updatePublication', {
                id: this.id,
                message: this.post.message,
            })
            window.alert('Message modifier, vous allez être rediriger.')
            this.$router.push('/home')
        },
    }
}
</script>
<template>
     <div class="form-floating pt-5 mt-5 w-50 d-flex flex-column m-auto">
    <div class="d-flex justify-content-center">
      <p> Vous pouvez mettre à jour votre message.</p>
      </div>
    <div class="form-floating mb-1">
      <input v-model="post.message" type="text" class="form-control mb-2" placeholder="Message" />
    </div>
    <button @click="updatePublication()" class="btn btn-outline-primary btn-sm">Mettre à jour</button>
  </div>
</template>
<style>
</style>