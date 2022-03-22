<script>
import { mapState } from "vuex";
import ModaleDeleteComponent from "./ModaleDeleteComponent.vue";
export default {
    data() {
        return {
            componentLoaded: false,
            OneUser: "",
            id: "",
            revele:false
        }
        
    },
    mounted() {
        this.componentLoaded = true;
        if (this.$store.state.user.userId == -1) {
            this.$router.push("/register");
            return;
        }
        this.OneUser = this.$store.dispatch("userById", { id: this.$route.params.id });
    },
    computed: {
        ...mapState({
            user: "profileUser",
        }),
        user() {
            if (!this.componentLoaded) {
                return null;
            }
            else {
                return this.$store.state.profileUser;
            }
        },
    },
    methods: {
        deleteProfile() {
            this.$store.dispatch("deleteUser", {
                id: this.$route.params.id
            });
            this.$router.push("/admin");
            window.alert("Compte supprimer avec succès, vous allez être rediriger.");
        },
        toggleModale(){
            this.revele = !this.revele
        }
    },
    components: { ModaleDeleteComponent }
}

</script>


<template>
    <h4 class="mt-4">
        Vous pouvez sur cette page, bannir un utilisateur du site. Attention cette action est
        irréversible.
    </h4>
    <div v-if="componentLoaded === true " class="d-flex justify-content-center card m-auto">
        <p class="badge bg-secondary">
            <span >Pseudo :</span>
            {{ user.customer.username }}
        </p>
        <div class="dropdown-divider"></div>
        <p>{{ user.customer.email }}</p>
    </div>
    <ModaleDeleteComponent v-bind:revele="revele" v-bind:toggleModale="toggleModale" v-bind:deleteProfile="deleteProfile"></ModaleDeleteComponent>
            <div class="btn btn-danger" @click="toggleModale">
            Bannir cet utilisateur
        </div>
</template>

<style lang="scss" scoped>
.badge {
    width: fit-content;
    margin: 0.5rem auto auto auto;
}
.d-flex {
    width: 20%;
}
.btn {
    width: 20%;
}
</style>