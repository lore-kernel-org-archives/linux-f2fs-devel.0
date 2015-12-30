From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: avoid calling i_size_read when
 it's unnecessary
Date: Wed, 30 Dec 2015 10:27:39 -0800
Message-ID: <20151230182739.GC28564@jaegeuk.local>
References: <000c01d142df$24fdd450$6ef97cf0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aELTK-00016k-HS
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 18:27:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aELTJ-0005FO-Jv for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 18:27:42 +0000
Content-Disposition: inline
In-Reply-To: <000c01d142df$24fdd450$6ef97cf0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Fan,

On Wed, Dec 30, 2015 at 04:49:56PM +0800, Fan Li wrote:
> i_size_read does more than reading a value, it's best that we use it
> only when we need it.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/data.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d67c599..a9a4d89 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -780,7 +780,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  {
>  	struct buffer_head map_bh;
>  	sector_t start_blk, last_blk;
> -	loff_t isize = i_size_read(inode);
> +	loff_t isize;
>  	u64 logical = 0, phys = 0, size = 0;
>  	u32 flags = 0;
>  	int ret = 0;
> @@ -795,6 +795,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			return ret;
>  	}
>  
> +	isize = i_size_read(inode);

It seems that we need to get isize after grabbing i_mutex below in order to
avoid data race.

Thanks,

> +
>  	mutex_lock(&inode->i_mutex);
>  	if (start >= isize)
>  		goto out;
> -- 
> 1.7.9.5
> 

------------------------------------------------------------------------------
