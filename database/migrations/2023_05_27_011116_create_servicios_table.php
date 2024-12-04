<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateServiciosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('servicios', function (Blueprint $table) {
            $table->Increments('id');
            $table->string('nombre_servicio')->unique();
            $table->integer('valor_servicio');
            $table->integer('costo_servicio')->nullable();
            $table->unsignedInteger('programa_id');
            $table->foreign('programa_id')->references('id')->on('programas')->onUpdate('cascade')->onDelete('cascade');
            $table->timestamps();
            
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('servicios');
    }
}
