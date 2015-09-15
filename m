From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fs/f2fs: avoid redundant convert of inline
 inode
Date: Tue, 15 Sep 2015 13:33:33 -0700
Message-ID: <20150915203333.GB82556@jaegeuk-mac02>
References: <1442300909-34483-1-git-send-email-zhenzhang.zhang@huawei.com>
	<55F7C453.2050000@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zbwv9-0008Cl-9S
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 20:33:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zbwv8-00055M-2h for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 20:33:43 +0000
Content-Disposition: inline
In-Reply-To: <55F7C453.2050000@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Zhang Zhen <zhenzhang.zhang@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Zhang,

On Tue, Sep 15, 2015 at 03:10:11PM +0800, Zhang Zhen wrote:
> Encrypted inode for regular file should not have inline_data.
> Here we check encrypted inode before convert of inline inode
> to avoid redundant convert.

When a new file is created in an encrypted dir, it does not set inline_data,
which returns false for the below f2fs_has_inline_data() all the time.
So, I don't think there happens any redundant conversion.

Thanks,

> 
> Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
> ---
>  fs/f2fs/data.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a82abe9..ec2270a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1535,6 +1535,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	size_t count = iov_iter_count(iter);
>  	int err;
> 
> +	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> +		return 0;
> +
>  	/* we don't need to use inline_data strictly */
>  	if (f2fs_has_inline_data(inode)) {
>  		err = f2fs_convert_inline_inode(inode);
> @@ -1542,9 +1545,6 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  			return err;
>  	}
> 
> -	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> -		return 0;
> -
>  	err = check_direct_IO(inode, iter, offset);
>  	if (err)
>  		return err;
> -- 
> 1.9.1
> 
> 
> .
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
