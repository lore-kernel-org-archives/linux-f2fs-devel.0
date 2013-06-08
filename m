From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support xattr security labels
Date: Sat, 08 Jun 2013 09:55:43 +0900
Message-ID: <1370652943.3600.52.camel@kjgkr>
References: <1370584557-20592-1-git-send-email-jaegeuk.kim@samsung.com>
	<1370584557-20592-2-git-send-email-jaegeuk.kim@samsung.com>
	<51B25B17.3010807@schaufler-ca.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2247768858205362526=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Ul7Su-0001pS-5r
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 00:57:08 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ul7Sr-0004qF-Mk for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 00:57:08 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MO1000KMUMZ4EC0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 09:56:59 +0900 (KST)
In-reply-to: <51B25B17.3010807@schaufler-ca.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net


--===============2247768858205362526==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-d45hfZnzrjeNzSlduETt"


--=-d45hfZnzrjeNzSlduETt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thank you for the review.
I agreed all, and will submit v3.
Thanks,

2013-06-07 (=EA=B8=88), 15:13 -0700, Casey Schaufler:
> On 6/6/2013 10:55 PM, Jaegeuk Kim wrote:
> > This patch adds the support of security labels for f2fs, which will be =
used
> > by SElinux.
>=20
> Please be inclusive. Security xattrs are used by LSMs other than SELinux.

> > Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > ---
> >  fs/f2fs/Kconfig |  9 +++++++++
> >  fs/f2fs/dir.c   |  5 +++++
> >  fs/f2fs/xattr.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  fs/f2fs/xattr.h | 12 +++++++++++-
> >  4 files changed, 82 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> > index fd27e7e..2214cc9 100644
> > --- a/fs/f2fs/Kconfig
> > +++ b/fs/f2fs/Kconfig
> > @@ -51,3 +51,12 @@ config F2FS_FS_POSIX_ACL
> >  	  Linux website <http://acl.bestbits.at/>.
> > =20
> >  	  If you don't know what Access Control Lists are, say N
> > +
> > +config F2FS_FS_SECURITY
> > +	bool "F2FS Security Labels"
> > +	depends on F2FS_FS_XATTR
> > +	help
> > +	  Security labels provide acls used by the security modules
> > +	  like SELinux. This option should be used with the xattr mode.
>=20
> This description missuses the term "acl". Security labels are not
> Access Control Lists (ACLs). What is the "xattr mode"? If this option
> depends on xattr support "should" is not correct.
>=20
> > +
> > +	  If you are not using a security module, say N.
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index 67e2d13..81a1d6f 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -13,6 +13,7 @@
> >  #include "f2fs.h"
> >  #include "node.h"
> >  #include "acl.h"
> > +#include "xattr.h"
> > =20
> >  static unsigned long dir_blocks(struct inode *inode)
> >  {
> > @@ -334,6 +335,10 @@ static struct page *init_inode_metadata(struct ino=
de *inode,
> >  		if (err)
> >  			goto error;
> > =20
> > +		err =3D f2fs_init_security(inode, dir, name);
> > +		if (err)
> > +			goto error;
> > +
> >  		wait_on_page_writeback(page);
> >  	} else {
> >  		page =3D get_node_page(F2FS_SB(dir->i_sb), inode->i_ino);
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > index ae61f35..b5292fa 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -20,6 +20,7 @@
> >   */
> >  #include <linux/rwsem.h>
> >  #include <linux/f2fs_fs.h>
> > +#include <linux/security.h>
> >  #include "f2fs.h"
> >  #include "xattr.h"
> > =20
> > @@ -43,6 +44,10 @@ static size_t f2fs_xattr_generic_list(struct dentry =
*dentry, char *list,
> >  		prefix =3D XATTR_TRUSTED_PREFIX;
> >  		prefix_len =3D XATTR_TRUSTED_PREFIX_LEN;
> >  		break;
> > +	case F2FS_XATTR_INDEX_SECURITY:
> > +		prefix =3D XATTR_SECURITY_PREFIX;
> > +		prefix_len =3D XATTR_SECURITY_PREFIX_LEN;
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -70,13 +75,14 @@ static int f2fs_xattr_generic_get(struct dentry *de=
ntry, const char *name,
> >  		if (!capable(CAP_SYS_ADMIN))
> >  			return -EPERM;
> >  		break;
> > +	case F2FS_XATTR_INDEX_SECURITY:
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> >  	if (strcmp(name, "") =3D=3D 0)
> >  		return -EINVAL;
> > -	return f2fs_getxattr(dentry->d_inode, type, name,
> > -			buffer, size);
> > +	return f2fs_getxattr(dentry->d_inode, type, name, buffer, size);
> >  }
> > =20
> >  static int f2fs_xattr_generic_set(struct dentry *dentry, const char *n=
ame,
> > @@ -93,6 +99,8 @@ static int f2fs_xattr_generic_set(struct dentry *dent=
ry, const char *name,
> >  		if (!capable(CAP_SYS_ADMIN))
> >  			return -EPERM;
> >  		break;
> > +	case F2FS_XATTR_INDEX_SECURITY:
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -145,6 +153,40 @@ static int f2fs_xattr_advise_set(struct dentry *de=
ntry, const char *name,
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_F2FS_FS_SECURITY
> > +static int f2fs_initxattrs(struct inode *inode, const struct xattr *xa=
ttr_array,
> > +		void *fs_info)
> > +{
> > +	const struct xattr *xattr;
> > +	char *name;
> > +	int err =3D 0;
> > +
> > +	for (xattr =3D xattr_array; xattr->name !=3D NULL; xattr++) {
> > +		name =3D kmalloc(XATTR_SECURITY_PREFIX_LEN +
> > +			       strlen(xattr->name) + 1, GFP_NOFS);
> > +		if (!name) {
> > +			err =3D -ENOMEM;
> > +			break;
> > +		}
> > +		strcpy(name, XATTR_SECURITY_PREFIX);
> > +		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
>=20
> 		sprintf(name, XATTR_SECURITY_PREFIX "%s", xattr->name);
>=20
> might look simpler.
>=20
> > +		err =3D f2fs_setxattr(inode, F2FS_XATTR_INDEX_SECURITY, name,
> > +					xattr->value, xattr->value_len);
> > +		kfree(name);
> > +		if (err < 0)
> > +			break;
> > +	}
> > +	return err;
> > +}
> > +
> > +int f2fs_init_security(struct inode *inode, struct inode *dir,
> > +				const struct qstr *qstr)
> > +{
> > +	return security_inode_init_security(inode, dir, qstr,
> > +				&f2fs_initxattrs, NULL);
> > +}
> > +#endif
> > +
> >  const struct xattr_handler f2fs_xattr_user_handler =3D {
> >  	.prefix	=3D XATTR_USER_PREFIX,
> >  	.flags	=3D F2FS_XATTR_INDEX_USER,
> > @@ -169,6 +211,13 @@ const struct xattr_handler f2fs_xattr_advise_handl=
er =3D {
> >  	.set    =3D f2fs_xattr_advise_set,
> >  };
> > =20
> > +const struct xattr_handler f2fs_xattr_security_handler =3D {
> > +	.prefix	=3D XATTR_SECURITY_PREFIX,
> > +	.list	=3D f2fs_xattr_generic_list,
> > +	.get	=3D f2fs_xattr_generic_get,
> > +	.set	=3D f2fs_xattr_generic_set,
> > +};
> > +
> >  static const struct xattr_handler *f2fs_xattr_handler_map[] =3D {
> >  	[F2FS_XATTR_INDEX_USER] =3D &f2fs_xattr_user_handler,
> >  #ifdef CONFIG_F2FS_FS_POSIX_ACL
> > @@ -177,6 +226,9 @@ static const struct xattr_handler *f2fs_xattr_handl=
er_map[] =3D {
> >  #endif
> >  	[F2FS_XATTR_INDEX_TRUSTED] =3D &f2fs_xattr_trusted_handler,
> >  	[F2FS_XATTR_INDEX_ADVISE] =3D &f2fs_xattr_advise_handler,
> > +#ifdef CONFIG_F2FS_FS_SECURITY
> > +	[F2FS_XATTR_INDEX_SECURITY] =3D &f2fs_xattr_security_handler,
> > +#endif
> >  };
> > =20
> >  const struct xattr_handler *f2fs_xattr_handlers[] =3D {
> > @@ -187,6 +239,9 @@ const struct xattr_handler *f2fs_xattr_handlers[] =
=3D {
> >  #endif
> >  	&f2fs_xattr_trusted_handler,
> >  	&f2fs_xattr_advise_handler,
> > +#ifdef CONFIG_F2FS_FS_SECURITY
> > +	&f2fs_xattr_security_handler,
> > +#endif
> >  	NULL,
> >  };
> > =20
> > diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
> > index 49c9558..14e1329 100644
> > --- a/fs/f2fs/xattr.h
> > +++ b/fs/f2fs/xattr.h
> > @@ -112,6 +112,7 @@ extern const struct xattr_handler f2fs_xattr_truste=
d_handler;
> >  extern const struct xattr_handler f2fs_xattr_acl_access_handler;
> >  extern const struct xattr_handler f2fs_xattr_acl_default_handler;
> >  extern const struct xattr_handler f2fs_xattr_advise_handler;
> > +extern const struct xattr_handler f2fs_xattr_security_handler;
> > =20
> >  extern const struct xattr_handler *f2fs_xattr_handlers[];
> > =20
> > @@ -121,7 +122,6 @@ extern int f2fs_getxattr(struct inode *inode, int n=
ame_index, const char *name,
> >  		void *buffer, size_t buffer_size);
> >  extern ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
> >  		size_t buffer_size);
> > -
> >  #else
> > =20
> >  #define f2fs_xattr_handlers	NULL
> > @@ -142,4 +142,14 @@ static inline ssize_t f2fs_listxattr(struct dentry=
 *dentry, char *buffer,
> >  }
> >  #endif
> > =20
> > +#ifdef CONFIG_F2FS_FS_SECURITY
> > +extern int f2fs_init_security(struct inode *inode, struct inode *dir,
> > +				const struct qstr *qstr);
> > +#else
> > +static inline int f2fs_init_security(struct inode *inode, struct inode=
 *dir,
> > +				const struct qstr *qstr)
> > +{
> > +	return 0;
> > +}
> > +#endif
> >  #endif /* __F2FS_XATTR_H__ */
>=20

--=20
Jaegeuk Kim
Samsung

--=-d45hfZnzrjeNzSlduETt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRsoEPAAoJEEAUqH6CSFDSUDIP/1CsVpSDWHl7fUbKr7NW5Cdr
KDywTIc/EPps1oVwm1J3/tr1bsP3kiMj5dOgDvC3aMJRnsUgUnrNifUbGpE6e8a+
VlirgR92+JrvRG3Z/JRgP1n1FA4kvvWIGVsgn1HbrW7WbGhnexbQVRyiCqGVI0Ki
hP0xZuB2XWAOrxSEePy1MKsxkEEWnTpUlR1izoO0Xw17BHwQbA1VRAOyQqpf/p0V
HRNVQGUCAtLJAOyzQMEfaX47cAZZh+32QOr7PBD/2fXJFg/KNk4SzwEVgtqqOAys
jyKJf0FqIuusHRrTt9O7NbE+NjOtk7V+UuOvA1APMDo2hHMVP+ueP2GUWFJI7MJP
a3bKKs6yj31CWg7Vg8BV60zS96qjbM1AEIL5q26XlKSuoIP/+F+EOpQZUZZsPPfJ
t2kHSpJMsGjoPETCFgzctpXYYwsL6yLM1eE6jA7pyqSZhS5EIr04znuFt/4dGY7x
+5jtO6wqGhPsC9iWox4IGJTmOxV47Y6SL378ouJC/2iRvOAEklVCjkXbgw7OEi/P
0w6rM29QComdNtjBGOvbAW8a2xuYFlCELVl+7KN5EM/RIbBzLVryjsxkMXhJy8eQ
xa7QCDr/nnJw1Dm9LiWb7oPqVfxOLwCIN6BDom8oDFWORUL9qA3BwAT8cnVCRYZW
4+LAWp+Su7oNRxNyK10m
=AuAL
-----END PGP SIGNATURE-----

--=-d45hfZnzrjeNzSlduETt--



--===============2247768858205362526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
--===============2247768858205362526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============2247768858205362526==--
