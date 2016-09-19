From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH v2] f2fs: preallocate blocks for
 encrypted file
Date: Mon, 19 Sep 2016 08:36:48 +0800
Message-ID: <7a2a6c6e-b454-84fe-6550-fa3904c343ee@huawei.com>
References: <1474157816-15003-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1blmaB-0001Yh-G9
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Sep 2016 00:37:15 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1blma5-0008Jt-Vq
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Sep 2016 00:37:15 +0000
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
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: heyunlei@huwei.com

On 2016/9/18 8:16, Yunlei He wrote:
> This patch allow preallocates data blocks for buffered aio writes
> in encrypted file.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

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
> 


------------------------------------------------------------------------------
