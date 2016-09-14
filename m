From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH] f2fs: preallocate blocks for encrypted
 file
Date: Wed, 14 Sep 2016 16:56:15 -0700
Message-ID: <20160914235615.GA50095@jaegeuk>
References: <1473847615-2793-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bkK2U-0007rn-Rr
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Sep 2016 23:56:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bkK2T-0007mk-1g
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Sep 2016 23:56:26 +0000
Content-Disposition: inline
In-Reply-To: <1473847615-2793-1-git-send-email-heyunlei@huawei.com>
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

On Wed, Sep 14, 2016 at 06:06:55PM +0800, Yunlei He wrote:
> This patch allow preallocates data blocks for buffered aio writes
> in encrypted file.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/data.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3e0ef2d..529e9a2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -639,9 +639,6 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  
>  	map.m_next_pgofs = NULL;
>  
> -	if (f2fs_encrypted_inode(inode))
> -		return 0;
> -

Then, it needs to remove the condition in prepare_write_begin() as well.

Thanks,

>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		ret = f2fs_convert_inline_inode(inode);
>  		if (ret)
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
