<template>
    <div>
        <div class="mx-5 mt-4 mb-4 h3">
            Mission
        </div>
        <div class=" mx-4 rounded-3 " style="height: 100px; background-color: #F5F5F5;">
            <div class="d-flex justify-content-evenly">
                <div class="col-md-4 mt-3">
                    <div class="col-md-9">
                        <label for="dateFilter" class="form-label">Date</label>
                        <input type="date" class="form-control" placeholder=" " id="date-filter"
                            @change="handleDateChange">
                    </div>
                </div>
                <div class="col-md-4 m-3">
                    <label for="typeFilter" class="form-label">Mission Type</label>
                    <select class="form-select" v-model="selectedType" placeholder="">
                        <option selected disabled>Choose...</option>
                        <option v-for="missionType in missionTypes" :key="missionType.id" :value="missionType.id">
                            {{ missionType.mission_type }}
                        </option>
                    </select>
                </div>
            </div>
        </div>
        <div class=" m-4">

            <div class=" rounded pt-1 pe-5  pb-4" style="background-color: #F5F5F5;">

                <ul class="rounded  mx-4 p-2 nav nav-tabs mb-2" id="pills-tab" role="tablist"
                    style="width: 70%;background-color: rgb(0, 108, 81);">
                    <li class="nav-item mx-3" role="presentation" @click="fetchMissions('')">
                        <button class="rounded-5 border-0 px-5 nav-link active" id="pills-all-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-all" type="button" role="tab" aria-controls="pills-all"
                            aria-selected="true">
                            <h5 class="pt-2">All</h5>
                        </button>
                    </li>
                    <li class="nav-item mx-3" role="presentation" @click="fetchMissions(null)">
                        <button class="rounded-5 border-0 nav-link px-5" id="pills-pending-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-pending" type="button" role="tab" aria-controls="pills-pending"
                            aria-selected="false"><h5 class="pt-2">Pending</h5></button>
                    </li>
                    <li class="nav-item mx-3" role="presentation" @click="fetchMissions(1)">
                        <button class="rounded-5 border-0  nav-link px-5" id="pills-approved-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-approved" type="button" role="tab" aria-controls="pills-approved"
                            aria-selected="false">
                            <h5 class="pt-2">Approved</h5>
                        </button>
                    </li>
                    <li class="nav-item mx-3" role="presentation" @click="fetchMissions(0)">
                        <button class="rounded-5 border-0  nav-link px-5" id="pills-declined-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-declined" type="button" role="tab" aria-controls="pills-declined"
                            aria-selected="false"><h5 class="pt-2">Declined</h5></button>
                    </li>
                </ul>
                <div class="tab-content" id="pills-tabContent">
                    <!-- All Tab -->
                    <div class="tab-pane fade show active" id="pills-all" role="tabpanel"
                        aria-labelledby="pills-all-tab" tabindex="0">
                        <table class="table table-borderless mx-4">
                            <thead class="table-secondary">
                                <tr class="">
                                    <th scope="col">#</th>
                                    <th scope="col">Employee</th>
                                    <th scope="col">Mission Type</th>
                                    <th scope="col">Created At</th>
                                    <th scope="col">Start Date</th>
                                    <th scope="col">End Date</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody v-if="loading">
                                <tr>
                                    <td colspan="8" class="bg-white" style="text-align:center;">
                                        <div class="spinner-border text-secondary" style="width: 3rem; height: 3rem;"
                                            role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody v-else>
                                <tr class="border-white " v-for="(mission, index) in missions" :key="mission.id">
                                    <th scope="row">{{ index + 1 }}</th>
                                    <td>{{ mission.user.name }}</td>
                                    <td>{{ mission.mission_type.mission_type }}</td>
                                    <td>{{ formatDate(mission.createdDate) }}</td>
                                    <td>{{ formatDateRequest(mission.startDate) }}</td>
                                    <td>{{ formatDateRequest(mission.endDate) }}</td>
                                    <td v-if="mission.isApproved === null">
                                        <div class="bg-warning text-center px-1 rounded text-white fw-bolder ">
                                            Pending
                                        </div>
                                    </td>
                                    <td v-else-if="mission.isApproved === 0">
                                        <div class="bg-danger text-center px-1 rounded text-white fw-bolder ">
                                            Rejected
                                        </div>
                                    </td>
                                    <td v-else-if="mission.isApproved === 1">
                                        <div class="bg-success text-center px-1 rounded text-white fw-bolder ">
                                            Approved
                                        </div>
                                    </td>
                                    <td>
                                        <div class="dropdown-center">
                                            <button class="btn btn-sm dropdown-toggle" type="button"
                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                Actions
                                            </button>
                                            <div v-if="mission.isApproved !== null">
                                                <ul class="dropdown-menu">
                                                    <div @click="viewMissionDatail(mission.id)" class="d-flex mx-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                            fill="currentColor" class="bi bi-eye mt-1 text-success"
                                                            viewBox="0 0 16 16">
                                                            <path
                                                                d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                                            <path
                                                                d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                                        </svg>
                                                        <li><a class="dropdown-item">View</a></li>
                                                    </div>
                                                    <div class="d-flex mx-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                            fill="currentColor"
                                                            class="bi bi-check-circle mt-1 text-primary"
                                                            viewBox="0 0 16 16">
                                                            <path
                                                                d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                            <path
                                                                d="m10.97 4.97-.02.022-3.473 4.425-2.093-2.094a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05" />
                                                        </svg>
                                                        <li><a class="dropdown-item disabled ">Approve</a></li>
                                                    </div>
                                                    <div class="d-flex mx-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                            fill="currentColor" class="bi bi-x-circle mt-1 text-danger"
                                                            viewBox="0 0 16 16">
                                                            <path
                                                                d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                            <path
                                                                d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708" />
                                                        </svg>
                                                        <li><a class="dropdown-item disabled ">Reject</a></li>
                                                    </div>
                                                </ul>
                                            </div>
                                            <div v-else>
                                                <ul class="dropdown-menu">
                                                    <div @click="viewMissionDatail(mission.id)" class="d-flex mx-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                            fill="currentColor" class="bi bi-eye mt-1 text-success"
                                                            viewBox="0 0 16 16">
                                                            <path
                                                                d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                                            <path
                                                                d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                                        </svg>
                                                        <li><a class="dropdown-item">View</a></li>
                                                    </div>
                                                    <div @click="openApprove(mission)" class="d-flex mx-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                            fill="currentColor"
                                                            class="bi bi-check-circle mt-1 text-primary"
                                                            viewBox="0 0 16 16">
                                                            <path
                                                                d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                            <path
                                                                d="m10.97 4.97-.02.022-3.473 4.425-2.093-2.094a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05" />
                                                        </svg>
                                                        <li><a class="dropdown-item">Approve</a></li>
                                                    </div>
                                                    <div @click="openReject(mission)" class="d-flex mx-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                            fill="currentColor" class="bi bi-x-circle mt-1 text-danger"
                                                            viewBox="0 0 16 16">
                                                            <path
                                                                d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                            <path
                                                                d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708" />
                                                        </svg>
                                                        <li><a class="dropdown-item">Reject</a></li>
                                                    </div>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pending Tab -->
                    <div class="tab-pane fade" id="pills-pending" role="tabpanel" aria-labelledby="pills-pending-tab"
                        tabindex="0">
                        <table class="table table-borderless mx-4">
                            <thead class="table-secondary">
                                <tr class="">
                                    <th scope="col">#</th>
                                    <th scope="col">Employee</th>
                                    <th scope="col">Mission Type</th>
                                    <th scope="col">Created At</th>
                                    <th scope="col">Start Date</th>
                                    <th scope="col">End Date</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody v-if="loading">
                                <tr>
                                    <td colspan="8" class="bg-white" style="text-align:center;">
                                        <div class="spinner-border text-secondary" style="width: 3rem; height: 3rem;"
                                            role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody v-else>
                                <tr class="border-white " v-for="(mission, index) in missions" :key="mission.id">
                                    <th scope="row">{{ index + 1 }}</th>
                                    <td>{{ mission.user.name }}</td>
                                    <td>{{ mission.mission_type.mission_type }}</td>
                                    <td>{{ formatDate(mission.createdDate) }}</td>
                                    <td>{{ formatDateRequest(mission.startDate) }}</td>
                                    <td>{{ formatDateRequest(mission.endDate) }}</td>
                                    <td v-if="mission.isApproved === null">
                                        <div class="bg-warning text-center px-1 rounded text-white fw-bolder ">
                                            Pending
                                        </div>
                                    </td>
                                    <td v-else-if="mission.isApproved === 0">
                                        <div class="bg-danger text-center px-1 rounded text-white fw-bolder ">
                                            Rejected
                                        </div>
                                    </td>
                                    <td v-else-if="mission.isApproved === 1">
                                        <div class="bg-success text-center px-1 rounded text-white fw-bolder ">
                                            Approved
                                        </div>
                                    </td>
                                    <td>
                                        <div class="dropdown-center">
                                            <button class="btn btn-sm dropdown-toggle" type="button"
                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                Actions
                                            </button>
                                            <ul class="dropdown-menu">
                                                <div @click="viewMissionDatail(mission.id)" class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-eye mt-1 text-success"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                                        <path
                                                            d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                                    </svg>
                                                    <li><a class="dropdown-item">View</a></li>
                                                </div>
                                                <div @click="openApprove(mission)" class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-check-circle mt-1 text-primary"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                        <path
                                                            d="m10.97 4.97-.02.022-3.473 4.425-2.093-2.094a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05" />
                                                    </svg>
                                                    <li><a class="dropdown-item">Approve</a></li>
                                                </div>
                                                <div @click="openReject(mission)" class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-x-circle mt-1 text-danger"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                        <path
                                                            d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708" />
                                                    </svg>
                                                    <li><a class="dropdown-item">Reject</a></li>
                                                </div>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Approved Tab -->
                    <div class="tab-pane fade" id="pills-approved" role="tabpanel" aria-labelledby="pills-approved-tab"
                        tabindex="0">
                        <table class="table table-borderless mx-4">
                            <thead class="table-secondary">
                                <tr class="">
                                    <th scope="col">#</th>
                                    <th scope="col">Employee</th>
                                    <th scope="col">Mission Type</th>
                                    <th scope="col">Created At</th>
                                    <th scope="col">Start Date</th>
                                    <th scope="col">End Date</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody v-if="loading">
                                <tr>
                                    <td colspan="8" class="bg-white" style="text-align:center;">
                                        <div class="spinner-border text-secondary" style="width: 3rem; height: 3rem;"
                                            role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody v-else>
                                <tr class="border-white " v-for="(mission, index) in missions" :key="mission.id">
                                    <th scope="row">{{ index + 1 }}</th>
                                    <td>{{ mission.user.name }}</td>
                                    <td>{{ mission.mission_type.mission_type }}</td>
                                    <td>{{ formatDate(mission.createdDate) }}</td>
                                    <td>{{ formatDateRequest(mission.startDate) }}</td>
                                    <td>{{ formatDateRequest(mission.endDate) }}</td>
                                    <td v-if="mission.isApproved === null">
                                        <div class="bg-warning text-center px-1 rounded text-white fw-bolder ">
                                            Pending
                                        </div>
                                    </td>
                                    <td v-else-if="mission.isApproved === 0">
                                        <div class="bg-danger text-center px-1 rounded text-white fw-bolder ">
                                            Rejected
                                        </div>
                                    </td>
                                    <td v-else-if="mission.isApproved === 1">
                                        <div class="bg-success text-center px-1 rounded text-white fw-bolder ">
                                            Approved
                                        </div>
                                    </td>
                                    <td>
                                        <div class="dropdown-center">
                                            <button class="btn btn-sm dropdown-toggle" type="button"
                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                Actions
                                            </button>
                                            <ul class="dropdown-menu">
                                                <div @click="viewMissionDatail(mission.id)" class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-eye mt-1 text-success"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                                        <path
                                                            d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                                    </svg>
                                                    <li><a class="dropdown-item">View</a></li>
                                                </div>
                                                <div class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-check-circle mt-1 text-primary"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                        <path
                                                            d="m10.97 4.97-.02.022-3.473 4.425-2.093-2.094a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05" />
                                                    </svg>
                                                    <li><a class="dropdown-item disabled ">Approve</a></li>
                                                </div>
                                                <div class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-x-circle mt-1 text-danger"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                        <path
                                                            d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708" />
                                                    </svg>
                                                    <li><a class="dropdown-item disabled ">Reject</a></li>
                                                </div>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!--  Declined Tab -->
                    <div class="tab-pane fade" id="pills-declined" role="tabpanel" aria-labelledby="pills-declined-tab"
                        tabindex="0">
                        <table class="table table-borderless mx-4">
                            <thead class="table-secondary">
                                <tr class="">
                                    <th scope="col">#</th>
                                    <th scope="col">Employee</th>
                                    <th scope="col">Mission Type</th>
                                    <th scope="col">Created At</th>
                                    <th scope="col">Start Date</th>
                                    <th scope="col">End Date</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody v-if="loading">
                                <tr>
                                    <td colspan="8" class="bg-white" style="text-align:center;">
                                        <div class="spinner-border text-secondary" style="width: 3rem; height: 3rem;"
                                            role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody v-else>
                                <tr class="border-white " v-for="(mission, index) in missions" :key="mission.id">
                                    <th scope="row">{{ index + 1 }}</th>
                                    <td>{{ mission.user.name }}</td>
                                    <td>{{ mission.mission_type.mission_type }}</td>
                                    <td>{{ formatDate(mission.createdDate) }}</td>
                                    <td>{{ formatDateRequest(mission.startDate) }}</td>
                                    <td>{{ formatDateRequest(mission.endDate) }}</td>
                                    <td v-if="mission.isApproved === null">
                                        <div class="bg-warning text-center px-1 rounded text-white fw-bolder ">
                                            Pending
                                        </div>
                                    </td>
                                    <td v-else-if="mission.isApproved === 0">
                                        <div class="bg-danger text-center px-1 rounded text-white fw-bolder ">
                                            Rejected
                                        </div>
                                    </td>
                                    <td v-else-if="mission.isApproved === 1">
                                        <div class="bg-success text-center px-1 rounded text-white fw-bolder ">
                                            Approved
                                        </div>
                                    </td>
                                    <td>
                                        <div class="dropdown-center">
                                            <button class="btn btn-sm dropdown-toggle" type="button"
                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                Actions
                                            </button>
                                            <ul class="dropdown-menu">
                                                <div @click="viewMissionDatail(mission.id)" class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-eye mt-1 text-success"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                                        <path
                                                            d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                                    </svg>
                                                    <li><a class="dropdown-item">View</a></li>
                                                </div>
                                                <div class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-check-circle mt-1 text-primary"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                        <path
                                                            d="m10.97 4.97-.02.022-3.473 4.425-2.093-2.094a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05" />
                                                    </svg>
                                                    <li><a class="dropdown-item disabled ">Approve</a></li>
                                                </div>
                                                <div class="d-flex mx-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                                                        fill="currentColor" class="bi bi-x-circle mt-1 text-danger"
                                                        viewBox="0 0 16 16">
                                                        <path
                                                            d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                        <path
                                                            d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708" />
                                                    </svg>
                                                    <li><a class="dropdown-item disabled ">Reject</a></li>
                                                </div>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Approve Mission -->
    <div class="popup" v-if="showApproveDialog">
        <div class="popup-content" style="width: 65%;">
            <div class="form-container" style="height: 600px; overflow-y: auto;">
                <form class="row g-4">
                    <div class="cardHeader">
                        <h2 class="mt-2">Approve Mission</h2>
                        <div class="bg-secondary rounded-2" style="padding-top: 2px;"></div>
                    </div>

                    <div class="mt-2 row justify-content-center align-content-center">
                        <fieldset disabled>
                            <div class="mb-3">
                                <label for="inputMissionTitle" class="form-label">Employee Requested</label>
                                <input class="form-control" placeholder=" " v-model="missionApprove.user.name"
                                    id="floatingTextarea2"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputMissionTitle" class="form-label">Mission Title</label>
                                <input class="form-control" placeholder=" " v-model="missionApprove.title"
                                    id="floatingTextarea2"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputMissionType" class="form-label">Mission Type</label>
                                <input class="form-control" placeholder=" "
                                    v-model="missionApprove.mission_type.mission_type" id="floatingTextarea2"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputMissionCreatedDate" class="form-label">Mission Created Date</label>
                                <input class="form-control" placeholder=" " v-model="formattedDateMission"
                                    id="floatingTextarea2"></input>
                            </div>
                            <div class="d-flex justify-content-between">
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputMissionStartFrom" class="form-label">Mission Start Date</label>
                                    <input class="form-control" placeholder=" " v-model="formattedStartDateMission"
                                        id="floatingTextarea2"></input>
                                </div>
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputMissionEndTo" class="form-label">Mission End Date</label>
                                    <input class="form-control" placeholder=" " v-model="formattedEndDateMission"
                                        id="floatingTextarea2"></input>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Mission Note</label>
                                <textarea class="form-control" placeholder=" " v-model="missionApprove.note"
                                    id="floatingTextarea2" style="height: 100px"></textarea>
                            </div>
                        </fieldset>
                        <div class="mb-3">
                            <label for="inputOvertime" class="form-label">Mission Approve Comments</label>
                            <textarea class="form-control" placeholder=" " v-model="missionApprove.mission_comment"
                                id="floatingTextarea2" style="height: 150px" required></textarea>
                            <div v-if="errors.mission_comment" class="text-danger">
                                {{ errors.mission_comment }}
                            </div>
                        </div>
                    </div>
                    <div class="d-flex mt-3 mb-3 ">
                        <div @click="closeApprove" class="btn p-2 btn-danger"
                            style="width: 50%; border-radius: 1rem 0 0 1rem;">
                            Cancel
                        </div>
                        <div @click="confirmApproved(missionApprove.id)" class="btn p-2 btn-success" style="width: 50%; border-radius: 0 1rem 1rem 0;">
                            Approve
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Reject Mission -->
    <div class="popup" v-if="showRejectDialog">
        <div class="popup-content" style="width: 65%;">
            <div class="form-container" style="height: 600px; overflow-y: auto;">
                <form class="row g-4">
                    <div class="cardHeader">
                        <h2 class="mt-2">Reject Mission</h2>
                        <div class="bg-secondary rounded-2" style="padding-top: 2px;"></div>
                    </div>

                    <div class="mt-2 row justify-content-center align-content-center">
                        <fieldset disabled>
                            <div class="mb-3">
                                <label for="inputMissionTitle" class="form-label">Employee Requested</label>
                                <input class="form-control" placeholder=" " v-model="missionReject.user.name"
                                    id="floatingTextarea2"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputMissionTitle" class="form-label">Mission Title</label>
                                <input class="form-control" placeholder=" " v-model="missionReject.title"
                                    id="floatingTextarea2"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputMissionType" class="form-label">Mission Type</label>
                                <input class="form-control" placeholder=" "
                                    v-model="missionReject.mission_type.mission_type" id="floatingTextarea2"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputMissionCreatedDate" class="form-label">Mission Created Date</label>
                                <input class="form-control" placeholder=" " v-model="formattedDateMission"
                                    id="floatingTextarea2"></input>
                            </div>
                            <div class="d-flex justify-content-between">
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputMissionStartFrom" class="form-label">Mission Start Date</label>
                                    <input class="form-control" placeholder=" " v-model="formattedStartDateMission"
                                        id="floatingTextarea2"></input>
                                </div>
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputMissionEndTo" class="form-label">Mission End Date</label>
                                    <input class="form-control" placeholder=" " v-model="formattedEndDateMission"
                                        id="floatingTextarea2"></input>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Mission Note</label>
                                <textarea class="form-control" placeholder=" " v-model="missionReject.note"
                                    id="floatingTextarea2" style="height: 100px"></textarea>
                            </div>
                        </fieldset>
                        <div class="mb-3">
                            <label for="inputOvertime" class="form-label">Mission Approve Comments</label>
                            <textarea class="form-control" placeholder=" " v-model="missionReject.mission_comment"
                                id="floatingTextarea2" style="height: 150px" required></textarea>
                            <div v-if="errors.mission_comment" class="text-danger">
                                {{ errors.mission_comment }}
                            </div>
                        </div>
                    </div>
                    <div class="d-flex mt-3 mb-3 ">
                        <div @click="closeReject" class="btn p-2 btn-danger"
                            style="width: 50%; border-radius: 1rem 0 0 1rem;">
                            Cancel
                        </div>
                        <div @click="confirmRejected(missionReject.id)" class="btn p-2 btn-success" style="width: 50%; border-radius: 0 1rem 1rem 0;">
                            Reject
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
            loading: false,
            missions: [],
            selectedDate: null,
            selectedType: '',
            missionTypes: [],
            showApproveDialog: false,
            showRejectDialog: false,
            missionApprove: [],
            missionReject: [],
            errors: {
                mission_comment: '',
            }
        }
    },
    mounted() {
        console.log("Component mounted");
        this.fetchMissions('');
        this.fetchMissionTypes();
    },
    watch: {
        selectedType: async function () {
            await this.fetchMissionWithType(this.selectedType);
        }
    },
    created() {
        this.$nextTick(() => {
            const dateFilterInput = document.getElementById('date-filter');
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            const formattedDate = `${year}-${month}-${day}`;
            dateFilterInput.value = formattedDate;
        });
    },
    computed: {
        formattedDateMission() {
            if (this.missionApprove && this.missionApprove.createdDate) {
                return this.formatDateApproved(this.missionApprove.createdDate);
            } else if (this.missionReject && this.missionReject.createdDate) {
                return this.formatDateApproved(this.missionReject.createdDate);
            }
            else {
                return '';
            }
        },
        formattedStartDateMission() {
            if (this.missionApprove && this.missionApprove.startDate) {
                return this.formatDateApproved(this.missionApprove.startDate);
            } else if (this.missionReject && this.missionReject.startDate) {
                return this.formatDateApproved(this.missionReject.startDate);
            } else {
                return '';
            }
        },
        formattedEndDateMission() {
            if (this.missionApprove && this.missionApprove.endDate) {
                return this.formatDateApproved(this.missionApprove.endDate);
            } else if (this.missionReject && this.missionReject.endDate) {
                return this.formatDateApproved(this.missionReject.endDate);
            } else {
                return '';
            }
        },
    },
    methods: {
        openApprove(mission) {
            this.showApproveDialog = true;
            this.missionApprove = mission;
            // console.log(this.overtimeApprove);
        },
        closeApprove() {
            this.showApproveDialog = false;
            this.errors.mission_comment = '';
            this.missionApprove.mission_comment = '';
        },
        openReject(mission) {
            this.showRejectDialog = true;
            this.missionReject = mission;
            // console.log(this.overtimeApprove);
        },
        closeReject() {
            this.showRejectDialog = false;
            this.errors.mission_comment = '';
            this.missionApprove.mission_comment = '';
        },
        viewMissionDatail(missionId) {
            this.$router.push({ name: 'ViewMission', params: { id: missionId } });
        },
        async fetchMissions(type) {
            this.loading = true;
            try {
                const token = localStorage.getItem('token');
                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/mission?isApproved=${type}`, {
                    headers: {
                        'Authorization': `Bearer ${token}`
                    }
                })
                this.missions = response.data.data;
                console.log(this.missions);
            } catch (error) {
                console.log(error);
            }
            this.loading = false;
        },
        async fetchMissionTypes() {
            try {
                const token = localStorage.getItem('token');
                const response = await axios.get('https://hrm-system-test.up.railway.app/api/mission_type', {
                    headers: {
                        'Authorization': `Bearer ${token}`
                    }
                });
                this.missionTypes = response.data.data;
                console.log(this.missionTypes);
            } catch (error) {
                console.error('Error fetching roles:', error);
            }
        },
        formatDate(dateString) {
            const date = new Date(dateString);
            const day = String(date.getDate()).padStart(2, '0');
            const month = date.toLocaleString('default', { month: 'short' });
            const year = date.getFullYear();
            const formattedDate = `${month}, ${day}  ${year}`;
            return formattedDate;
        },
        formatDateRequest(dateString) {
            const date = new Date(dateString);
            const day = String(date.getDate()).padStart(2, '0');
            const month = date.toLocaleString('default', { month: 'short' });
            const year = date.getFullYear();
            const formattedDate = `${day} ${month}  ${year}`;
            return formattedDate;
        },
        handleDateChange(event) {
            this.selectedDate = event.target.value;
            this.fetchfilterCreateDateMissions(this.selectedDate);
        },
        formatDateApproved(dateString) {
            const date = new Date(dateString);
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const formatter = new Intl.DateTimeFormat('en-US', options);
            const parts = formatter.formatToParts(date);
            const formattedDate = `${parts[0].value}, ${parts[4].value} ${parts[2].value} ${parts[3].value} ${parts[6].value}`;
            return formattedDate;
        },
        async fetchfilterCreateDateMissions(date) {
            this.loading = true;
            try {
                const token = localStorage.getItem('token');
                const formattedDate = date.split('-').join(''); // convert yyyy-mm-dd to yyyymmdd
                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/mission?createdDate=${formattedDate}`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                this.missions = response.data.data; // Assign the user data to the component's data property
                console.log(this.missions)
            } catch (error) {
                console.error(error);
            }
            this.loading = false;
        },
        async fetchMissionWithType(id) {
            this.loading = true;
            try {
                const token = localStorage.getItem('token');

                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/mission?typeId=${id}`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                this.missions = response.data.data; // Assign the user data to the component's data property
                console.log(response.data)
            } catch (error) {
                console.error(error);
            }
            this.loading = false;
        },
        async approveMission(id) {
            try {
                const empId = localStorage.getItem('id');
                const token = localStorage.getItem('token');
                const response = await axios.put(`https://hrm-system-test.up.railway.app/api/mission/approve/${this.missionApprove.id}`, {
                    approvedById: empId,
                    isApproved: true,
                    mission_comment: this.missionApprove.mission_comment
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
        async rejectMission(id) {
            try {
                const empId = localStorage.getItem('id');
                const token = localStorage.getItem('token');
                const response = await axios.put(`https://hrm-system-test.up.railway.app/api/mission/approve/${this.missionReject.id}`, {
                    approvedById: empId,
                    isApproved: false,
                    mission_comment: this.missionReject.mission_comment
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
        async confirmApproved(id) {
            try {
                if (!this.missionApprove.mission_comment) {
                    this.errors.mission_comment = 'Comments are required';
                }
                if (this.errors.mission_comment) {
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
                    await this.approveMission(id).then(() => {
                        this.fetchMissions('');
                        Swal.fire({
                            title: 'Approved!',
                            text: 'Mission has been Approved.',
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
                if (!this.missionReject.mission_comment) {
                    this.errors.mission_comment = 'Comments are required';
                }
                if (this.errors.mission_comment) {
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
                    await this.rejectMission(id).then(() => {
                        this.fetchMissions('');
                        Swal.fire({
                            title: 'Rejected!',
                            text: 'Mission has been Rejected.',
                            icon: 'success'
                        });
                    });
                }
            } catch (error) {
                console.error(error);
            }
        },
    }
}
</script>

<style>
.tbl-container {
    width: 400px;
    margin-top: 10px;
    margin-left: 10px;
}
.nav-link h5{
  color: white;
  border: 0;
}

/* Color for h4 when its parent is active */
.nav-link.active h5{
  color: rgb(0, 108, 81);
}

.bdr {
    border-radius: 6px;
    overflow: hidden;
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
</style>

<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';