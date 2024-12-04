<?php

namespace App\Http\Requests\Programa;
use App\Programa;

use Illuminate\Foundation\Http\FormRequest;

class StoreRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'nombre_programa' => ['required', 'string', 'max:255', 'unique:programas'],
            'valor_programa' => ['numeric'],
            'descuento' => ['numeric']
        ];
    }

    public function messages()
    {
        return [
            'nombre_programa.required' => 'El campo de nombre es requerido',
            'valor_programa' => 'Valor númerico',
            'descuento' => 'La descripción es númerica',

        ];
    }
}



