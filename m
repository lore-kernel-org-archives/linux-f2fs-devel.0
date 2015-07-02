From: Chao Yu <yuchaochina@hotmail.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches first
Date: Thu, 2 Jul 2015 20:39:43 +0800
Message-ID: <COL402-EAS277B75C19DA375A394DDFCEAB970@phx.gbl>
References: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org> <1435713946-6910-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1435713946-6910-2-git-send-email-jaegeuk@kernel.org>
Content-Language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, July 01, 2015 9:26 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org;
> linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim; Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches first
> 
> If an extent_tree entry has a zero reference count, we can drop it from the
> cache in higher priority rather than currently referencing entries.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8f059e0..a0a0e2b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -661,21 +661,54 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int
> nr_shrink)
>  	struct radix_tree_root *root = &sbi->extent_tree_root;
>  	unsigned int found;
>  	unsigned int node_cnt = 0, tree_cnt = 0;
> +	int remained;
> 
>  	if (!test_opt(sbi, EXTENT_CACHE))
>  		return 0;
> 
> +	if (!down_write_trylock(&sbi->extent_tree_lock))
> +		goto out;
> +
> +	/* 1. remove unreferenced extent tree */

We always release extent node and tree from inode with lowest ino,
why not random ino?

And this step releasing breaks the rule of lru runs.

Some unreferenced file has high hit ratio and some referenced file may
have low hit ratio. Why not release low hit ratio extent tree at first?

Thanks,

