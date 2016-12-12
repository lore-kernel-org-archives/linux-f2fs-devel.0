From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix conflict between atomic_write and
 truncate
Date: Mon, 12 Dec 2016 11:18:51 -0800
Message-ID: <20161212191851.GC61413@jaegeuk.local>
References: <20161212131618.92800-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cGW7o-0004dW-NC
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 19:19:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cGW7n-0000UT-Jo
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 19:19:00 +0000
Content-Disposition: inline
In-Reply-To: <20161212131618.92800-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Pengyang,

On 12/12, Hou Pengyang wrote:
> In fsync_node_pages path, after locking the last_page for setting dirty,
> we should check if the page has been truncated. Or there may be a mem leak,
> as this dirty last_page will NOT be found in next page-cache travese.
> 
> This patch adds page->mapping checking, and will NOT rewrite the page if
> it has been truncated.
> 
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> ---
>  fs/f2fs/node.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index c1bbfdc..78c5b50 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1410,6 +1410,11 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  			"Retry to write fsync mark: ino=%u, idx=%lx",
>  					ino, last_page->index);
>  		lock_page(last_page);

We grabbed a reference count for this last_page, and thus, it won't be released.
Something that I missed?

Thanks,

> +		if (unlikely(last_page->mapping != NODE_MAPPING(sbi))) {
> +			unlock_page(last_page);
> +			f2fs_put_page(last_page, 0);
> +			goto out;
> +		}
>  		f2fs_wait_on_page_writeback(last_page, NODE, true);
>  		set_page_dirty(last_page);
>  		unlock_page(last_page);
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today.http://sdm.link/xeonphi
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
