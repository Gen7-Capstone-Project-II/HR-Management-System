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
        Schema::create('contracts', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('empId');
            $table->uuid('departmentId');
            $table->uuid('positionId');
            $table->date('contract_startdate');
            $table->date('contract_enddate');
            $table->string('working_schedule');
            $table->double('base_salary');
            $table->string('attachment_file')->nullable();
            $table->foreign('empId')->references('id')->on('users');
            $table->foreign('positionId')->references('id')->on('positions')->onDelete('cascade');
            $table->foreign('departmentId')->references('id')->on('departments')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('contracts');
    }
};
