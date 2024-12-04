<?php

namespace App\Policies;

use App\Servicio;
use App\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class ServicioPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any servicios.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function viewAny(User $user)
    {
        //
    }

    /**
     * Determine whether the user can view the servicio.
     *
     * @param  \App\User  $user
     * @param  \App\Servicio  $servicio
     * @return mixed
     */
    public function view(User $user, Servicio $servicio)
    {
        //
    }

    /**
     * Determine whether the user can create servicios.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user)
    {
        return true;
    }

    /**
     * Determine whether the user can update the servicio.
     *
     * @param  \App\User  $user
     * @param  \App\Servicio  $servicio
     * @return mixed
     */
    public function update(User $user, Servicio $servicio)
    {
        //
    }

    /**
     * Determine whether the user can delete the servicio.
     *
     * @param  \App\User  $user
     * @param  \App\Servicio  $servicio
     * @return mixed
     */
    public function delete(User $user, Servicio $servicio)
    {
        //
    }

    /**
     * Determine whether the user can restore the servicio.
     *
     * @param  \App\User  $user
     * @param  \App\Servicio  $servicio
     * @return mixed
     */
    public function restore(User $user, Servicio $servicio)
    {
        //
    }

    /**
     * Determine whether the user can permanently delete the servicio.
     *
     * @param  \App\User  $user
     * @param  \App\Servicio  $servicio
     * @return mixed
     */
    public function forceDelete(User $user, Servicio $servicio)
    {
        //
    }
}
