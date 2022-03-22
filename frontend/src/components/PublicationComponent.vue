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
        comments() {
            if (!this.componentLoaded) {
                return null
            } else {
                return this.$store.state.comments;
            }
        }
    },
    methods: {
        goToUpdate(id) {
            this.$router.push('/updatepublication/' + id)
        },
        deletePublication() {
            this.$store.dispatch('deletePublication', { id: this.id })
            window.alert('Votre publication a bien été supprimer, vous allez être rediriger.')
            this.$router.push('/home')
        },
        createComment() {
            this.$store.commit('commentInfos')
            this.$store.dispatch('createComment', {
                id: this.id,
                comment: this.comment.comments,
            })
            window.alert('Votre commentaire a bien été poster, un administrateur va le valider.')
            window.location.reload();
        },
        goToComment(id) {
            this.$router.push("/comments/" + id)
        },
    }
}
</script>
<template>
    <div class="card" v-if="componentLoaded === true">
        <div class="card-body">
            <span class="badge bg-secondary">{{ message.User.username }}</span>
            <span
                @click="goToUpdate(id)"
                class="edit__button"
                v-if="this.$store.state.user.userId === this.message.UserId"
            >Modifier</span>
            <span v-else></span>
            <span
                @click.prevent="deletePublication(id)"
                class="delete__button"
                v-if="this.$store.state.user.userId === this.message.UserId"
            >Supprimer</span>
            <span v-else></span>
            <div class="dropdown-divider"></div>
            <div class="card-text d-flex justify-content-between align-items-md-center">
                <p class="card-text d-flex flex-start">{{ message.message }}</p>
            </div>
            <span class="message__date">{{ message.createdAt.split('T')[0] }}</span>
        </div>
        <img v-if="message.image !== null" class="card-img-top" alt="..." :src="message.image" />
        <div class="dropdown-divider"></div>
        <h6 class="comment__title">Commentaires</h6>
        <div class="cards">
            <input
                v-model="this.comment.comments"
                class="form-control"
                type="text"
                placeholder="Un commentaire ?"
                aria-label="Votre message"
            />
            
            <button
                id="send__button"
                @click="createComment()"
                type="button"
                class="btn btn-secondary"
            >Envoyez</button>
        </div>
        <div
            @click="goToComment(comment.id)"
            class="d-flex"
            id="commentary__list"
            v-for="(comment) in comments"
            :key="comment.id"
        >
            <p id="commentary__username" class="badge bg-secondary mr-2">{{ comment.User.username }} :</p>
            <p class="m-0">{{ comment.comment }}</p>
        </div>
    </div>
    <div v-else>
        <h1>test</h1>
    </div>
</template>
<style lang="scss" scoped>
.comment__title {
    margin-bottom: 0rem;
    margin-top: 0.5rem;
}
.card {
    box-shadow: 10px 5px 5px #c7c7c700;
    width: 30%;
    margin: 1rem auto auto auto;
    width: 30%;
}
#send__button {
    margin: 0.5rem;
}
#commentary__list {
    background-color: rgba(255, 255, 255, 0.685);
    border: 1px solid rgba(0, 0, 0, 0.068);
    margin: 0.8rem;
    align-items: center;
    padding: 0.5rem;
    border-radius: 0.3rem;
    cursor: pointer;
    &:hover {
        transition-timing-function: ease-in;
        transition: 0.1s;
        border: 1.6px solid rgba(0, 0, 0, 0.178);
    }
    #commentary__username {
        margin-right: 1rem;
    }
}
.form-control {
    width: 90%;
    display: flex;
    margin: 0.5rem;
}
.message__date {
    font-size: 1rem;
    position: absolute;
    bottom: 5%;
    right: 1%;
}
.cards {
    display: flex;
    align-items: center;
    width: 100% !important;
    font-size: 1rem;
}
.card-body {
    position: relative;
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
</style>