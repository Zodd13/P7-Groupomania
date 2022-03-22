<script>
import { mapState } from "vuex";

export default{
    data(){
        return {
            listComment : '',
        }
    },

    mounted(){
        this.componentLoaded = true;
        if (this.$store.state.user.userId == -1 || this.$store.state.user.isAdmin == false) {
            this.$router.push('/register')
            return;
        }
        this.listComment = this.$store.dispatch('allCommentairesAdmin')
        this.$store.dispatch('userProfile')        
    },
    computed:{
        ...mapState({
            user: 'profileUser', comment: 'commentInfos'
        }),
        comments() {
            return this.$store.state.comments;
        },        
    },
    methods:{
        commentId(id){
            this.$router.push('/admincommentaire/' + id)
        },
    }
}
</script>

<template>
    <div v-if="user.isAdmin == true" class="container-sm" id="container__admin">
        <h4>Bienvenue sur la page d'administration</h4>
        <p>Vous verrez ici tout les commentaires en attente de modération.</p>
        <p>Pour valider un commentaire, cliquez d'abord sur la publication puis ensuite sur le bouton valider.</p>
        <p>Vous pouvez si vous jugez que c'est nécessaire, supprimer le commentaire.</p>
    </div>
        <h5 class="mt-3">Commentaire en attente de validation ..</h5>
    <div class="container-sm" v-if="user.isAdmin == true">
        <div
            v-for="comment in comments"
            :key="comment.id"
            :comment="comment"
            class="card p-2"
            style="width: 18rem;"
        >
            <div class="card-body"  @click="commentId(comment.id)">
                <span class="badge bg-secondary">{{ comment.User.username }}</span>
                <div class="dropdown-divider"></div>
                <div class="card-text d-flex justify-content-between align-items-md-center">
                    <p class="card-text d-flex flex-start">{{ comment.comment }}</p>
                    <span class="message__date">{{ comment.createdAt.split('T')[0] }}</span>
                </div>
            </div>
        </div>
    </div>
</template>


<style lang="scss" scoped>
.container-sm{
    width: 30%;
}
.message__date{
    font-size: 1rem;
    position: absolute;
    bottom: 5%;
    right: 1%;
}
.card{
    width: 100% !important;
    font-size: 1.5rem;
    margin-top: 1rem;
}
.card-body{
    position: relative;
    cursor: pointer;
}
.badge{
    display: flex;
    align-content: flex-start;
    margin: 0.2rem;
    width: fit-content;
}
p.card-text{
    margin: 0.2rem;
}
#container__admin{
    width: 60%;
    padding: 0.5rem;
    background-color: #0000000f;
    border-radius: 1rem;
    margin-top: 1rem;
}
@media (max-width: 768px) { 
    .container-sm{
        margin: 0;
        width: 100%;
    }
    .card{
        width:100%;
    }
#container__admin{
    width: auto;
    padding: 0.5rem;
    background-color: #0000000f;
    border-radius: 1rem;
    margin: 1rem;
}
 }
</style>