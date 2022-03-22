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
            },
        });
        // Message d'erreur personnalisé
        //validations
        const rules = computed(() => {
            return {
                user: {
                    username: { required, minLength: helpers.withMessage("Votre nom d'utilisateur est trop court.", minLength(3)) },
                    bio: { required, minLength: helpers.withMessage("Votre bio est trop courte.", minLength(3)) }
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
    },
    methods: {
        logout: function () {
            this.$store.commit("logoutUser");
            this.$router.push("/register");
        },
        update() {
            this.v$.$validate();
            if (this.v$.$error) {
                console.log("Erreur dans l'input");
            }
            else {
                this.$store.dispatch("updateProfile", {
                    username: this.state.user.username,
                    bio: this.state.user.bio,
                });
                window.alert("Compte modifier avec succès, vous allez être rediriger.");
                this.$router.push("/profile");
            }
        },
        deleteProfile() {
            this.$store.dispatch("deleteProfile", {
                id: this.user.id
            });
            this.logout();
        }
    },
}
</script>

<template>
    <div id="error_message" class="mt-3">{{ this.messageError }}</div>
    <div class="container d-flex justify-content-center mt-3">
        <div class="card">
            <div class="top-container">
                <img
                    src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"
                    class="img-fluid profile-image"
                    width="70"
                />

                <form method="update" @submit.prevent="update()">
                    <div>
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
                    <div>
                        <input
                            v-model="state.user.bio"
                            type="bio"
                            class="form-control"
                            id="floatingBio"
                            placeholder="Biographie"
                        />
                        <span class="text-danger" v-if="v$.user.bio.$error">{{ v$.user.bio.$errors[0].$message }}</span>
                    </div>

                    <button type="submit" class="btn btn-success mt-2">Valider vos changements</button>
                    
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
.btn{
    width: 100%;
}
</style>