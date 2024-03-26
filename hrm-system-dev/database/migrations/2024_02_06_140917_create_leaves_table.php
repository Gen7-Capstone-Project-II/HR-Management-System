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
        Schema::create('leaves', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('empId');
            $table->uuid('leaveTypeId');
            $table->dateTime('startDate');
            $table->dateTime('endDate');
            $table->double('totalDays')->nullable();
            $table->string('reason');
            $table->dateTime('createdDate');
            $table->string('attachment')->nullable();
            $table->boolean('isApproved')->nullable();
            $table->uuid('approvedById')->nullable();
            $table->timestamps();

            $table->foreign('empId')->references('id')->on('users');
            $table->foreign('leaveTypeId')->references('id')->on('leave_types');
            $table->foreign('approvedById')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('leaves');
    }
};
