<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Owner extends Model
{
    public function patients(): HasMany
    {
        return $this->hasMany(Patient::class);
    }
}
