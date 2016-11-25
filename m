From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix wrong AUTO_RECOVER condition
Date: Fri, 25 Nov 2016 23:40:58 +0800
Message-ID: <d5ae9fc5-d1be-8eb6-ed24-210fdcba73a2@kernel.org>
References: <20161117232958.10931-1-jaegeuk@kernel.org>
	<20161117232958.10931-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1cAIcw-0003QB-Bt
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 15:41:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cAIcu-0003KU-Io
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 15:41:26 +0000
In-Reply-To: <20161117232958.10931-2-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

isize AUTO_RECOVER still be corrupted..., try below case:

1. xfs_io -f /mnt/f2fs/file -c "pwrite 0 4096" -c "fsync"
2. xfs_io -f /mnt/f2fs/file -c "falloc -k 4096 4096" -c "fsync"
3. md5sum /mnt/f2fs/file;
4. godown /mnt/f2fs/
5. umount /mnt/f2fs/
6. mount -t f2fs /dev/sdx /mnt/f2fs
7. md5sum /mnt/f2fs/file

It's hard to deside to recover isize or not when current recovered block is
fallocated, as we can allocate block inside or outside of isize.

Any thoughts?

Thanks,

On 2016/11/18 7:29, Jaegeuk Kim wrote:
> If i_size is not aligned to the f2fs's block size, we should not skip inode
> update during fsync.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f7b986c..68f4887 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1741,7 +1741,8 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
>  		spin_unlock(&sbi->inode_lock[DIRTY_META]);
>  		return ret;
>  	}
> -	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER))
> +	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
> +			i_size_read(inode) & PAGE_MASK)
>  		return false;
>  	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
>  }
> 

------------------------------------------------------------------------------
