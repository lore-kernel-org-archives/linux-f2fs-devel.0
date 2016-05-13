From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: no need inc dirty pages under inode
	lock
Date: Fri, 13 May 2016 10:13:52 -0700
Message-ID: <20160513171352.GB27525@jaegeuk.gateway>
References: <1463122663-6144-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b1Gf3-000203-IY
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 May 2016 17:14:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b1Gf2-0002om-MG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 May 2016 17:14:01 +0000
Content-Disposition: inline
In-Reply-To: <1463122663-6144-1-git-send-email-heyunlei@huawei.com>
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
Cc: heyunlei@huwei.com, yuchao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

It's just one atomic operation.
Are there performance or race condition issues?

Thanks,

On Fri, May 13, 2016 at 02:57:43PM +0800, Yunlei He wrote:
> No need inc dirty pages under inode lock
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 6402e93..3da6499 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -787,9 +787,9 @@ void update_dirty_page(struct inode *inode, struct page *page)
>  
>  	spin_lock(&sbi->inode_lock[type]);
>  	__add_dirty_inode(inode, type);
> -	inode_inc_dirty_pages(inode);
>  	spin_unlock(&sbi->inode_lock[type]);
>  
> +	inode_inc_dirty_pages(inode);
>  	SetPagePrivate(page);
>  	f2fs_trace_pid(page);
>  }
> -- 
> 1.9.1

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
