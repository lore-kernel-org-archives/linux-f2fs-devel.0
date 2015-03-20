From: Wang Shilong <wangshilong1991@gmail.com>
Subject: Re: [PATCH] f2fs: enable inline data by default
Date: Fri, 20 Mar 2015 10:54:05 +0800
Message-ID: <37F1B356-4E67-4DEE-95A7-1ED977A4A8FB@gmail.com>
References: <1426741895-7647-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1426741895-7647-1-git-send-email-wanpeng.li@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Wanpeng Li <wanpeng.li@linux.intel.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


Hi,

>=20
> Enable inline_data feature by default since it brings us better=20
> performance and space utilization and now has already stable.
>=20
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
> ---
> Documentation/filesystems/f2fs.txt |  2 --
> fs/f2fs/f2fs.h                     | 11 +++++------
> fs/f2fs/inline.c                   |  3 ---
> fs/f2fs/super.c                    |  7 -------
> 4 files changed, 5 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/files=
ystems/f2fs.txt
> index 48e2123..6c9c947 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -122,8 +122,6 @@ active_logs=3D%u         Support configuring the =
number of active logs. In the
> disable_ext_identify   Disable the extension list configured by mkfs,=
 so f2fs
>                        does not aware of cold files such as media fil=
es.
> inline_xattr           Enable the inline xattrs feature.
> -inline_data            Enable the inline data feature: New created s=
mall(<~3.4k)
> -                       files can be written into inode block.
> inline_dentry          Enable the inline dir feature: data in new cre=
ated
>                        directory entries can be written into inode bl=
ock. The
>                        space of inode block which is used to store in=
line
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f2909c6..5849520 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -45,12 +45,11 @@
> #define F2FS_MOUNT_POSIX_ACL		0x00000020
> #define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000040
> #define F2FS_MOUNT_INLINE_XATTR		0x00000080
> -#define F2FS_MOUNT_INLINE_DATA		0x00000100
> -#define F2FS_MOUNT_INLINE_DENTRY	0x00000200
> -#define F2FS_MOUNT_FLUSH_MERGE		0x00000400
> -#define F2FS_MOUNT_NOBARRIER		0x00000800
> -#define F2FS_MOUNT_FASTBOOT		0x00001000
> -#define F2FS_MOUNT_EXTENT_CACHE		0x00002000
> +#define F2FS_MOUNT_INLINE_DENTRY	0x00000100
> +#define F2FS_MOUNT_FLUSH_MERGE		0x00000200
> +#define F2FS_MOUNT_NOBARRIER		0x00000400
> +#define F2FS_MOUNT_FASTBOOT		0x00000800
> +#define F2FS_MOUNT_EXTENT_CACHE		0x00001000
>=20
> #define clear_opt(sbi, option)	(sbi->mount_opt.opt &=3D ~F2FS_MOUNT_#=
#option)
> #define set_opt(sbi, option)	(sbi->mount_opt.opt |=3D F2FS_MOUNT_##op=
tion)
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index d3e0599..d67bc0d 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -15,9 +15,6 @@
>=20
> bool f2fs_may_inline(struct inode *inode)
> {
> -	if (!test_opt(F2FS_I_SB(inode), INLINE_DATA))
> -		return false;
> -
> 	if (f2fs_is_atomic_file(inode))
> 		return false;
>=20
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fc6857f..f008222 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -52,7 +52,6 @@ enum {
> 	Opt_active_logs,
> 	Opt_disable_ext_identify,
> 	Opt_inline_xattr,
> -	Opt_inline_data,
> 	Opt_inline_dentry,
> 	Opt_flush_merge,
> 	Opt_nobarrier,
> @@ -74,7 +73,6 @@ static match_table_t f2fs_tokens =3D {
> 	{Opt_active_logs, "active_logs=3D%u"},
> 	{Opt_disable_ext_identify, "disable_ext_identify"},
> 	{Opt_inline_xattr, "inline_xattr"},
> -	{Opt_inline_data, "inline_data"},
> 	{Opt_inline_dentry, "inline_dentry"},
> 	{Opt_flush_merge, "flush_merge"},
> 	{Opt_nobarrier, "nobarrier"},
> @@ -354,9 +352,6 @@ static int parse_options(struct super_block *sb, =
char *options)
> 		case Opt_disable_ext_identify:
> 			set_opt(sbi, DISABLE_EXT_IDENTIFY);
> 			break;
> -		case Opt_inline_data:
> -			set_opt(sbi, INLINE_DATA);
> -			break;
> 		case Opt_inline_dentry:
> 			set_opt(sbi, INLINE_DENTRY);
> 			break;
> @@ -594,8 +589,6 @@ static int f2fs_show_options(struct seq_file *seq=
, struct dentry *root)
> #endif
> 	if (test_opt(sbi, DISABLE_EXT_IDENTIFY))
> 		seq_puts(seq, ",disable_ext_identify");
> -	if (test_opt(sbi, INLINE_DATA))
> -		seq_puts(seq, ",inline_data=A1=B1);

Wow, do you remove inline_data mount options?
I don=A1=AFt think this is a good idea..since mount option have
been there=A1=AD


> 	if (test_opt(sbi, INLINE_DENTRY))
> 		seq_puts(seq, ",inline_dentry");
> 	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
> --=20
> 2.1.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdev=
el" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best Regards,
Wang Shilong

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
