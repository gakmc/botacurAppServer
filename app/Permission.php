<?php

namespace App;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use RealRashid\SweetAlert\Facades\Alert;




class Permission extends Model
{
    protected $fillable = [
        'name', 'slug', 'description', 'role_id'
    ];


    // RELACIONES 
    public function role() 
    {
        return $this->belongsTo('App\Role');
    }
    
    public function users()
    {
        return $this->belongsToMany('App\User')->withTimestamps();
    }


    public function store($request)
    {
        $slug = Str::slug($request->name, '-');
        Alert::success('Éxito', 'Permiso creado')->showConfirmButton();
        return self::create($request->all() + [
            'slug' => $slug,
        ]);
    }

    public function my_update($request)
    {
        $slug = Str::slug($request->name, '-');
        Alert::success('Éxito', 'Permiso actualizado')->showConfirmButton();
        return self::update($request->all() + [
            'slug' => $slug,
        ]);
        
    }

}
