From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: walk around a panic caused by nrpages
 is not zero in clear_inode
Date: Tue, 6 Sep 2016 18:47:05 -0700
Message-ID: <20160907014705.GC10307@jaegeuk>
References: <1473124652-31921-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bhRxL-0006NW-8q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Sep 2016 01:47:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bhRxJ-0002XH-U7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Sep 2016 01:47:15 +0000
Content-Disposition: inline
In-Reply-To: <1473124652-31921-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: heyunlei@huwei.com, linux-f2fs-devel@lists.sourceforge.net

On Tue, Sep 06, 2016 at 09:17:32AM +0800, Yunlei He wrote:
> I came across a panic twice:
> 
> [<ffffffc000088e70>] dump_backtrace+0x0/0x124
> [<ffffffc000088fb4>] show_stack+0x14/0x1c
> [<ffffffc000ce1c38>] dump_stack+0x20/0x28
> [<ffffffc000cdfbd4>] panic+0x13c/0x258
> [<ffffffc0001b2244>] clear_inode+0x8c/0xd4
> [<ffffffc00030575c>] f2fs_evict_inode+0x194/0x3e0
> [<ffffffc0001b30b4>] evict+0xa0/0x1cc
> [<ffffffc0001b399c>] iput+0xe4/0x180
> [<ffffffc0003274fc>] recover_fsync_data+0x6ec/0xe5c
> [<ffffffc00030d420>] f2fs_fill_super+0xa5c/0xb9c
> [<ffffffc00019cd00>] mount_bdev+0x1ac/0x1d4
> [<ffffffc00030b66c>] f2fs_mount+0x14/0x1c
> [<ffffffc00019d5e4>] mount_fs+0x3c/0x1bc
> [<ffffffc0001b7560>] vfs_kern_mount+0x4c/0xf0
> [<ffffffc0001b9970>] do_mount+0x218/0x960
> [<ffffffc0001ba148>] SyS_mount+0x90/0xd0

Hmm, could you share the previous recovery messages?
In the truncation part, f2fs_evict_inode starts with setting i_size to zero.
So, the only possible way would be caused by enabled cache_only given by an
inline_data case. But the assumption is that inode must have more than 2
i_blocks, which is not normal case though.

Can we gather more information to narrow down the root cause?

BTW, I found that the below grab_cache_page() should be find_lock_page() to
check its cached page only.

>From a584542d25e7dfc91af53a8f4a4866b939d29fef Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 6 Sep 2016 15:55:54 -0700
Subject: [PATCH] f2fs: avoid page allocation for truncating partial
 inline_data

When truncating cached inline_data, we don't need to allocate a new page
all the time. Instead, it must check its page cache only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a8aa6fd..0144ed4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -562,7 +562,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		return 0;
 
 	if (cache_only) {
-		page = f2fs_grab_cache_page(mapping, index, false);
+		page = find_lock_page(mapping, index);
 		if (page && PageUptodate(page))
 			goto truncate_out;
 		f2fs_put_page(page, 1);
-- 
2.8.3

> 
> Here, the nrpages in i_mapping in not zero but one. Maybe it's
> caused by grabing cache page in truncate_partial_data_page. So
> this patch walk around it.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 37c24be..7d1c3f3 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -561,6 +561,12 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
>  	if (!offset && !cache_only)
>  		return 0;
>  
> +	if (!offset && inode->i_state & I_FREEING)
> +		return 0;
> +
> +	if (index > F2FS_I_SB(inode)->max_file_blocks)
> +		return 0;
> +
>  	if (cache_only) {
>  		page = f2fs_grab_cache_page(mapping, index, false);
>  		if (page && PageUptodate(page))
> -- 
> 1.9.1

------------------------------------------------------------------------------
