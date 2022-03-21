<script>
import { mapState } from "vuex";

export default {
    name: "ReadComment",
    data() {
        return {
            componentLoaded: false,
            OneComment: '',
            id: '',
        }
    },
    mounted() {
        this.componentLoaded = true;
        this.id = this.$route.params.id;
        if (this.$store.state.user.userId == -1) {
            this.$router.push('/register');
            return;
        }
        this.$store.dispatch('commentId', { id: this.$route.params.id })
        this.$store.dispatch('userProfile')
    },
    computed: {
        ...mapState({
            user: 'profileUser',
            comment: 'commentInfos'
        }),
        comment() {
            if (!this.componentLoaded) {
                return null
            } else {
                return this.$store.state.comment;
            }
        },
    },
    methods:{
        deleteComment(){
            this.$store.dispatch('deleteComment', {id: this.id})
            window.alert('Votre commentaire a bien été supprimer, vous allez être rediriger.')
            this.$router.push('/home')
        },

        goToUpdate(id){
            this.$router.push('/updatecomment/' + id)
        },
        switchStatus() {
            this.$store.dispatch('updateStatusComment', { id: this.id })
            window.alert('Le commentaire a bien été valider.')
            this.$router.push('/home')
        }
    }
}
</script>

<template>
<h4 class="mt-4"> Commentaire à valider</h4>
    <div v-if="componentLoaded === true" class="d-flex card">
        
        <button @click="switchStatus()" type="button" class="btn btn-success btn-sm d-flex">Valider le commentaire</button>
        <p id="commentary__username" class="badge bg-secondary mr-2">{{ comment.User.username }} :</p>
        <div class="dropdown-divider"></div>
        <p class="m-0">{{ comment.comment }}</p>
        
        
        <div v-if="this.$store.state.user.userId === this.comment.userId">
            <span @click="deleteComment()" class="delete__button">
                Supprimer
            </span>
            <span @click="goToUpdate(id)" class="edit__button">
                 Modifier
            </span>
        </div>
    </div>
    <div v-else></div>
</template>

<style lang="scss" scoped>
.d-flex{
    width: 30%;
    margin: 1rem auto auto auto;
    height: auto;
    box-shadow: 10px 5px 5px #c7c7c700;
}
@media (max-width: 768px) { 
    .card{
        width:70%;
    }
    .btn{
        width: 40%;
    }    
}
.delete__button{
    position: absolute;
    top: 25%;
    right: 5%;
    color: rgb(161, 40, 3);
    font-size: 0.8rem;
    cursor: pointer;
        &:hover{
        color: red;
    }
}
.btn{
    width: 20%;
    justify-content: center;
    margin: 1rem;
}
.edit__button{
    position: absolute;
    top: 5%;
    right: 5%;
    font-size: 0.8rem;
    color: rgb(126, 132, 134);
    cursor: pointer;
        &:hover{
        color: rgb(57, 131, 153);
    }
}
#commentary__username{
    width: 4rem;
    margin: 0.5rem;
}
</style>