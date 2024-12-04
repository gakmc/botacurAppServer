<?php

namespace App\Policies;

use App\Programa;
use App\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class ProgramaPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any programas.
     *
     * @param  \App\User  $user
     * @return mixed
     */



     public function index(User $user)
     {
         //
     }
    public function viewAny(User $user)
    {
        //
    }

    /**
     * Determine whether the user can view the programa.
     *
     * @param  \App\User  $user
     * @param  \App\Programa  $programa
     * @return mixed
     */
    public function view(User $user, Programa $programa)
    {
        //
    }

    /**
     * Determine whether the user can create programas.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user)
    {
        return true; 
    }

    /**
     * Determine whether the user can update the programa.
     *
     * @param  \App\User  $user
     * @param  \App\Programa  $programa
     * @return mixed
     */
    public function update(User $user, Programa $programa)
    {
        return $user->has_permission('update-programa');
    }

    /**
     * Determine whether the user can delete the programa.
     *
     * @param  \App\User  $user
     * @param  \App\Programa  $programa
     * @return mixed
     */
    public function delete(User $user, Programa $programa)
    {
        //
    }

    /**
     * Determine whether the user can restore the programa.
     *
     * @param  \App\User  $user
     * @param  \App\Programa  $programa
     * @return mixed
     */
    public function restore(User $user, Programa $programa)
    {
        //
    }

    /**
     * Determine whether the user can permanently delete the programa.
     *
     * @param  \App\User  $user
     * @param  \App\Programa  $programa
     * @return mixed
     */
    public function forceDelete(User $user, Programa $programa)
    {
        //
    }
}
