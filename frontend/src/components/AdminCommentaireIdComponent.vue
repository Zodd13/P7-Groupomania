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
    methods: {
        deleteComment() {
            this.$store.dispatch('deleteCommentAdmin', { id: this.id })
            window.alert('Votre commentaire a bien été supprimer.')
            this.$router.push('/admincommentaires')
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
    <h4 class="mt-4">Commentaire à valider</h4>
    <div v-if="componentLoaded === true" class="d-flex card">
        <p class="badge bg-secondary mr-2">Utilisateur : {{ comment.User.username }}</p>
        <div class="dropdown-divider"></div>
        <span class="fw-bold">Commentaire :</span><p class="m-0"> {{ comment.comment }}</p>
    </div>
        <div class="container-sm d-flex">
                <button
            @click="switchStatus()"
            type="button"
            class="btn btn-success btn-sm d-flex"
        >Valider le commentaire</button>
        <button @click="deleteComment()" class="btn btn-danger ml-1">Supprimer</button>
    </div>

</template>

<style lang="scss" scoped>
.d-flex {
    margin: auto;
    height: auto;
    box-shadow: 10px 5px 5px #c7c7c700;
}
.card{
    width: 40%;
}
@media (max-width: 768px) {
    .btn {
        width: 40%;
    }
    .card{
        width: auto;
    }
    .container-sm{
        width: 100% !important;
    }
}
.btn {
    width: 50%;
    justify-content: center;
    align-items: center;
    margin: 1rem;
}
.badge {
    width: fit-content;
    margin: 1rem;
    font-size: 1rem;
    font-weight: 400;
}
.container-sm{
    width: 40%;
}
</style>