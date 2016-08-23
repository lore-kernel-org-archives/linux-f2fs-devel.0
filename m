From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: fix to preallocate block only aligned to 4K
Date: Tue, 23 Aug 2016 16:19:09 -0700
Message-ID: <20160823231909.GA77787@jaegeuk>
References: <20160820071202.31355-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160820071202.31355-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

There is a bug when ki_pos = 1024, and iov_iter_count(from) = 1024 in xfstests.
Could you check the below patch to fix your one?

---
 fs/f2fs/data.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 37a59f7..7c8e219 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -626,8 +626,12 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret = 0;
 
 	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
-	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from)) -
-								map.m_lblk;
+	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
+	if (map.m_len > map.m_lblk)
+		map.m_len -= map.m_lblk;
+	else
+		map.m_len = 0;
+
 	map.m_next_pgofs = NULL;
 
 	if (f2fs_encrypted_inode(inode))
@@ -673,6 +677,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	bool allocated = false;
 	block_t blkaddr;
 
+	if (!maxblocks)
+		return 0;
+
 	map->m_len = 0;
 	map->m_flags = 0;
 
-- 
2.8.3

Thanks,

On Sat, Aug 20, 2016 at 03:12:01PM +0800, Chao Yu wrote:
> In write_begin(), we skip checking dnode block for preallocating block
> when whole block needs to be updated since we preallocated its block in
> f2fs_preallocate_blocks, for partial updated block, we will still try
> to lock its node and do preallocation in write_begin(), so in
> f2fs_preallocate_blocks we should not preallocate its block.
> 
> But previously, the calculation of preallocating block number is
> incorrect, fix it.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ccb401e..dee3a78 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -626,7 +626,8 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  	ssize_t ret = 0;
>  
>  	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
> -	map.m_len = F2FS_BYTES_TO_BLK(iov_iter_count(from));
> +	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from)) -
> +								map.m_lblk;
>  	map.m_next_pgofs = NULL;
>  
>  	if (f2fs_encrypted_inode(inode))
> -- 
> 2.8.2.311.gee88674
