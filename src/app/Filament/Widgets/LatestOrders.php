<?php

namespace App\Filament\Widgets;

use App\Models\Patient;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;

class LatestOrders extends BaseWidget
{
    public function table(Table $table): Table
    {
        return $table
            ->query(
                Patient::query()
                    ->latest()
                    ->limit(5)
            )
            ->columns([
                Tables\Columns\TextColumn::make('date_of_birth'),
                Tables\Columns\TextColumn::make('name'),
                Tables\Columns\TextColumn::make('owner.name'),
                Tables\Columns\TextColumn::make('type')
            ]);
    }
}
