<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('employee_details', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('user_id');
            $table->uuid('position_id');
            $table->uuid('dept_id');
            $table->string('firstName');
            $table->string('lastName');
            $table->string('firstNameKH');
            $table->string('lastNameKH');
            $table->date('birthDate');
            $table->integer('age')->nullable();
            $table->string('gender');
            $table->string('address')->nullable();
            $table->string('personalEmail')->nullable();
            $table->string('phoneNum1');
            $table->string('phoneNume2')->nullable();
            $table->string('telegram');
            $table->string('attachment')->nullable();
            $table->string('nationality')->nullable();
            $table->string('materialStatus')->nullable();
            $table->string('numberOfChild')->nullable();
            $table->date('employeeDate');
            $table->boolean('status');
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('position_id')->references('id')->on('positions')->onDelete('cascade');
            $table->foreign('dept_id')->references('id')->on('departments')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employee_details');
    }
};
