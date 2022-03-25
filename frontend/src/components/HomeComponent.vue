<script>
import { mapState } from "vuex";
let moment = require('moment')

export default {
    data() {
        return {
            list: [this.$store.dispatch('allPublications')],
            moment:moment,
            post: {
                message: '',
                image: '',
                imageData : "",
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
            if (this.post.message !== '' && this.post.message.length < 240) {
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
        inputPreview(e){
            this.post.image = this.$refs.image.files[0] || e.dataTransfer.files;
            let input = event.target;
            if(input.files && input.files[0]){
                let reader = new FileReader();
                reader.onload = (e) => {
                    this.post.imageData = e.target.result;
                };
                reader.readAsDataURL(input.files[0])
            }
        },
        publicationId(id) {
            this.$router.push('/publications/' + id)
        },
    }

}
</script>
<template>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
</head>
<div class="main--container">
<div id="error_message">{{ this.messageError }}</div>
<div v-if="!validated" class="mt-2">
    <h5
        class="mt-3"
        v-if="this.post.message === ''"
    >Bienvenue sur Groupomania, votre réseau social d'entreprise</h5>
</div>
<div class="container-sm-input d-flex justify-content-center">
    <div class="publication__input m-3 d-flex justify-content-center">
        <form enctype="multipart/form-data" action method="message">
            <div class="container-sm w-100 d-flex flex-row">
                <input
                    v-model="post.message"
                    class="form-control"
                    type="text"
                    placeholder="Votre message"
                    aria-label="Votre message"
                />
                <input
                    class="form-control mt-1"
                    type="file"
                    id="image"
                    name="image"
                    ref="image"
                    accept="image/*"
                    v-on:change="inputPreview()"
                />
                <label for="image">
                    <span class="material-icons">add_photo_alternate</span>
                </label>
            </div>
            <div class="image-preview" id="imagePreview" v-if="post.imageData.length > 0">
                <img :src="post.imageData" alt="Image Preview" class="image-preview__image" />
            </div>
            <button
                class="mt-1 btn btn-sm btn-warning w-auto"
                type="submit"
                @click.prevent="submitPostImage()"
                :class="{ 'disabled': !validated }"
            >Publier votre message</button>
        </form>
    </div>
</div>
<div class="container-sm">
    <div v-for="message in messages" :key="message.id" :message="message" class="card p-2">
        <div class="card-body" @click="publicationId(message.id)">
            <p class="username--card fw-bold align-items-center">
                <img v-if="message.User.avatar !== null"
                    :src="message.User.avatar"
                    class="rounded-circle"
                    width="50"
                    height="50"
                />
                <img v-else src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg" class="img-fluid profile-image" width="50" height="50" >
                {{ message.User.username }} à publié :</p>
            <div class="dropdown-divider"></div>
            <div class="card-text d-flex justify-content-between align-items-md-center flex-column">
                <p class="card-text flex-start fw-bold">{{ message.message }}</p>
            <span>{{ moment(message.createdAt).locale('fr').fromNow() }}</span>

            </div>
        </div>
        <img v-if="message.image !== null" class="card-img-top" alt="..." :src="message.image" />
                    <div class="dropdown-divider"></div>
        <div class="commentary--link mt-1 d-flex justify-content-center fw-bold" @click="publicationId(message.id)"><p>Voir les commentaires</p></div>
    </div>
    
</div>
</div>
</template>
<style lang="scss" scoped>
.card-img-top{
    max-height: 300px;
    max-width: fit-content;
    margin: auto;
}
.img-fluid{
    margin-right: 1rem;
}
.rounded-circle{
    margin-right: 1rem;
}
.image-preview {
    width: 300px;
    min-height: 100px;
    border: 2px solid #dddddd;
    margin-top: 15px;

    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    color: #cccccc;
}
.image-preview__image{
    height: 100%;
    width: 100%;
}
.container-sm {
    display: flex;
    flex-direction: column;
    width: 60%;
    margin-top: 0rem;
}
input[type="file"] {
    display: none;
}
.publication__input > form {
    display: flex;
    flex-direction: column;
}
.commentary--link{
    cursor: pointer;
    &:hover{
        color: #855883;
    }
}
.publication__input {
    width: 38%;
}
.container-sm-input {
    margin: 0 !important;
    width: 100%;
    display: flex;
    align-items: center;
}
.main--container{
    width: 70%;
    background: #eae7e152;
    border: 1px solid #0000003f;
    margin: auto;
    height: 100%;
}
.btn-sm {
    width: 93%;
    background-color: #342c51 !important;
    border: none;
    color: white !important;
}
.card {
    box-shadow: 10px 5px 5px #c7c7c741;
    width: auto;
    margin-bottom: 2rem;
    border: 1px rgba(0, 0, 0, 0.281) solid;
}
.card-body {
    position: relative;
    cursor: pointer;
}
.username--card {
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
    color: white;
    width: fit-content;
    display: flex;
    padding: 0.4rem;
    border-radius: 0.3rem;
    background-color: #342c51;
    margin: auto;
    margin-left: 0.5rem;
    height: 100%;
    border: none;
    &:hover {
        background-color: #865883;
    }
}

@media (max-width: 768px) {
    .container-sm {
        margin: 0;
        width: 100%;
    }
    .card {
        width: 100%;
    }
    .publication__input {
        width: auto;
        margin-bottom: 1rem;
    }
    .username--card{
        width: auto;
    }
}
</style>