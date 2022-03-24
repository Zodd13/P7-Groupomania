<script>
import useValidate from "@vuelidate/core"
import { required, minLength, helpers } from "@vuelidate/validators"
import { reactive, computed } from "vue"
export default {
    setup() {
        // data
        const state = reactive({
            user: {
                username: "",
                bio: "",
                avatar: "",
            },
        });
        // Message d'erreur personnalisé
        //validations
        const rules = computed(() => {
            return {
                user: {
                    username: { required, minLength: helpers.withMessage("Votre nom d'utilisateur est trop court.", minLength(3)) },
                    bio: { minLength: helpers.withMessage("Votre bio est trop courte.", minLength(3)) }
                }
            };
        });
        const v$ = useValidate(rules, state);
        return {
            state,
            v$
        };
    },
    data() {
        return {
            user: {
                id: ""
            },
            messageError: "",
        };
    },
    mounted() {
        if (this.$store.state.user.userId == -1) {
            this.$router.push("/register");
            return;
        }
        this.$store.dispatch("userProfile")
        this.state.user.username = this.$store.state.profileUser.username;
        this.state.user.bio = this.$store.state.profileUser.bio;
        this.state.user.avatar = this.$store.state.profileUser.avatar;
    },
    methods: {
        logout: function () {
            this.$store.commit("logoutUser");
            this.$router.push("/register");
        },
        getFile() {
            this.state.user.avatar = this.$refs.image.files[0];
        },
        update() {
            this.v$.$validate();
            if (this.v$.$error) {
                console.log("Erreur dans l'input")
            } else {
                const formData = new FormData;
                formData.append("image", this.state.user.avatar);
                formData.append("username", this.state.user.username)
                formData.append("bio", this.state.user.bio)
                this.$store.dispatch('updateProfile', formData)
                window.alert("Vos modifications ont été prisent en compte.")
                this.$router.push('/profile')
            }
        },
    },
}
</script>

<template>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <div id="error_message" class="mt-3">{{ this.messageError }}</div>
    <div class="container d-flex justify-content-center mt-3">
        <div class="card">
            <div class="top-container">
                <img
                    v-if="state.user.avatar !== null"
                    :src="state.user.avatar"
                    class="rounded-circle mb-3"
                    alt="Avatar de profile"
                    width="70"
                    height="70"
                />
                <form method="update" @submit.prevent="update()">
                    <div>
                        <span>Photo de profil</span>
                        <label for="image" class="mb-2">
                            <span class="text--profile d-flex m-0 p-2 align-items-center">Séléctionner votre avatar</span>
                            <span
                                class="material-icons ml-0 p-1 d-flex align-items-center"
                            >account_circle</span>
                        </label>
                        <span>Nom d'utilisateur</span>
                        <input
                            v-model="state.user.username"
                            type="bio"
                            class="form-control mb-2"
                            id="floatingBio"
                            placeholder="Pseudo"
                        />
                        <span
                            class="text-danger"
                            v-if="v$.user.username.$error"
                        >{{ v$.user.username.$errors[0].$message }}</span>
                    </div>

                    <!---------- test input avatar -------->

                    <input
                        class="form-control mt-1"
                        type="file"
                        id="image"
                        name="image"
                        ref="image"
                        accept="image/*"
                        v-on:change="getFile()"
                    />

                    <div>
                        <span>Biographie</span>
                        <input
                            v-model="state.user.bio"
                            type="bio"
                            class="form-control"
                            id="floatingBio"
                            placeholder="Biographie"
                        />
                        <span
                            class="text-danger"
                            v-if="v$.user.bio.$error"
                        >{{ v$.user.bio.$errors[0].$message }}</span>
                    </div>

                    <button
                        type="submit"
                        class="btn btn-success mt-2"
                    >Valider vos changements</button>
                </form>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>
body {
    background-color: #eee;
}
.card {
    background-color: #fff;
    width: 280px;
    border-radius: 0.5rem;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    padding: 2rem !important;
}
.text--profile{
    font-size: 0.8rem;
}
.btn {
    width: 100%;
}
input[type="file"] {
    display: none;
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
</style>