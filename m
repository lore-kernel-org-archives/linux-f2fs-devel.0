From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: fix a bug of inheriting default ACL from
	parent
Date: Mon, 26 Jan 2015 20:11:16 +0800
Message-ID: <008601d03961$53df2bd0$fb9d8370$@samsung.com>
References: <54C36091.4000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <54C36091.4000509@gmail.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Kinglong Mee' <kinglongmee@gmail.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Kinglong,

Nice catch!

> -----Original Message-----
> From: Kinglong Mee [mailto:kinglongmee@gmail.com]
> Sent: Saturday, January 24, 2015 5:06 PM
> To: Jaegeuk Kim
> Cc: linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: fix a bug of inheriting default ACL from parent
> 
> Introduced by a6dda0e63e97122ce9e0ba04367e37cca28315fa
> "f2fs: use generic posix ACL infrastructure".
> 
> When testing default acl, gets in recent kernel (3.19.0-rc5),
> # setfacl -dm g:root:rwx test/
> # getfacl test/
> # file: test/
> # owner: root
> # group: root
> user::rwx
> group::r-x
> other::r-x
> default:user::rwx
> default:group::r-x
> default:group:root:rwx
> default:mask::rwx
> default:other::r-x
> 
> # cd test/
> # mkdir testdir
> ]# getfacl testdir/
> # file: testdir/
> # owner: root
> # group: root
> user::rwx
> group::rwx

Should be group::r-x?

>                 // missing an acl "group:root:rwx" inherited from parent

mask::rwx is missing too.

> other::r-x
> default:user::rwx
> default:group::r-x
> default:group:root:rwx
> default:mask::rwx
> default:other::r-x
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/acl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> index 1ccb26b..b0b23578 100644
> --- a/fs/f2fs/acl.c
> +++ b/fs/f2fs/acl.c
> @@ -396,7 +396,7 @@ int f2fs_init_acl(struct inode *inode, struct inode
> *dir, struct page *ipage,
>  		posix_acl_release(default_acl);
>  	}
>  	if (acl) {
> -		if (error)
> +		if (!error)
>  			error = __f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl,
>  					       ipage);
>  		posix_acl_release(acl);
> --
> 2.1.0
> 
> 
> ------------------------------------------------------------------------------
> New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
> GigeNET is offering a free month of service with a new server in Ashburn.
> Choose from 2 high performing configs, both with 100TB of bandwidth.
> Higher redundancy.Lower latency.Increased capacity.Completely compliant.
> http://p.sf.net/sfu/gigenet
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

