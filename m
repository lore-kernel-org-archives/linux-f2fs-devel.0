From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: fix to preallocate block only
	aligned to 4K
Date: Thu, 25 Aug 2016 17:24:42 +0800
Message-ID: <3dca4862-5722-154c-301d-7bf81a18e8ea@huawei.com>
References: <20160820071202.31355-1-yuchao0@huawei.com>
	<20160823231909.GA77787@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bcqvX-0005Kw-1m
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 09:26:23 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bcqvR-0002TQ-KF
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 09:26:23 +0000
In-Reply-To: <20160823231909.GA77787@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2016/8/24 7:19, Jaegeuk Kim wrote:
> Hi Chao,
> 
> There is a bug when ki_pos = 1024, and iov_iter_count(from) = 1024 in xfstests.
> Could you check the below patch to fix your one?

Oh, you're right, thanks for fixing it. :)

Thanks,

> 
> ---
>  fs/f2fs/data.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 37a59f7..7c8e219 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -626,8 +626,12 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  	ssize_t ret = 0;
>  
>  	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
> -	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from)) -
> -								map.m_lblk;
> +	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
> +	if (map.m_len > map.m_lblk)
> +		map.m_len -= map.m_lblk;
> +	else
> +		map.m_len = 0;
> +
>  	map.m_next_pgofs = NULL;
>  
>  	if (f2fs_encrypted_inode(inode))
> @@ -673,6 +677,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	bool allocated = false;
>  	block_t blkaddr;
>  
> +	if (!maxblocks)
> +		return 0;
> +
>  	map->m_len = 0;
>  	map->m_flags = 0;
>  
> 


------------------------------------------------------------------------------
