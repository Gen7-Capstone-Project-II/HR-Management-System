<template>
    <div v-if="loading" class="d-flex justify-content-center align-items-center text-center" style="height: 80vh;">
        <div class="spinner-border text-secondary " style="width: 3.5rem; height: 3.5rem;" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>
    <div v-else class="table-wrapper">
        <div v-if="announcements" class="announ-tab">
            <div class="title border-bottom d-flex align-content-center "
                style="background-color: white; height: auto; color: rgb(0, 108, 81); border-top-left-radius: 5px; border-top-right-radius: 5px;padding-left: 60px; padding-right: 100px">
                <h4 class="view-title pt-2 ">{{ announcements.title }}</h4>
            </div>
            <div class=" title-detail pt-5"
                style="background-color: white;height: auto;padding-right: 100px;padding-left: 60px;">
                <strong class="h-auto">{{ announcements.description }}
                </strong>
                <!-- <div class="pt-4">
                    <div class="pdf-border border-0 d-flex align-items-center">
                        <div class="pdf ps-2  pt-2 d-flex">
                            <img class="pdf-img" src="../../../public/images/pdf.png" alt="logo Image">
                        </div>
                        <div class="pt-2 d-flex">
                            <p>12-1234duc93-pdf</p>
                        </div>
                    </div>
                </div> -->
            </div>
            <router-link to="/announcement" class="link-class">
                <div class="d-flex mt-3 mb-3 px-5 pb-3">
                    <div class="btn p-2 btn-danger" style="width: 100%; border-radius: 1rem;">
                        Close
                    </div>
                </div>
            </router-link>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            announcements: null,
            loading: false
        }
    },
    mounted() {
        this.getAnnouncementDetail();
    },
    methods: {
        async getAnnouncementDetail() {
            this.loading = true;
            try {
                // Get the employee ID from the query parameters
                const id = this.$route.params.id;
                console.log(id);
                const token = localStorage.getItem('token');

                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/announcement/${id}`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                this.announcements = response.data; // Assign the user data to the component's data property
                console.log(this.announcements);
            } catch (error) {
                console.error(error);
            }
            this.loading = false;
        },
    }
};
</script>

<style scoped>
.table-wrapper {
    padding: 20px;
}

.announ-tab {
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    border-radius: 5px;
}

.title {
    width: 100%;
    padding: 20px;
    /* Add padding to top and bottom for spacing */
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding-right: 20px;
    padding-top: 10px;
}

.pdf-border {
    width: 30%;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    border-radius: 5px;
}

.pdf-img {
    position: relative;
    width: 90px;
    height: 90px;
    cursor: pointer;
    margin-right: 15px;
}

.pdf-img .img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.link-class {
    text-decoration: none;
}

.col-12 {
    text-align: right;
    padding-top: 10px;
}
</style>