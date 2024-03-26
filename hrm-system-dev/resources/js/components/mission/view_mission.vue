<template>
    <div class="mx-5 mt-4 rounded " style="background-color: #F5F5F5;">
        <div class="pt-2">
            <div class="mx-4 pt-2 d-flex justify-content-between ">
                <p class="mx-3 h3">
                    Mission
                </p>
                <button type="button" class="btn btn-secondary" @click="closePage">Close</button>
            </div>
            <div class="mt-2 bg-secondary mx-4 rounded " style="padding-top: 2px;"></div>
        </div>
        <div v-if="loading" class="vh-100 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
                <span class="visually-hidden  ">Loading...</span>
            </div>
        </div>
        <div v-if="missionDetail">
            <div class="pt-4">
                <div class="d-flex justify-content-between  mx-4 pt-2">
                    <p class="mx-3 h4">
                        Mission Details
                    </p>
                    <div v-if="missionDetail.isApproved === null"
                        class="bg-primary mb-2  text-center px-4 rounded text-white fw-bolder ">
                        <div class="" style="padding-top: 2px;">
                            Pending
                        </div>
                    </div>
                    <div v-else-if="missionDetail.isApproved === 0"
                        class="bg-danger mb-2  text-center px-4 rounded text-white fw-bolder ">
                        <div class="" style="padding-top: 2px;">
                            Rejected
                        </div>
                    </div>
                    <div v-else-if="missionDetail.isApproved === 1"
                        class="bg-success mb-2 text-center px-4 rounded text-white fw-bolder ">
                        <div class="" style="padding-top: 2px;">
                            Approved
                        </div>
                    </div>
                </div>
                <div class="mt-2 bg-secondary mx-4 rounded " style="padding-top: 1px;"></div>
            </div>
            <div class="pt-3">
                <div class="d-flex" style="margin-left: 40px;">
                    <div class="col-md-3 fw-bolder ">
                        Employee Name:
                    </div>
                    <div class="col-md-3 fw-bolder text-secondary ">
                        {{ missionDetail.user.name }}
                    </div>
                    <div class="col-md-3 fw-bolder ">
                        Phone Number:
                    </div>
                    <div class="col-md-4 fw-bolder text-secondary ">
                        096 605 1816
                    </div>
                </div>
                <div class="d-flex mt-4" style="margin-left: 40px;">
                    <div class="col-md-3 fw-bolder ">
                        Mission Title:
                    </div>
                    <div class="col-md-3 fw-bolder text-secondary ">
                        {{ missionDetail.title }}
                    </div>
                    <div class="col-md-3 fw-bolder ">
                        Mission Type:
                    </div>
                    <div class="col-md-4 fw-bolder text-secondary ">
                        {{ missionDetail.mission_type.mission_type }}
                    </div>
                </div>
                <div class="d-flex mt-4" style="margin-left: 40px;">
                    <div class="col-md-3 fw-bolder ">
                        Mission Start:
                    </div>
                    <div class="col-md-3 fw-bolder text-secondary ">
                        {{ formatDate(missionDetail.startDate) }}
                    </div>
                    <div class="col-md-3 fw-bolder ">
                        Mission End:
                    </div>
                    <div class="col-md-4 fw-bolder text-secondary ">
                        {{ formatDate(missionDetail.endDate) }}
                    </div>
                </div>
                <div class="mt-4" style="margin-left: 40px; margin-right: 40px;">
                    <fieldset disabled>
                        <div class="mb-3">
                            <label for="inputOvertime" class="form-label fw-bolder ">Mission Note:</label>
                            <textarea class="form-control border-secondary" v-model="missionDetail.note" placeholder=" "
                                id="floatingTextarea2" style="height: 150px;"></textarea>
                        </div>
                    </fieldset>
                </div>
                <div class="mt-2" style="margin-left: 40px; margin-right: 40px;">
                    <fieldset disabled>
                        <div v-if="missionDetail.isApproved === 1" class="mb-3">
                            <label for="inputOvertime" class="form-label fw-bolder ">Mission Approved Comments:</label>
                            <textarea class="form-control border-secondary " v-model="missionDetail.mission_comment"
                                placeholder=" " id="floatingTextarea2" style="height: 150px;"></textarea>
                        </div>
                        <div v-else-if="missionDetail.isApproved === 0" class="mb-3">
                            <label for="inputOvertime" class="form-label fw-bolder ">Mission Rejected Comments:</label>
                            <textarea class="form-control border-secondary " v-model="missionDetail.mission_comment"
                                placeholder=" " id="floatingTextarea2" style="height: 150px;"></textarea>
                        </div>
                        <div v-else-if="missionDetail.isApproved === null" class="mb-3">
                            <label for="inputOvertime" class="form-label fw-bolder ">Mission Comments:</label>
                            <textarea class="form-control border-secondary " v-model="missionDetail.mission_comment"
                                placeholder=" " id="floatingTextarea2" style="height: 150px;"></textarea>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            missionDetail: null,
            loading: false
        }
    },
    mounted() {
        this.fetchMissionDetail();
    },
    methods: {
        closePage() {
            this.$router.go(-1);
        },
        async fetchMissionDetail() {
            this.loading = true;
            try {
                // Get the employee ID from the query parameters
                const missionId = this.$route.params.id;
                console.log(missionId);
                const token = localStorage.getItem('token');

                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/mission_detail/${missionId}`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                this.missionDetail = response.data.data; // Assign the user data to the component's data property
                console.log(this.missionDetail);
            } catch (error) {
                console.error(error);
            }
            this.loading = false;
        },
        formatDate(dateString) {
            const date = new Date(dateString);
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const formatter = new Intl.DateTimeFormat('en-US', options);
            const parts = formatter.formatToParts(date);
            const formattedDate = `${parts[0].value}, ${parts[4].value} ${parts[2].value} ${parts[3].value} ${parts[6].value}`;
            return formattedDate;
        },
    }
}
</script>

<style></style>

<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';