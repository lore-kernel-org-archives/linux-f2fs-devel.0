From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: no need to punch hole far beyond the
 file size
Date: Fri, 13 Oct 2017 20:42:39 +0800
Message-ID: <aff291b3-6684-d3a7-044e-3e754bac6365@kernel.org>
References: <20171013165950.219357-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e2zIs-0004l2-Lh
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 12:43:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e2zIr-0003it-JM
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 12:43:02 +0000
In-Reply-To: <20171013165950.219357-1-guoweichao@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Weichao Guo <guoweichao@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/14 0:59, Weichao Guo wrote:
> Punching hole with a length which far larger than file size will
> cause a long time looping in truncate_hole after lock_op, it can
> be reproduced as the following:
> 
>         $ echo "abc" > file
>         $ xfs_io -c "fpunch 0 HUGE_LENGTH" file
> 
> This may cause other I/Os blocked a long time. Let's fix this case
> by setting the hole to end after the page that contains i_size.
You know, we can reserve blocks across EOF through fallocate(fd, FALLOC_FL_KEEP_SIZE,
ofs, len), so this patch will cause f2fs losing ability of punching preallocated
blocks across EOF.

How about below change:

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cfee75bf88d9..91fd2ef7221b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -847,7 +847,7 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 		err = get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
 		if (err) {
 			if (err == -ENOENT) {
-				pg_start++;
+				pg_start = get_next_page_offset(&dn, pg_start);
 				continue;
 			}
 			return err;

Thanks,

> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/file.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 517e112..1b44d26 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -873,6 +873,14 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * If the hole extends beyond i_size, set the hole
> +	 * to end after the page that contains i_size
> +	 */
> +	if (offset + len > inode->i_size)
> +		len = inode->i_size + PAGE_CACHE_SIZE -
> +			(inode->i_size & (PAGE_CACHE_SIZE - 1)) - offset;
> +
>  	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
>  	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
>  
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
