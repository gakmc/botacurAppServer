<?php

namespace App\Http\Controllers;

use App\Role;
use App\Http\Requests\Role\StoreRequest;
use App\Http\Requests\Role\UpdateRequest;
use Illuminate\Http\Request;
use RealRashid\SweetAlert\Facades\Alert;

class RoleController extends Controller
{

    public function __construct()
    {
	    $this->middleware('role:' . config('app.admin_role'));
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $this->authorize('index',Role::class);
        return view('themes.backoffice.pages.role.index', [
            'roles' => Role::all(),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $this->authorize('create',Role::class);
        return view('themes.backoffice.pages.role.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreRequest $request, Role $role)
    {
        $role = $role->store($request);
        return redirect()->route('backoffice.role.show', $role);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Role  $role
     * @return \Illuminate\Http\Response
     */
    public function show(Role $role)
    {
        $this->authorize('view',$role);
        return view('themes.backoffice.pages.role.show', [
            'role' => $role,
            'permissions' => $role->permissions
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Role  $role
     * @return \Illuminate\Http\Response
     */
    public function edit(Role $role)
    {
        $this->authorize('update', $role);
        return view('themes.backoffice.pages.role.edit',[
            'role'=> $role,
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Role  $role
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateRequest $request, Role $role)
    {
        $role->my_update($request);
        return redirect()->route('backoffice.role.show', $role);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Role  $role
     * @return \Illuminate\Http\Response
     */
    public function destroy(Role $role)
    {
        $this->authorize('delete', $role);
        $role->delete();
        Alert::success('Éxito', 'Rol eliminado')->showConfirmButton();
        return redirect()->route('backoffice.role.index');
        
    }
}
