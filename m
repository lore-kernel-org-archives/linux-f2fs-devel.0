From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: reorganize the f2fs_setattr()
 function.
Date: Tue, 11 Jun 2013 14:48:36 +0900
Message-ID: <1370929716.14857.8.camel@lcm>
References: <1370694303-2738-1-git-send-email-linkinjeon@gmail.com>
 <1370824712.22405.18.camel@lcm>
 <CAKYAXd-V9iF0o5nvFyFPgJX0waDLh4c_eNJ7V_o-tbbrtX1JLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <CAKYAXd-V9iF0o5nvFyFPgJX0waDLh4c_eNJ7V_o-tbbrtX1JLQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: jaegeuk.kim@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On =ED=99=94, 2013-06-11 at 07:57 +0900, Namjae Jeon wrote:
> 2013/6/10, Changman Lee <cm224.lee@samsung.com>:
> > Hello, Namjae
> Hi. Changman.
> >
> > If using ACL, whenever i_mode is changed we should update acl_mode =
which
> > is written to xattr block, too. And vice versa.
> > Because update_inode() is called at any reason and anytime, so we s=
hould
> > sync both the moment xattr is written.
> > We don't hope that only i_mode is written to disk and xattr is not.=
 So
> > f2fs_setattr is dirty.
> Yes, agreed this could be issue.
> >
> > And, below code has a bug. When error is occurred, inode->i_mode
> > shouldn't be changed. Please, check one more time, Namjae.
> And, below code has a bug. When error is occurred, inode->i_mode
> shouldn't be changed. Please, check one more time, Namjae.
>=20
> This was part of the default code, when =E2=80=98acl=E2=80=99 is not =
set for file=E2=80=99
> Then, inode should be updated by these conditions (i.e., it covers th=
e
> =E2=80=98chmod=E2=80=99 and =E2=80=98setacl=E2=80=99 scenario).
> When ACL is not present on the file and =E2=80=98chmod=E2=80=99 is do=
ne, then mode is
> changed from this part, as f2fs_get_acl() will fail and cause the
> below code to be executed:
>=20
>     if (err || is_inode_flag_set(fi, FI_ACL_MODE)) {
>              inode->i_mode =3D fi->i_acl_mode;
>              clear_inode_flag(fi, FI_ACL_MODE);
>       }
>=20
> Now, in order to make it consistent and work on all scenario we need
> to make further change like this in addition to the patch changes.
> setattr_copy(inode, attr);
>         if (attr->ia_valid & ATTR_MODE) {
> +             set_acl_inode(fi, inode->i_mode);
>               err =3D f2fs_acl_chmod(inode);
>               if (err || is_inode_flag_set(fi, FI_ACL_MODE)) {
>=20
> Let me know your opinion.
> Thanks.
>=20

setattr_copy changes inode->i_mode, this is not our expectation.
So I made redundant __setatt_copy that copy attr->mode to
fi->i_acl_mode.
When acl_mode is reflected in xattr, acl_mode is copied to
inode->i_mode.

Agree?

> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index deefd25..29cd449 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -352,10 +352,8 @@ int f2fs_setattr(struct dentry *dentry, struct
> > iattr *attr)
> >
> >         if (attr->ia_valid & ATTR_MODE) {
> >                 err =3D f2fs_acl_chmod(inode);
> > -               if (err || is_inode_flag_set(fi, FI_ACL_MODE)) {
> > -                       inode->i_mode =3D fi->i_acl_mode;
> > +               if (err || is_inode_flag_set(fi, FI_ACL_MODE))
> >                         clear_inode_flag(fi, FI_ACL_MODE);
> > -               }
> >         }
> >
> > Thanks.
> >
> >
> > On =ED=86=A0, 2013-06-08 at 21:25 +0900, Namjae Jeon wrote:
> >> From: Namjae Jeon <namjae.jeon@samsung.com>
> >>
> >> Remove the redundant code from this function and make it aligned w=
ith
> >> usages of latest generic vfs layer function e.g using the setattr_=
copy()
> >> instead of using the f2fs specific function.
> >>
> >> Also correct the condition for updating the size of file via
> >> truncate_setsize().
> >>
> >> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> >> Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
> >> ---
> >>  fs/f2fs/acl.c  |    5 +----
> >>  fs/f2fs/file.c |   47 +++++--------------------------------------=
----
> >>  2 files changed, 6 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> >> index 44abc2f..2d13f44 100644
> >> --- a/fs/f2fs/acl.c
> >> +++ b/fs/f2fs/acl.c
> >> @@ -17,9 +17,6 @@
> >>  #include "xattr.h"
> >>  #include "acl.h"
> >>
> >> -#define get_inode_mode(i)	((is_inode_flag_set(F2FS_I(i), FI_ACL_M=
ODE)) ?
> >> \
> >> -					(F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
> >> -
> >>  static inline size_t f2fs_acl_size(int count)
> >>  {
> >>  	if (count <=3D 4) {
> >> @@ -299,7 +296,7 @@ int f2fs_acl_chmod(struct inode *inode)
> >>  	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> >>  	struct posix_acl *acl;
> >>  	int error;
> >> -	umode_t mode =3D get_inode_mode(inode);
> >> +	umode_t mode =3D inode->i_mode;
> >>
> >>  	if (!test_opt(sbi, POSIX_ACL))
> >>  		return 0;
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index deefd25..8dfc1da 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -300,63 +300,26 @@ static int f2fs_getattr(struct vfsmount *mnt=
,
> >>  	return 0;
> >>  }
> >>
> >> -#ifdef CONFIG_F2FS_FS_POSIX_ACL
> >> -static void __setattr_copy(struct inode *inode, const struct iatt=
r
> >> *attr)
> >> -{
> >> -	struct f2fs_inode_info *fi =3D F2FS_I(inode);
> >> -	unsigned int ia_valid =3D attr->ia_valid;
> >> -
> >> -	if (ia_valid & ATTR_UID)
> >> -		inode->i_uid =3D attr->ia_uid;
> >> -	if (ia_valid & ATTR_GID)
> >> -		inode->i_gid =3D attr->ia_gid;
> >> -	if (ia_valid & ATTR_ATIME)
> >> -		inode->i_atime =3D timespec_trunc(attr->ia_atime,
> >> -						inode->i_sb->s_time_gran);
> >> -	if (ia_valid & ATTR_MTIME)
> >> -		inode->i_mtime =3D timespec_trunc(attr->ia_mtime,
> >> -						inode->i_sb->s_time_gran);
> >> -	if (ia_valid & ATTR_CTIME)
> >> -		inode->i_ctime =3D timespec_trunc(attr->ia_ctime,
> >> -						inode->i_sb->s_time_gran);
> >> -	if (ia_valid & ATTR_MODE) {
> >> -		umode_t mode =3D attr->ia_mode;
> >> -
> >> -		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
> >> -			mode &=3D ~S_ISGID;
> >> -		set_acl_inode(fi, mode);
> >> -	}
> >> -}
> >> -#else
> >> -#define __setattr_copy setattr_copy
> >> -#endif
> >> -
> >>  int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
> >>  {
> >>  	struct inode *inode =3D dentry->d_inode;
> >> -	struct f2fs_inode_info *fi =3D F2FS_I(inode);
> >>  	int err;
> >>
> >>  	err =3D inode_change_ok(inode, attr);
> >>  	if (err)
> >>  		return err;
> >>
> >> -	if ((attr->ia_valid & ATTR_SIZE) &&
> >> -			attr->ia_size !=3D i_size_read(inode)) {
> >> -		truncate_setsize(inode, attr->ia_size);
> >> +	if ((attr->ia_valid & ATTR_SIZE)) {
> >> +		if (attr->ia_size !=3D i_size_read(inode))
> >> +			truncate_setsize(inode, attr->ia_size);
> >>  		f2fs_truncate(inode);
> >>  		f2fs_balance_fs(F2FS_SB(inode->i_sb));
> >>  	}
> >>
> >> -	__setattr_copy(inode, attr);
> >> +	setattr_copy(inode, attr);
> >>
> >> -	if (attr->ia_valid & ATTR_MODE) {
> >> +	if (attr->ia_valid & ATTR_MODE)
> >>  		err =3D f2fs_acl_chmod(inode);
> >> -		if (err || is_inode_flag_set(fi, FI_ACL_MODE)) {
> >> -			inode->i_mode =3D fi->i_acl_mode;
> >> -			clear_inode_flag(fi, FI_ACL_MODE);
> >> -		}
> >> -	}
> >>
> >>  	mark_inode_dirty(inode);
> >>  	return err;
> >
> >
> >


--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
