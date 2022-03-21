<script>

import { mapState } from "vuex";

export default {
    data() {
        return {
            mode: 'login',
            email: '',
            username: '',
            password: '',
            bio: '',
            messageError:''
        }
        
    },
    mounted(){
        if(this.$store.state.user.userId !== -1){
            this.$router.push('/profile');
            return;
        }
    },
    computed: {
    validated(){
        if (this.mode == 'create'){
            if(this.email !== "" && this.password !== "" && this.username !== ""){
                return true; 
            } else {
                return false;
            }
        } else {
            if(this.email !== "" && this.password !== ""){
                return true;
            } else {
                return false;
            }
        }
    },
    ...mapState(['status'])
    },
    methods: {
        switchSignup() {
            this.mode = 'create';
        },
        switchLogin() {
            this.mode = 'login'
        },
        createAccount() {
            const customer = this;
            this.$store.dispatch('createAccount', {
                email: this.email,
                username: this.username,
                bio: this.bio,
                password: this.password
            })
            .then(function(){
                customer.signIn();
            })
            .catch(function(error){
                console.log(error)
            })
        },
        signIn(){
            const customer = this;
            this.$store.dispatch('signIn', {
                email: this.email,
                password: this.password
            })
            .then(function(response){
                customer.$router.push('/profile');
                console.log(response)
            })
            .catch(function(error){
                console.log(error)
            })
        },
    }
}
</script>
<template>
    <main class="form-signin">
        <form v-on:submit.prevent>
            <h1 v-if="mode == 'login'" class="h3 mb-3 fw-normal"><span v-if="status == 'error_signIn'" class="text-danger fs-5">Votre adresse e-mail ou votre mot de passe est incorrect.</span> <span v-else> Connectez-vous </span></h1>
            <h1 v-else id="error_message" class="h3 mb-3 fw-normal"><span v-if="status == 'error_create'" class="text-danger fs-6 w-75">Veuillez entrez une adresse email valide. Votre mot de passe doit être compris entre 4 et 20 caractères et contenir un chiffre.</span> <span v-else>Inscrivez-vous </span></h1>

            <div class="form-floating">
                <input
                    v-model="email"
                    type="email"
                    class="form-control"
                    id="floatingEmail"
                    placeholder="name@example.com"
                />
                <label for="floatingInput">Adresse e-mail</label>
            </div>

            <div v-if="mode == 'create'" class="form-floating">
                <input
                    v-model="username"
                    type="username"
                    class="form-control"
                    id="floatingUsername"
                    placeholder="Nom d'utilisateur"
                />
                <label for="floatingPassword">Nom d'utilisateur</label>
            </div>

            <div v-if="mode == 'create'" class="form-floating">
                <input
                    v-model="bio"
                    type="bio"
                    class="form-control"
                    id="floatingBio"
                    placeholder="Biographie"
                />
                <label for="floatingPassword">Présentez vous (optionnel)</label>
            </div>

            <div class="form-floating">
                <input
                    v-model="password"
                    type="password"
                    class="form-control"
                    id="floatingPassword"
                    placeholder="Mot de passe"
                />
                <label for="floatingPassword">Mot de passe</label>
            </div>
            <button v-if="mode == 'login'" @click="signIn()" class="w-100 btn btn-lg btn-primary" :class="{'disabled': !validated}" type="submit"><span v-if="status == 'loading'">Connexion en cours ...</span> <span v-else>Connexion</span></button>
            <button v-else @click="createAccount()" class="w-100 btn btn-lg btn-primary" :class="{'disabled': !validated}" type="submit"><span v-if="status == 'loading'">Création en cours ...</span> <span v-else>Créer mon compte</span></button>
            <div class="container">
                <span v-if="mode == 'login'">Tu n'as pas encore de compte ?</span>
                <span v-else>Tu as déjà un compte ?</span>
                <button
                    v-if="mode == 'login'"
                    type="button"
                    class="signin btn btn-sm"
                    @click="switchSignup"
                >
                    Créer un
                    compte
                </button>
                <button
                    v-else
                    type="button"
                    class="m-1 btn btn-warning btn-sm"
                    @click="switchLogin"
                >Connexion</button>
                
            </div>
        </form>
    </main>
</template>

<style scoped>
.btn-primary{
    color: #fff;
    background-color: #0d2163 !important;
    border: none;
}
.form-signin {
    width: 100%;
    max-width: 330px;
    padding: 15px;
    margin: auto;
}

.form-signin {
    font-weight: 400;
}

.form-signin .form-floating:focus-within {
    z-index: 2;
}

.form-signin input[type="email"] {
    margin-bottom: -1px;
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
    margin-bottom: 10px;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
}

#error_message{
    width: 134%;
    display: flex;
}
.signin{
    color: #0d2163a2;
    font-weight: bold;
}
@media (min-width: 768px) {
    .bd-placeholder-img-lg {
        font-size: 3.5rem;
    }
}
</style>