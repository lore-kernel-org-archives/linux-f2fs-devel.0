From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: allow dio read for LFS mode
Date: Fri, 25 Nov 2016 23:54:43 +0800
Message-ID: <22d105b6-3393-eee0-f377-af1ab00141f2@kernel.org>
References: <20161111210304.4736-1-jaegeuk@kernel.org>
	<20161111210304.4736-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1cAIqQ-0004g1-0L
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 15:55:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cAIqO-0000UK-2d
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 15:55:21 +0000
In-Reply-To: <20161111210304.4736-2-jaegeuk@kernel.org>
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

On 2016/11/12 5:03, Jaegeuk Kim wrote:
> We can allow dio reads for LFS mode, while doing buffered writes for dio writes.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ca53da5..996b9ae 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1732,7 +1732,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  
>  	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
>  		return 0;
> -	if (test_opt(F2FS_I_SB(inode), LFS))
> +	if (rw == WRITE && test_opt(F2FS_I_SB(inode), LFS))

For LFS mode, we must disallow any IPU in main area including direct write,
instead of both direct read and write, so this patch relieves the restriction?

IIUC, please add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  		return 0;
>  
>  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
> 

------------------------------------------------------------------------------
