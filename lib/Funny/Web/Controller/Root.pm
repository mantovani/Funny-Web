package Funny::Web::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=head1 NAME

Funny::Web::Controller::Root - Root Controller for Funny::Web

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

sub root : Chained('/') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash->{image_model} = $c->model('RandomImage');
}

sub index : Chained('root') : PathPart('index') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{image_rand} = $c->stash->{image_model}->random_image;
}

sub image : Chained('root') : PathPart('') : Args(1) {
    my ( $self, $c, $image_title ) = @_;
    $c->stash->{image_rand} =
      $c->stash->{image_model}->title_image($image_title);
    $c->stash->{template} = 'index';
}

=head2 default

Standard 404 error page

=cut

sub default : Path {
    my ( $self, $c ) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') { }

=head1 AUTHOR

Daniel Mantovani

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
