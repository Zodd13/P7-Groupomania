<script>
import { mapState } from "vuex";

export default {
    name: "ReadPublication",
    data() {
        return {
            componentLoaded: false,
            list: [this.$store.dispatch('allPublications')],
            listComment: '',
            id: '',
            feed: '',
            comment: {
                username: '',
                comments: ''
            }
        }
    },
    mounted() {
        this.componentLoaded = true;
        this.id = this.$route.params.id;
        this.listComment = this.$store.dispatch("allComments", { id: this.$route.params.id })
        if (this.$store.state.user.userId == -1) {
            this.$router.push('/register');
            return;
        }
        this.$store.dispatch('publicationId', { id: this.$route.params.id })
        this.$store.dispatch('userProfile')
    },
    computed: {
        ...mapState({
            user: 'profileUser',
            publication: 'publicationFeed',
            message: 'publicationInfos',
            comment: 'commentInfos'
        }),
        message() {
            if (!this.componentLoaded) {
                return null
            } else {
                return this.$store.state.message;
            }
        },
    },
    methods: {
        goToUpdate(id) {
            this.$router.push('/updatepublication/' + id)
        },
        deletePublication() {
            this.$store.dispatch('deletePublicationAdmin', { id: this.id })
            this.$router.push('/admin')
            window.alert('La publication a bien été supprimer, vous allez être rediriger.')
            
        },
        switchStatus() {
            this.$store.dispatch('updateStatus', { id: this.id })
            this.$router.push('/admin')
            window.alert('La publication a bien été valider, vous allez être rediriger.')
        }
    }
}
</script>
<template>
    <div class="container-sm" v-if="componentLoaded === true">
        <div class="card-body">
            <span class="badge bg-secondary">{{ message.User.username }}</span>
            <div class="dropdown-divider"></div>
            <div class="card-text d-flex justify-content-between align-items-md-center">
                <p class="card-text d-flex flex-start">{{ message.message }}</p>
            </div>
            <span class="message__date">{{ message.createdAt.split('T')[0] }}</span>
        </div>
        <img v-if="message.image !== null" class="card-img-top" alt="..." :src="message.image" />
        <div class="d-flex">
                <button
            @click="switchStatus()"
            type="button"
            class="btn btn-success btn-sm m-1"
        >Valider la publication</button>
        <button @click="deletePublication()" class="btn btn-danger m-1">Supprimer</button>
    </div>    
    </div>
    <div v-else>
        <h1>test</h1>
    </div>
</template>
<style lang="scss" scoped>
.container-sm {
    width: 30%;
    box-shadow: 0 4px 8px 0 rgb(0 0 0 / 20%), 0 6px 20px 0 rgb(0 0 0 / 19%);
    margin-top: 2rem;
    padding: 1rem;
    border-radius: 0.5rem;
}
.message__date {
    font-size: 1rem;
    position: absolute;
    bottom: 5%;
    right: 1%;
}
.card-body {
    position: relative;
    padding: 0;
}
.edit__button {
    position: absolute;
    top: 5%;
    right: 5%;
    font-size: 0.8rem;
    color: rgb(126, 132, 134);
    cursor: pointer;
    &:hover {
        color: rgb(57, 131, 153);
    }
}
.delete__button {
    position: absolute;
    top: 25%;
    right: 5%;
    color: rgb(161, 40, 3);
    font-size: 0.8rem;
    cursor: pointer;
    &:hover {
        color: red;
    }
}
.badge {
    display: flex;
    align-content: flex-start;
    margin: 0.2rem;
    width: fit-content;
}
p.card-text {
    margin: 0.2rem;
}
@media (max-width: 768px) {
    .btn {
        width: 40%;
    }
    .d-flex{
        justify-content: space-evenly;
    }
    .container-sm{
        width: 100% !important;
    }
}
</style>