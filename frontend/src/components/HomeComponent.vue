<script>
import { mapState } from "vuex";

export default {
    data() {
        return {
            list: [this.$store.dispatch('allPublications')],
            post: {
                message: '',
                image: '',
            },
            messageError: '',
        }
    },
    mounted() {
        this.id = this.$route.params.id;
        if (this.$store.state.user.userId == -1) {
            this.$router.push('/register');
            return;
        }
    },
    computed: {
        validated() {
            if (this.post.message !== '' ) {
                return true;
            } else {
                return false;
            }
        },
        ...mapState({
            publication: 'publicationFeed',
            message: 'publicationInfos',
            comment: 'commentInfos'
        }),
        messages() {
            return this.$store.state.messages;
        },
                comment() {
            if (!this.componentLoaded) {
                return null
            } else {
                return this.$store.state.comment;
            }
        },
        
    },
    methods: {
        getFile() {
            this.post.image = this.$refs.image.files[0];
        },
        submitPostImage() {
            const formData = new FormData;
            formData.append("image", this.post.image);
            formData.append("message", this.post.message);
            if (formData.get("image") === '' && formData.get("message") === '') {
                let messageError = document.getElementById('error_message');
                messageError.classList.add("text-danger");
                this.messageError = "Votre devez nous partager au moins une photo et un message !";
            } else {
                this.$store.dispatch('publicationPost', formData)
                window.alert("Votre publication a bien été poster. Un de nos administrateurs va validé votre poste.")
                window.location.reload()
            }
        },
        publicationId(id) {
            this.$router.push('/publications/' + id)
        },
    }

}
</script>
<template>
    <div id="error_message">{{ this.messageError }}</div>
    <div v-if="!validated" class="mt-2">
        <h5 class="mt-3" v-if="this.post.message === '' ">Bienvenue sur Groupomania, votre réseau social d'entreprise</h5>

    </div>
    <div class="container-sm-input d-flex justify-content-center">
        <div class="publication__input m-3 d-flex justify-content-center flex-column">
            <form enctype="multipart/form-data" action method="message">
                <div class="container-sm w-100 d-flex">
                    <input
                        v-model="post.message"
                        class="form-control"
                        type="text"
                        placeholder="Votre message"
                        aria-label="Votre message"
                    />

                    <label for="image" name="image" class="btn btn-primary mt-3 m-0">
                        Séléctionner une image à partager
                    </label>
                </div>
                <button
                    class="mt-1 btn btn-sm btn-warning w-auto"
                    type="submit"
                    @click.prevent="submitPostImage()"
                    :class="{ 'disabled': !validated }"
                >Publier votre message</button>
                                <input
                    class="form-control m-1 invisible"
                    type="file"
                    id="image"
                    name="image"
                    ref="image"
                    accept="image/*"
                    v-on:change="getFile()"
                />
            </form>
        </div>
    </div>
    <div class="container-sm">
        <div
            v-for="message in messages"
            :key="message.id"
            :message="message"
            class="card p-2"
        >
            <div class="card-body" @click="publicationId(message.id)">
                <span class="badge bg-secondary">{{ message.User.username }}</span>
                <div class="dropdown-divider"></div>
                <div class="card-text d-flex justify-content-between align-items-md-center">
                    <p class="card-text d-flex flex-start">{{ message.message }}</p>
                </div>
                <span class="message__date">{{ message.createdAt.split('T')[0] }}</span>
            </div>
            <img v-if="message.image !== null" class="card-img-top" alt="..." :src="message.image" />
        </div>
    </div>
    
</template>
<style lang="scss" scoped>
.container-sm {
    display: flex;
    flex-direction: column;
    width: 40%;
    margin-top: 0rem;
}   
.publication__input > form{
    height: 7rem;
}
.publication__input{
    width: 38%;
}
.container-sm-input{
    margin: 0 !important;
    width: 100%;
    display: flex;
    align-items: center;
}
.message__date {
    font-size: 1rem;
    position: absolute;
    bottom: 5%;
    right: 1%;
}
.btn-sm{
    width: 93%;
    background-color: #342c51 !important;
    border: none;
    color: white !important;
}
.card {
    box-shadow: 10px 5px 5px #c7c7c700;
    width: auto;
    margin-bottom: 2rem;
    border: 1px rgba(0, 0, 0, 0.055) solid;
}
.card-body {
    position: relative;
    cursor: pointer;
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
label[for="image"],
label[for="image"] {
    background-color: #342c51;
    margin-top: 0.3rem !important;
    height: 100%;
    border: none;
    &:hover {
        background-color: #865883;
    }
}

@media (max-width: 768px) { 
    .container-sm{
        margin: 0;
        width: 100%;
    }
    .card{
        width:100%;
    }
    .publication__input{
        width: auto;
        margin-bottom: 1rem;
    }
 }
</style>