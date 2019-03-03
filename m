From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/8] fs: add project support to statx
Date: Mon, 4 Mar 2019 10:01:06 +1100
Message-ID: <20190303230106.GS23020@dastard>
References: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
 <1551449141-7884-6-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1h0a6k-0006tP-Ew
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 03 Mar 2019 23:01:22 +0000
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1h0a6i-008zwK-3V
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 03 Mar 2019 23:01:22 +0000
Content-Disposition: inline
In-Reply-To: <1551449141-7884-6-git-send-email-wshilong1991@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Wang Shilong <wangshilong1991@gmail.com>
Cc: adilger@dilger.ca, Wang Shilong <wshilong@ddn.com>, lixi@ddn.com, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org

On Fri, Mar 01, 2019 at 11:05:38PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> From: Wang Shilong <wshilong@ddn.com>
> 
> Extend statx to support project ID and inherit attribute.
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  fs/stat.c                       | 1 +
>  include/linux/stat.h            | 2 ++
>  include/uapi/linux/stat.h       | 8 ++++++--
>  tools/include/uapi/linux/stat.h | 8 ++++++--
>  4 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index adbfcd86c81b..82d855c4647c 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -551,6 +551,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_rdev_minor = MINOR(stat->rdev);
>  	tmp.stx_dev_major = MAJOR(stat->dev);
>  	tmp.stx_dev_minor = MINOR(stat->dev);
> +	tmp.stx_projid = (u32)from_kprojid(&init_user_ns, stat->projid);

If we are not in the init_user_ns, the project ID should be zero -
it should not be changeable or visible at all. I'm guessing the next
patches enforce this?

Regardless, the cast to (u32) should not be necessary.

Hmmmm.

/me looks at from_kprojid_munged() and thinks it needs to be nuked
from orbit. There is no such thing as an "overflow" project ID, and
65534 is a valid XFS project ID.


> diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
> index 7b35e98d3c58..21b542b3b061 100644
> --- a/tools/include/uapi/linux/stat.h
> +++ b/tools/include/uapi/linux/stat.h
> @@ -123,7 +123,9 @@ struct statx {
>  	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
>  	__u32	stx_dev_minor;
>  	/* 0x90 */
> -	__u64	__spare2[14];	/* Spare space for future expansion */
> +	__u32   stx_projid;     /* Project ID of file */
> +	__u32   __spare1[1];
> +	__u64   __spare2[13];   /* Spare space for future expansion */
>  	/* 0x100 */
>  };
>  
> @@ -148,7 +150,8 @@ struct statx {
>  #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
>  #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
>  #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
> -#define STATX_ALL		0x00000fffU	/* All currently supported flags */
> +#define STATX_PROJID		0x00001000U	/* Want/Got stx_projid */
> +#define STATX_ALL		0x00001fffU	/* All currently supported flags */
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
>  /*
> @@ -170,5 +173,6 @@ struct statx {
>  
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>  
> +#define STATX_ATTR_PROJINHERIT		0x00002000 /* [I] File project inherit is set */
							          ^^^^

The project ID inherit attribute is only valid for directories, not
files. Also, should probably be named STATX_ATTR_PROJID_INHERIT.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
