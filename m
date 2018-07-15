From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fs: f2fs: Insert a space
Date: Sun, 15 Jul 2018 11:50:21 +0900
Message-ID: <20180715025021.GE11571@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180714103852.GA28458@willow72.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1feX7J-0005Cb-Rb
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 02:50:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1feX7G-008mOo-LQ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 02:50:33 +0000
Content-Disposition: inline
In-Reply-To: <20180714103852.GA28458@willow72.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: youngjun yoo <youngjun.willow@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Youngjun,

Look like you sent several patches to fix checkpatch error.
Could you please write single patch saying "f2fs: clean up coding style", which
contains all the changes that you want to fix?

Thanks,

On 07/14, youngjun yoo wrote:
> clean up checkpatch error:
> ERROR:
> space required before the open parenthesis (
> space required around that :
> Signed-off-by: willow72 <youngjun.willow@gmail.com>
> ---
>  fs/f2fs/node.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 51388cf..14ed45c 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1225,7 +1225,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>  		goto out_err;
>  	}
>  page_hit:
> -	if(unlikely(nid != nid_of_node(page))) {
> +	if (unlikely (nid != nid_of_node (page))) {
>  		f2fs_msg(sbi->sb, KERN_WARNING, "inconsistent node block, "
>  			"nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
>  			nid, nid_of_node(page), ino_of_node(page),
> @@ -1589,7 +1589,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  out:
>  	if (last_idx != ULONG_MAX)
>  		f2fs_submit_merged_write_cond(sbi, NULL, ino, last_idx, NODE);
> -	return ret ? -EIO: 0;
> +	return ret ? -EIO : 0;
>  }
>  
>  int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
> -- 
> 2.7.4
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
