From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: drop calling alloc_nid_failed when
 no nid is allocated
Date: Mon, 27 Feb 2017 10:21:10 +0800
Message-ID: <e1626669-e3bb-c2a4-f8bd-5b882332b033@huawei.com>
References: <77d8220f-8cf4-0af4-3390-cd28fbeb6437@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciAwP-0002G4-VQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 02:21:33 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciAwN-00059i-1R
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 02:21:33 +0000
In-Reply-To: <77d8220f-8cf4-0af4-3390-cd28fbeb6437@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/25 19:23, Kinglong Mee wrote:
> If hsize is less than or equal to inlien_size, and i_xattr_nid is valid, 
> the new_nid is not allocated (no alloc_nid is called).
> 
>        if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
>                 if (!alloc_nid(sbi, &new_nid))
>                         return -ENOSPC;
> 
> Although it's harmless calling alloc_nid_failed, it's better drop them.
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
>  fs/f2fs/xattr.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 7298a44..fd9dc99 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -428,19 +428,18 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>  		/* no need to use xattr node block */
>  		if (hsize <= inline_size) {
>  			err = truncate_xattr_node(inode, ipage);
> -			alloc_nid_failed(sbi, new_nid);

Should keep this since new_nid was assigned above?

> +			f2fs_bug_on(sbi, new_nid);
>  			return err;
>  		}
>  	}
>  
>  	/* write to xattr node block */
>  	if (F2FS_I(inode)->i_xattr_nid) {
> +		f2fs_bug_on(sbi, new_nid);
>  		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
> -		if (IS_ERR(xpage)) {
> -			alloc_nid_failed(sbi, new_nid);
> +		if (IS_ERR(xpage))
>  			return PTR_ERR(xpage);
> -		}
> -		f2fs_bug_on(sbi, new_nid);

Cleanup here looks good to me.

Thanks,

> +
>  		f2fs_wait_on_page_writeback(xpage, NODE, true);
>  	} else {
>  		struct dnode_of_data dn;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
