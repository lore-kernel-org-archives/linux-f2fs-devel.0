From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: handle quota for orphan inodes
Date: Tue, 13 Feb 2018 22:33:26 +0800
Message-ID: <e48fd2e5-fab6-57c5-5fff-2e44f5a817b0@kernel.org>
References: <20180210022841.5707-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1elbeM-0005XY-Mu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Feb 2018 14:33:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1elbeL-0007Ds-Tu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Feb 2018 14:33:38 +0000
In-Reply-To: <20180210022841.5707-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/2/10 10:28, Jaegeuk Kim wrote:
> This is to fix missing dquot_initialize for orphan inodes.

IMO, we don't need to call dquot_initialize as we have call the function
in evict(), right?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 8b0945ba284d..e3bf753a47be 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -569,13 +569,8 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>  	struct node_info ni;
>  	int err = acquire_orphan_inode(sbi);
>  
> -	if (err) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_msg(sbi->sb, KERN_WARNING,
> -				"%s: orphan failed (ino=%x), run fsck to fix.",
> -				__func__, ino);
> -		return err;
> -	}
> +	if (err)
> +		goto err_out;
>  
>  	__add_ino_entry(sbi, ino, 0, ORPHAN_INO);
>  
> @@ -589,6 +584,11 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>  		return PTR_ERR(inode);
>  	}
>  
> +	err = dquot_initialize(inode);
> +	if (err)
> +		goto err_out;
> +
> +	dquot_initialize(inode);
>  	clear_nlink(inode);
>  
>  	/* truncate all the data during iput */
> @@ -598,14 +598,18 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>  
>  	/* ENOMEM was fully retried in f2fs_evict_inode. */
>  	if (ni.blk_addr != NULL_ADDR) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_msg(sbi->sb, KERN_WARNING,
> -			"%s: orphan failed (ino=%x) by kernel, retry mount.",
> -				__func__, ino);
> -		return -EIO;
> +		err = -EIO;
> +		goto err_out;
>  	}
>  	__remove_ino_entry(sbi, ino, ORPHAN_INO);
>  	return 0;
> +
> +err_out:
> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> +	f2fs_msg(sbi->sb, KERN_WARNING,
> +			"%s: orphan failed (ino=%x), run fsck to fix.",
> +			__func__, ino);
> +	return err;
>  }
>  
>  int recover_orphan_inodes(struct f2fs_sb_info *sbi)
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
