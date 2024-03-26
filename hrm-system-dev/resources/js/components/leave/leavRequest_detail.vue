<style scoped>
.table-wrapper {
    padding: 20px;
}

.card {
    box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
}

.title-1 {
    display: block !important;
    width: 100%;
}

.title-2 {
    display: block !important;
    width: 100%;
}

.decription-1 {
    display: block !important;
    width: 100%;
}

.decription-2 {
    display: block !important;
    width: 100%;
}

.link-class {
    text-decoration: none;
}

.popup {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.popup-content {
    background-color: white;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    width: 40%;
    display: flex;
    justify-content: center;
    /* Center the form horizontally */
    align-items: center;
    /* Center the form vertically */
    z-index: 10000;
}

.cardHeader h2 {
    text-align: center;
    font-weight: 600;
    color: rgb(0, 108, 81);
    margin-top: 10px;
}

.custom-textarea-height {
    min-height: 150px;
    /* You can adjust this value to change the height */
}

.col-12 {
    text-align: center;
    padding-top: 10px;
}
</style>
<template>
    <div v-if="loading" class="vh-100 d-flex align-items-center justify-content-center">
        <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
            <span class="visually-hidden  ">Loading...</span>
        </div>
    </div>
    <div v-else class="table-wrapper">
        <div v-if="leave_request" class="card mt-3 border-0">
            <div class="cardHeader d-flex justify-content-between align-items-start"
                style="background-color:rgb(0, 108, 81); color: white; border-top-left-radius: 5px; border-top-right-radius: 5px;">
                <div class="row g-0 pt-3">
                    <div class="col-auto">
                        <button @click="closePage" class="btn border-0 d-flex justify-content-center align-items-center"
                            style="color:white;"><i class="fa-solid fa-arrow-left"></i></button>
                    </div>
                    <div class="col">
                        <h4>Leave Request Details</h4>
                    </div>
                </div>
                <div class="pt-3 pe-3">
                    <P>{{ formatDate(leave_request.createdDate) }}</P>
                </div>
            </div>
            <!-- <div class="card-title pb-3 pt-3 border-title align-items-center " style="background-color:rgb(0, 108, 81); color: white; border-top-left-radius: 5px; border-top-right-radius: 5px;">
                <button class="btn border-0 d-flex justify-content-center align-items-center"><i class="fa-solid fa-arrow-left"></i></button>
                <h4>Leave Request Detail</h4></div> -->
            <div class="card-body">
                <div class="pt-3 ps-3 pe-3">
                    <div>
                        <div class="border-bottom d-flex justify-content-around">
                            <div class="title d-flex justify-content-around w-100">
                                <div class="title-1 text-secondary ">
                                    <strong>Leave Request Type:</strong>
                                </div>
                                <div class="decription-1 fw-bolder ">
                                    <p>{{ leave_request.leave_type.leaveType }}</p>
                                </div>
                            </div>
                            <div class="title d-flex justify-content-around w-100">
                                <div class="title-2 text-secondary">
                                    <strong>Request By:</strong>
                                </div>
                                <div class="decription-2 fw-bolder ">
                                    <p>{{ leave_request.employee.name }}</p>
                                </div>
                            </div>
                        </div>
                        <!-- <div class="border-bottom d-flex justify-content-around pt-2 ">
                            <div class="title d-flex justify-content-around w-100">
                                <div class="title-1">
                                    <strong>Phone Number:</strong>
                                </div>
                                <div class="decription-1">
                                    <p>0962383041</p>
                                </div>
                            </div>
                            <div class="title d-flex justify-content-around w-100">
                                <div class="title-2">
                                    <strong>Leave Request Date:</strong>
                                </div>
                                <div class="decription-2">
                                    <p>3/20/2024</p>
                                </div>
                            </div>
                        </div> -->
                        <div class="border-bottom d-flex justify-content-around pt-2 ">
                            <div class="title d-flex justify-content-around w-100">
                                <div class="title-1 text-secondary ">
                                    <strong>Start Date:</strong>
                                </div>
                                <div class="decription-1 fw-bolder ">
                                    <p>{{ formatDate(leave_request.startDate) }}</p>
                                </div>
                            </div>
                            <div class="title d-flex justify-content-around w-100">
                                <div class="title-2 text-secondary ">
                                    <strong>End Date:</strong>
                                </div>
                                <div class="decription-2 fw-bolder ">
                                    <p>{{ formatDate(leave_request.endDate) }}</p>
                                </div>
                            </div>
                        </div>
                        <div class="border-bottom d-flex justify-content-around pt-2 ">
                            <div class="title d-flex justify-content-around w-100">
                                <div class="title-1 text-secondary ">
                                    <strong>Total Day(s):</strong>
                                </div>
                                <div class="decription-1 fw-bolder ">
                                    <p v-if="leave_request.totalDays > 1">{{ leave_request.totalDays }} days</p>
                                    <p v-else>{{ leave_request.totalDays }} day</p>
                                </div>
                            </div>
                            <div class="title d-flex justify-content-around w-100">
                                <div class="title-2 text-secondary ">
                                    <strong> Approved By:</strong>
                                </div>
                                <div class="decription-2 fw-bolder ">
                                    <p v-if="leave_request.approved_by === null"></p>
                                    <p v-else>{{ leave_request.approved_by.name }}</p>
                                </div>
                            </div>
                        </div>
                        <div class="bg-white mt-3 ">
                            <fieldset disabled class="mt-3">
                                <div class="mb-3">
                                    <label for="inputLeave-request" class="form-label title-2 text-secondary">
                                        <strong>Reason</strong></label>
                                    <textarea class="form-control" placeholder=" " id="floatingTextarea2"
                                        style="height: 100px;">{{ leave_request.reason }}</textarea>
                                </div>
                            </fieldset>
                        </div>
                        <div v-if="leave_request.isApproved === 1" class="bg-white mt-3 ">
                            <fieldset disabled class="mt-3">
                                <div class="mb-3">
                                    <label for="inputLeave-request" class="form-label title-2 text-secondary">
                                        <strong>Approve Comments</strong></label>
                                    <textarea class="form-control" placeholder=" " id="floatingTextarea2"
                                        style="height: 100px;">{{ leave_request.leave_comment }}</textarea>
                                </div>
                            </fieldset>
                        </div>
                        <div v-else-if="leave_request.isApproved === 0" class="bg-white mt-3 ">
                            <fieldset disabled class="mt-3">
                                <div class="mb-3">
                                    <label for="inputLeave-request" class="form-label title-2 text-secondary">
                                        <strong>Approve Comments</strong></label>
                                    <textarea class="form-control" placeholder=" " id="floatingTextarea2"
                                        style="height: 100px;">{{ leave_request.leave_comment }}</textarea>
                                </div>
                            </fieldset>
                        </div>
                        <div v-if="leave_request.isApproved === null" class="d-flex mt-5">
                            <div @click="openReject(leave_request)" class="btn p-2 btn-danger"
                                style="width: 50%; border-radius: 1rem 0 0 1rem;">
                                Reject Leave Request
                            </div>
                            <div @click="openApprove(leave_request)" class="btn p-2 btn-success"
                                style="width: 50%; border-radius: 0 1rem 1rem 0;">
                                Approve Leave Request
                            </div>
                        </div>
                        <div v-else-if="leave_request.isApproved === 1" class="d-flex mt-5">
                            <div class="btn p-2 btn-success disabled  "
                                style="width: 100%;border-radius: 1rem 1rem 1rem 1rem;">
                                Approved
                            </div>
                        </div>
                        <div v-else-if="leave_request.isApproved === 0" class="d-flex mt-5">
                            <div class="btn p-2 btn-danger disabled  "
                                style="width: 100%;border-radius: 1rem 1rem 1rem 1rem;">
                                Rejected
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Approve Leave -->
    <div class="popup" v-if="showApproveDialog">
        <div class="popup-content" style="width: 65%;">
            <div class="form-container" style="height: 600px; overflow-y: auto; overflow-x: hidden;">
                <form class="row g-4">
                    <dev class="cardHeader">
                        <h2>Approve Leave Request</h2>
                    </dev>
                    <div class="row justify-content-center align-content-center">
                        <fieldset disabled>
                            <div class="mb-3">
                                <label for="inputLeave-request" class="form-label">Leave Type</label>
                                <input v-model="leave_requestApprove.leave_type.leaveType" class="form-control"
                                    placeholder=" " id="floatingTextarea2"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputLeave-request" class="form-label">Reason</label>
                                <textarea v-model="leave_requestApprove.reason" class="form-control" placeholder=" "
                                    id="floatingTextarea2" style="height: 150px"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="inputLeave-request" class="form-label">Leave Request Date</label>
                                <input v-model="formattedDateLeave" class="form-control" placeholder=" "
                                    id="floatingTextarea2"></input>
                            </div>
                            <div class="d-flex justify-content-between">
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputLeave-request" class="form-label">Start Date</label>
                                    <input v-model="formattedStartDateLeave" class="form-control" placeholder=" "
                                        id="floatingTextarea2"></input>
                                </div>
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputLeave-request" class="form-label">End Date</label>
                                    <input v-model="formattedEndDateLeave" class="form-control" placeholder=" "
                                        id="floatingTextarea2"></input>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="inputLeave-request" class="form-label">Total Days Leave Request</label>
                                <input v-model="leave_requestApprove.totalDays" class="form-control" placeholder=" "
                                    id="floatingTextarea2"></input>
                            </div>
                        </fieldset>
                        <div class="mb-3">
                            <label for="inputLeave-request" class="form-label">Comments</label>
                            <textarea v-model="leave_requestApprove.leave_comment" class="form-control" placeholder=" "
                                id="floatingTextarea2" style="height: 100px" required></textarea>
                            <div v-if="errors.leave_comment" class="text-danger">
                                {{ errors.leave_comment }}
                            </div>
                        </div>
                        <div class="d-flex mt-3 mb-3 ">
                            <div @click="closeApprove" class="btn p-2 btn-danger"
                                style="width: 50%; border-radius: 1rem 0 0 1rem;">
                                Cancel
                            </div>
                            <div @click="confirmApproved(leave_requestApprove.id)" class="btn p-2 btn-success"
                                style="width: 50%; border-radius: 0 1rem 1rem 0;">
                                Approve
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <!-- Reject Leave -->
    <div class="popup" v-if="showRejectDialog">
        <div class="popup-content" style="width: 65%;">
            <div class="form-container" style="height: 600px; overflow-y: auto; overflow-x: hidden">
                <form class="row g-4">
                    <dev class="cardHeader">
                        <h2>Reject Leave Request</h2>
                    </dev>
                    <div class="row justify-content-center align-content-center">
                        <fieldset disabled>
                            <div class="mb-3">
                                <label for="inputLeave-request" class="form-label">Leave Type</label>
                                <input v-model="leave_requestApprove.leave_type.leaveType" class="form-control"
                                    placeholder=" " id="floatingTextarea2"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputLeave-request" class="form-label">Reason</label>
                                <textarea v-model="leave_requestApprove.reason" class="form-control" placeholder=" "
                                    id="floatingTextarea2" style="height: 150px"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="inputLeave-request" class="form-label">Leave Request Date</label>
                                <input v-model="formattedDateLeave" class="form-control" placeholder=" "
                                    id="floatingTextarea2"></input>
                            </div>
                            <div class="d-flex justify-content-between">
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputLeave-request" class="form-label">Start Date</label>
                                    <input v-model="formattedStartDateLeave" class="form-control" placeholder=" "
                                        id="floatingTextarea2"></input>
                                </div>
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputLeave-request" class="form-label">End Date</label>
                                    <input v-model="formattedEndDateLeave" class="form-control" placeholder=" "
                                        id="floatingTextarea2"></input>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="inputLeave-request" class="form-label">Total Days Leave Request</label>
                                <input v-model="leave_requestApprove.totalDays" class="form-control" placeholder=" "
                                    id="floatingTextarea2"></input>
                            </div>
                        </fieldset>
                        <div class="mb-3">
                            <label for="inputLeave-request" class="form-label">Comments</label>
                            <textarea v-model="leave_requestApprove.leave_comment" class="form-control" placeholder=" "
                                id="floatingTextarea2" style="height: 100px" required></textarea>
                            <div v-if="errors.leave_comment" class="text-danger">
                                {{ errors.leave_comment }}
                            </div>
                        </div>
                        <div class="d-flex mt-3 mb-3">
                            <div @click="closeReject" class="btn p-2 btn-danger"
                                style="width: 50%; border-radius: 1rem 0 0 1rem;">
                                Cancel
                            </div>
                            <div @click="confirmRejected(leave_requestApprove.id)" class="btn p-2 btn-success" style="width: 50%; border-radius: 0 1rem 1rem 0;">
                                Reject
                            </div>
                        </div>
                    </div>
                </form>
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
            leave_request: null,
            showApproveDialog: false,
            showRejectDialog: false,
            leave_requestApprove: [],
            loading: false,
            errors: {
                leave_comment: '',
            }
        }
    },
    computed: {
        formattedDateLeave() {
            if (this.leave_requestApprove && this.leave_requestApprove.createdDate) {
                return this.formatDate(this.leave_requestApprove.createdDate);
            } else {
                return '';
            }
        },
        formattedStartDateLeave() {
            if (this.leave_requestApprove && this.leave_requestApprove.startDate) {
                return this.formatDate(this.leave_requestApprove.createdDate);
            } else {
                return '';
            }
        },
        formattedEndDateLeave() {
            if (this.leave_requestApprove && this.leave_requestApprove.endDate) {
                return this.formatDate(this.leave_requestApprove.createdDate);
            } else {
                return '';
            }
        },
    },
    mounted() {
        console.log("Component mounted");
        this.getLeaveRequest();
    },
    methods: {
        async getLeaveRequest() {
            this.loading = true;
            try {
                // Get the employee ID from the query parameters
                const leaveId = this.$route.params.id;
                console.log(leaveId);
                const token = localStorage.getItem('token');

                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/leave_detail/${leaveId}`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                this.leave_request = response.data.data; // Assign the user data to the component's data property
                console.log(this.leave_request);
            } catch (error) {
                console.error(error);
            }
            this.loading = false;
        },
        closePage() {
            this.$router.go(-1);
        },
        openApprove(leave_request) {
            this.showApproveDialog = true;
            this.leave_requestApprove = leave_request;
            console.log(this.leave_requestApprove);
        },
        closeApprove() {
            this.showApproveDialog = false;
            this.leave_requestApprove.leave_comment = '';
            this.errors.leave_comment = '';
        },
        openReject(leave_request) {
            this.showRejectDialog = true;
            this.leave_requestApprove = leave_request;
            console.log(this.leave_requestApprove);
        },
        closeReject() {
            this.showRejectDialog = false
            this.leave_requestApprove.leave_comment = '';
            this.errors.leave_comment = '';
        },
        formatDate(dateString) {
            const date = new Date(dateString);
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const formatter = new Intl.DateTimeFormat('en-US', options);
            const parts = formatter.formatToParts(date);
            const formattedDate = `${parts[0].value}, ${parts[4].value} ${parts[2].value} ${parts[3].value} ${parts[6].value}`;
            return formattedDate;
        },
        async approveLeave(id) {
            try {
                const empId = localStorage.getItem('id');
                const token = localStorage.getItem('token');
                const response = await axios.put(`https://hrm-system-test.up.railway.app/api/leave/approve/${this.leave_requestApprove.id}`, {
                    approvedById: empId,
                    isApproved: true,
                    leave_comment: this.leave_requestApprove.leave_comment,
                }, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                console.log(response.data.data);
                // this.showApproveDialog = false;
                // window.location.reload();
            } catch (error) {
                console.error(error);
            }
        },
        async rejectLeave(id) {
            try {
                const empId = localStorage.getItem('id');
                const token = localStorage.getItem('token');
                const response = await axios.put(`https://hrm-system-test.up.railway.app/api/leave/approve/${this.leave_requestApprove.id}`, {
                    approvedById: empId,
                    isApproved: false,
                    leave_comment: this.leave_requestApprove.leave_comment,
                }, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                console.log(response.data.data);
            } catch (error) {
                console.error(error);
            }
        },
        async confirmApproved(id) {
            try {
                if (!this.leave_requestApprove.leave_comment) {
                    this.errors.leave_comment = 'Comments are required';
                }
                if (this.errors.leave_comment) {
                    return;
                }
                this.showApproveDialog = false;

                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: 'You won\'t be able to change it again!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Approve it!',
                    reverseButtons: true
                });
                if (result.isConfirmed) {
                    await this.approveLeave(id).then(() => {
                        this.getLeaveRequest();
                        Swal.fire({
                            title: 'Approved!',
                            text: 'Leave Request has been Approved.',
                            icon: 'success'
                        });
                    });
                }
            } catch (error) {
                console.error(error);
            }
        },
        async confirmRejected(id) {
            try {
                if (!this.leave_requestApprove.leave_comment) {
                    this.errors.leave_comment = 'Comments are required';
                }
                if (this.errors.leave_comment) {
                    return;
                }
                this.showRejectDialog = false;

                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: 'You won\'t be able to change it again!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Reject it!',
                    reverseButtons: true
                });
                if (result.isConfirmed) {
                    await this.rejectLeave(id).then(() => {
                        this.getLeaveRequest();
                        Swal.fire({
                            title: 'Rejected!',
                            text: 'Leave Request has been Rejected.',
                            icon: 'success'
                        });
                    });
                }
            } catch (error) {
                console.error(error);
            }
        },
    }


};
</script>