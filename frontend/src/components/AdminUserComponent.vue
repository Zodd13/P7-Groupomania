<script>
import { mapState } from "vuex";
    export default {
        data(){
            return {
                usersList: '',
            }
        },
        mounted(){
        if (this.$store.state.user.userId == -1) {
            this.$router.push('/register');
            return;
        }            
        this.usersList = this.$store.dispatch('allUsersAdmin')
        },
        computed:{
           ...mapState({
                user: 'profileUser',
           })
        },
    methods:{
        userId(id){
            this.$router.push('/adminuser/' + id)
        },
    }
}
</script>

<template>
        <h4 class="mt-3"> Vous trouverez ici la liste des utilisateurs du site. Vous pouvez cliquez sur un profil pour le supprimer.</h4>

    <div class="container-sm">
                <div
            v-for="user in user"
            :key="user.id"
            class="card p-2 mb-3"
        >
            <div class="card-body" @click="userId(user.id)">
                <span class="badge bg-secondary">{{ user.username }}</span>
                <div class="dropdown-divider"></div>
                <div class="card-text d-flex justify-content-between align-items-md-center">
                    <p class="card-text d-flex flex-start">{{ user.bio }}</p>
                    <p class="card-text d-flex flex-start">{{ user.email }}</p>
                    <p class="card-text d-flex flex-start">{{ user.status }}</p>
                </div>
            </div>
        </div>
    </div>

</template>

<style lang="scss" scoped>
.card{
    cursor: pointer;
    &:hover{
        transition: ease-in;
        border: 2px solid rgba(0, 0, 0, 0.171);
    }
}
.container-sm{
    width: 30%;
}
</style>
