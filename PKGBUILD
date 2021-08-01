# Maintainer: Static_Rocket

pkgname=btrfs-monitor-git
_pkgname=${pkgname%"-git"}
pkgver=r1.61a9b74
pkgrel=1
pkgdesc='Systemd timer for monitoring and sending status emails about btrfs devices'
arch=('x86_64')
url='https://github.com/StaticRocket/btrfs-monitor'
license=('GPL2')
depends=('systemd' 'btrfs-progs' 'smtp-forwarder' 'sh')
source=("git+https://github.com/StaticRocket/btrfs-monitor.git")
backup=("etc/conf.d/$_pkgname")
md5sums=('SKIP')

pkgver() {
	cd "$srcdir/$_pkgname"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
	cd "$srcdir/$_pkgname"
	install -Dm755 $_pkgname.sh "$pkgdir/usr/bin/$_pkgname"
	install -Dm755 $_pkgname.conf "$pkgdir/etc/conf.d/$_pkgname"
	install -Dm644 $_pkgname@.timer "$pkgdir/usr/lib/systemd/system/$_pkgname@.timer"
	install -Dm644 $_pkgname@.service "$pkgdir/usr/lib/systemd/system/$_pkgname@.service"
}
