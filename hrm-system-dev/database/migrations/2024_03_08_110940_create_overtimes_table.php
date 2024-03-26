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
        Schema::create('overtimes', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('empId');
            $table->uuid('approvedById')->nullable();
            $table->string('title');
            $table->text('reason')->nullable();
            $table->dateTime('dateOT');
            $table->time('time_from');
            $table->time('time_to');
            $table->double('total_time')->nullable();
            $table->boolean( 'isApproved' )->nullable();
            $table->double('total_approve')->nullable();
            $table->double('paid')->nullable();
            $table->dateTime('createDate')->nullable();
            $table->foreign('empId')->references('id')->on('users');
            $table->foreign('approvedById')->references('id')->on('users');
            $table->timestamps(); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('overtimes');
    }
};
