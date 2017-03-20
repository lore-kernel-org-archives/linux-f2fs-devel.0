From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: calculate the f2fs_stat_info into
	base_mem
Date: Sun, 19 Mar 2017 23:10:38 -0400
Message-ID: <20170320031038.GC45667@jaegeuk.local>
References: <7f9edb57-f452-1ee2-5e64-750517231325@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cpnia-0002pe-3t
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Mar 2017 03:10:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cpniZ-0000BE-9j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Mar 2017 03:10:48 +0000
Content-Disposition: inline
In-Reply-To: <7f9edb57-f452-1ee2-5e64-750517231325@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 03/18, Kinglong Mee wrote:
> The memory size of f2fs_stat_info also should be calculated.
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
>  fs/f2fs/debug.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index ee2d0a4..cf102d1 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -156,7 +156,11 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>  	if (si->base_mem)
>  		goto get_cache;
>  
> -	si->base_mem = sizeof(struct f2fs_sb_info) + sbi->sb->s_blocksize;
> +	/* build stat */
> +	si->base_mem = sizeof(struct f2fs_stat_info);
> +
> +	/* build superb lock*/

Fixed  /* build superblock */

> +	si->base_mem += sizeof(struct f2fs_sb_info) + sbi->sb->s_blocksize;
>  	si->base_mem += 2 * sizeof(struct f2fs_inode_info);
>  	si->base_mem += sizeof(*sbi->ckpt);
>  	si->base_mem += sizeof(struct percpu_counter) * NR_COUNT_TYPE;
> -- 
> 2.9.3

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
