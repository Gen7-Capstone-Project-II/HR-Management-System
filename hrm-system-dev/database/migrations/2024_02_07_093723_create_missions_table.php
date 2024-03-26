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
        Schema::create('missions', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('empId');
            $table->uuid('typeId');
            $table->string('title');
            $table->dateTime('startDate');
            $table->dateTime('endDate');
            $table->double('budget')->nullable();
            $table->text('note')->nullable();
            $table->string('attachment')->nullable();
            $table->dateTime('createdDate');
            $table->boolean('isApproved')->nullable();
            $table->uuid('approvedById')->nullable();
            $table->foreign('empId')->references('id')->on('users');
            $table->foreign('typeId')->references('id')->on('mission_types')->onDelete('cascade');
            $table->foreign('approvedById')->references('id')->on('users');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('missions');
    }
};
