<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Actions\Action;

class Settings extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    protected static string $view = 'filament.pages.settings';
    public $defaultAction = 'onboarding';

    protected function getHeaderActions(): array
    {
        return [
            Action::make('edit')
                ->url(route('posts.edit', ['post' => $this->post])),
            Action::make('delete')
                ->requiresConfirmation()
                ->action(fn() => $this->post->delete()),
        ];
    }
}
