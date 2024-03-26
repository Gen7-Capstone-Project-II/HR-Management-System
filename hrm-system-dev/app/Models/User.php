<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasOneOrMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Support\Str;

class User extends Authenticatable implements JWTSubject
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $fillable = [
        'idEmp',
        'name',
        'email',
        'password',
        'attachment'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    public function announcement(): HasOneOrMany
    {
        return $this->hasMany(Announcement::class);
    }

    public function emergencyContacts(): HasOneOrMany
    {
        return $this->hasMany(EmergencyContact::class);
    }

    public function employeeDetails(): HasOne
    {
        return $this->hasOne(EmployeeDetail::class);
    }

    public function missions()
    {
        return $this->hasMany(Mission::class, 'empId');
    }

    public function attendances()
    {
        return $this->hasMany(Attendance::class, 'empId');
    }

    public function leaves()
    {
        return $this->hasMany(Leave::class, 'empId');
    }

    public function contracts()
    {
        return $this->hasMany(Contract::class, 'empId');
    }

    public function overtimes()
    {
        return $this->hasMany(Overtime::class, 'empId');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }
}
