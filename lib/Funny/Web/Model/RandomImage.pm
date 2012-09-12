package Funny::Web::Model::RandomImage;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

use YAML::XS;
use Data::Dumper;

has 'image_list' => (
    is      => 'ro',
    isa     => 'HashRef',
    default => sub {
        open my $fh, '<', 'data/image_list.yaml' or die $!;
        my $yaml = join "", <$fh>;
        close $fh;
        return Load $yaml;
    },
);

sub random_image {
    my $self = shift;
    my @keys =
      keys %{ $self->image_list };
    my $key = $keys[ int( rand($#keys) ) ];
    return { title => $key, image => $self->image_list->{$key} };
}

sub title_image {
    my ( $self, $title ) = @_;
    if ( $self->image_list->{$title} ) {
        return { title => $title, image => $self->image_list->{$title} };
    }
}

=head1 NAME

Funny::Web::Model::RandomImage - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Daniel Mantovani

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
