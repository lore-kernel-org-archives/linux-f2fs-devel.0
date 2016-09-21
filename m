From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH v2] f2fs: preallocate blocks for
 encrypted file
Date: Tue, 20 Sep 2016 17:42:10 -0700
Message-ID: <20160921003820.GA77057@jaegeuk>
References: <1474157816-15003-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bmVcC-0003FS-VE
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Sep 2016 00:42:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bmVcB-00059g-PF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Sep 2016 00:42:20 +0000
Content-Disposition: inline
In-Reply-To: <1474157816-15003-1-git-send-email-heyunlei@huawei.com>
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

Hi Yunlei,

I'll add the below bug fix into your patch.

---
 fs/f2fs/segment.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index abf1c3d..e78501c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1653,11 +1653,9 @@ void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
 {
 	struct page *cpage;
 
-	if (blkaddr == NEW_ADDR)
+	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
 		return;
 
-	f2fs_bug_on(sbi, blkaddr == NULL_ADDR);
-
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
 	if (cpage) {
 		f2fs_wait_on_page_writeback(cpage, DATA, true);
-- 
2.8.3

Thanks,

On Sun, Sep 18, 2016 at 08:16:56AM +0800, Yunlei He wrote:
> This patch allow preallocates data blocks for buffered aio writes
> in encrypted file.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/data.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3e0ef2d..932166e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -639,9 +639,6 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  
>  	map.m_next_pgofs = NULL;
>  
> -	if (f2fs_encrypted_inode(inode))
> -		return 0;
> -
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		ret = f2fs_convert_inline_inode(inode);
>  		if (ret)
> @@ -1532,8 +1529,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>  	 * we already allocated all the blocks, so we don't need to get
>  	 * the block addresses when there is no need to fill the page.
>  	 */
> -	if (!f2fs_has_inline_data(inode) && !f2fs_encrypted_inode(inode) &&
> -					len == PAGE_SIZE)
> +	if (!f2fs_has_inline_data(inode) && len == PAGE_SIZE)
>  		return 0;
>  
>  	if (f2fs_has_inline_data(inode) ||
> -- 
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
