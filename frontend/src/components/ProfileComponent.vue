<script>
import { mapState } from "vuex";
export default {
    mounted() {
        if(this.$store.state.user.userId == -1){
            this.$router.push('/register')
            return;
        }
        this.$store.dispatch('userProfile')
    },
    computed:{
        ...mapState({user:'profileUser'})
    },
    methods:{
        goToUpdateProfile(){
            this.$router.push('/updateprofile')
        }
    }
}
</script>

<template>
<div class="container d-flex justify-content-center mt-5">
    <div class="card">
        <div class="top-container"> <img src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg" class="img-fluid profile-image" width="70">
            <div class="m-2">
                <h5 class="name">{{ user.username }}</h5>
                <p class="mail"> {{ user.email }}</p>
            </div>
        </div>
        <div class="middle-container d-flex justify-content-between align-items-center mt-3 p-2">
            <div class="d-flex flex-column text-right mr-2"> <span>{{user.bio}}</span> </div>
        </div>
        <button @click="goToUpdateProfile()" type="button" class="btn btn-success btn-sm mt-2">Mettre à jour</button>
    </div>
</div>
</template>

<style scoped>
body {
    background-color: #eee
}

.card {
    background-color: #fff;
    width: 280px;
    border-radius: 0.5rem;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.041), 0 6px 20px 0 rgba(0, 0, 0, 0.075);
    padding: 2rem !important
}

.top-container {
    display: flex;
    align-items: center
}

.name {
    font-size: 15px;
    font-weight: bold;
    color: #272727;
    position: relative;
    top: 8px
}

.mail {
    font-size: 14px;
    color: grey;
    position: relative;
    top: 2px
}

.middle-container {
    background-color: #eee;
    border-radius: 12px
}
</style>