<template>
    <div class="table-wrapper">
        <div class="card mt-3 border-0">
            <div class="card-body">
                <h4 class="card-title pb-3" style="color: rgb(0, 108, 81);">Update Emergency Contacts</h4>
                <div class="pt-4">
                    <div class="d-flex align-items-center">
                        <div style="color: rgb(0, 108, 81);">
                            <h5 class="mr-auto">Emergency Contact</h5>
                        </div>
                    </div>
                    <!-- Form inputs -->
                    <form>
                        <div class="row">
                            <div class="col-6">
                                <label for="name" class="form-label">First Name:</label>
                                <input type="text" class="form-control" id="name" v-model="emergencyContact.firstname">
                            </div>
                            <div class="col-6">
                                <label for="nameKh" class="form-label">Last Name:</label>
                                <input type="text" class="form-control" id="nameKh" v-model="emergencyContact.lastname">
                            </div>
                        </div>
                        <div class="row pt-2 ">
                            <div class="col-6">
                                <label for="name" class="form-label">First Name (KH):</label>
                                <input type="text" class="form-control" id="name"
                                    v-model="emergencyContact.firstnameKM">
                            </div>
                            <div class="col-6">
                                <label for="nameKh" class="form-label">Last Name (KH):</label>
                                <input type="text" class="form-control" id="nameKh"
                                    v-model="emergencyContact.lastnameKM">
                            </div>
                        </div>
                        <div class="row pt-2 ">
                            <div class="col-6">
                                <label for="gender" class="form-label">Gender:</label>
                                <select class="form-select" id="gender" v-model="emergencyContact.gender">
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label for="gender" class="form-label">Relative:</label>
                                <select class="form-select" id="gender" v-model="emergencyContact.relative_id">
                                    <option selected disabled>Choose...</option>
                                    <option v-for="relative in relatives" :key="relative.id" :value="relative.id">
                                        {{ relative.relativeName }}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="row pt-2 ">
                            <div class="col-6">
                                <label for="phoneNumber2" class="form-label">Phone Number 1:</label>
                                <input type="text" class="form-control" id="phoneNumber1"
                                    v-model="emergencyContact.phoneNum1">
                            </div>
                            <div class="col-6">
                                <label for="phoneNumber2" class="form-label">Phone Number 2:</label>
                                <input type="text" class="form-control" id="phoneNumber2"
                                    v-model="emergencyContact.phoneNum2">
                            </div>
                        </div>
                        <div class="row pt-2 ">
                            <div class="col-6">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" class="form-control" id="email" v-model="emergencyContact.email">
                            </div>
                            <div class="col-6">
                                <label for="telegram" class="form-label">Telegram Contact:</label>
                                <input type="text" class="form-control" id="telegram"
                                    v-model="emergencyContact.telegram">
                            </div>
                        </div>
                    </form>
                    <div class="d-flex justify-content-between  pt-3 mx-3">
                        <button @click="closeForm" type="button" class="btn btn-danger" style="width: 48%">Cancel</button>
                        <button @click="confirmEditEmergency" type="button" class="btn btn-success" style="width: 48%">Update</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
import Swal from 'sweetalert2';

export default {
    data() {
        return {
            emergencyContact: [],
            relatives: [],
        }
    },
    mounted() {
        console.log("Component mounted");
        this.getEmergencyContact();
        this.getRelative();
    },
    methods: {
        async getEmergencyContact() {
            try {
                // Get the employee ID from the query parameters
                const emergencyId = this.$route.params.id;
                console.log(emergencyId);
                const token = localStorage.getItem('token');

                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/emergencycontact_detail/${emergencyId}`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                this.emergencyContact = response.data.data; // Assign the user data to the component's data property
                console.log(this.emergencyContact);
            } catch (error) {
                console.error(error);
            }
        },
        async getRelative() {
            try {
                const token = localStorage.getItem('token');
                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/relative`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                this.relatives = response.data.data; // Assign the user data to the component's data property
                console.log(this.relatives);
            } catch (error) {
                console.error(error);
            }
        },
        async updateEmergencyContact() {
            try {

                const token = localStorage.getItem('token');

                const response = await axios.put(`https://hrm-system-test.up.railway.app/api/emergencycontact/${this.emergencyContact.id}`, {
                    user_id: this.emergencyContact.user_id,
                    relative_id: this.emergencyContact.relative_id,
                    firstname: this.emergencyContact.firstname,
                    lastname: this.emergencyContact.lastname,
                    firstnameKM: this.emergencyContact.firstnameKM,
                    lastnameKM: this.emergencyContact.lastnameKM,
                    gender: this.emergencyContact.gender,
                    phoneNum1: this.emergencyContact.phoneNum1,
                    phoneNum2: this.emergencyContact.phoneNum2,
                    telegram: this.emergencyContact.telegram,
                    email: this.emergencyContact.email
                }, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                console.log(response.data);
            } catch (error) {
                console.error(error);
            }
        },
        async confirmEditEmergency() {
            try {

                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: 'Do you want Update Emergency Contact?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, I do!',
                    reverseButtons: true
                });

                if (result.isConfirmed) {
                    await this.updateEmergencyContact().finally(() => {
                        this.$router.go(-1);
                        Swal.fire({
                            title: 'Updated!',
                            text: 'Emergency has been Updated.',
                            icon: 'success'
                        });
                    });
                }
            } catch (error) {
                console.error(error);
            }
        },
        closeForm() {
            this.$router.go(-1);
        },
    }
};
</script>

<style scoped>
.table-wrapper {
    padding: 20px;
}

.card {
    box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
    /* Adjust the shadow properties as needed */
    border-radius: 5px;
}

.card-title {
    color: rgb(0, 108, 81);
    border-bottom: 3px solid rgb(0, 108, 81);
    /* You can adjust the color and thickness of the line as needed */
    padding-bottom: 5px;
    /* Optional: Add some space between the text and the line */
}
</style>