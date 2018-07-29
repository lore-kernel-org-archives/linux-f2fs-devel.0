From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] mkfs.f2fs: Fix the checkpoint version
 written to the footer of the root's inode
Date: Sat, 28 Jul 2018 18:14:57 -0700
Message-ID: <20180729011457.GA83620@jaegeuk-macbookpro.roam.corp.google.com>
References: <9F004D7E-1745-4AF2-A395-35437F2055FA@cs.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fjaIe-000519-6u
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 01:15:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fjaIa-001DZ0-S5
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 01:15:08 +0000
Content-Disposition: inline
In-Reply-To: <9F004D7E-1745-4AF2-A395-35437F2055FA@cs.toronto.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 07/26, Sotirios-Efstathios Maneas wrote:
> Fix the checkpoint version written to the footer of the root's inode.

What does this patch to fix?
The checkpoint_ver in footer is to detect the node is recoverable or not during
roll-forward recovery. So, root_inode doesn't require to have the exact version.

> 
> ---
>  mkfs/f2fs_format.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index d844563..fe3112e 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -28,6 +28,7 @@ extern struct f2fs_configuration c;
>  struct f2fs_super_block raw_sb;
>  struct f2fs_super_block *sb = &raw_sb;
>  struct f2fs_checkpoint *cp;
> +int f2fs_checkpoint_version;

This should be u64.

Thanks,

>  
>  /* Return first segment number of each area */
>  #define prev_zone(cur)		(c.cur_seg[cur] - c.segs_per_zone)
> @@ -619,8 +620,7 @@ static int f2fs_write_check_point_pack(void)
>  	}
>  
>  	/* 1. cp page 1 of checkpoint pack 1 */
> -	srand(time(NULL));
> -	cp->checkpoint_ver = cpu_to_le64(rand() | 0x1);
> +	cp->checkpoint_ver = cpu_to_le64(f2fs_checkpoint_version);
>  	set_cp(cur_node_segno[0], c.cur_seg[CURSEG_HOT_NODE]);
>  	set_cp(cur_node_segno[1], c.cur_seg[CURSEG_WARM_NODE]);
>  	set_cp(cur_node_segno[2], c.cur_seg[CURSEG_COLD_NODE]);
> @@ -1061,9 +1061,12 @@ static int f2fs_write_root_inode(void)
>  		return -1;
>  	}
>  
> +	srand(time(NULL));
> +	f2fs_checkpoint_version = rand() | 0x1;
> +
>  	raw_node->footer.nid = sb->root_ino;
>  	raw_node->footer.ino = sb->root_ino;
> -	raw_node->footer.cp_ver = cpu_to_le64(1);
> +	raw_node->footer.cp_ver = cpu_to_le64(f2fs_checkpoint_version);
>  	raw_node->footer.next_blkaddr = cpu_to_le32(
>  			get_sb(main_blkaddr) +
>  			c.cur_seg[CURSEG_HOT_NODE] *
> -- 
> 2.7.4
> 
> Kind regards,
> Stathis Maneas
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
