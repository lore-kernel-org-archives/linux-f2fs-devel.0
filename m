From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix to update node page under
	cp_rwsem
Date: Fri, 26 Aug 2016 10:04:55 -0700
Message-ID: <20160826170455.GB88444@jaegeuk>
References: <1472228072-4555-1-git-send-email-chao@kernel.org>
	<1472228072-4555-2-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bdKYy-0001ok-7W
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 17:05:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bdKYx-0006HI-06
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 17:05:04 +0000
Content-Disposition: inline
In-Reply-To: <1472228072-4555-2-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sat, Aug 27, 2016 at 12:14:32AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Update node page under cp_rwsem in order to keep data consistency
> during writting checkpoint.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 9ac5efc..1057c73 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -377,8 +377,11 @@ retry:
>  		goto retry;
>  	}
>  
> -	if (err)
> +	if (err) {
> +		f2fs_lock_op(sbi);
>  		update_inode_page(inode);
> +		f2fs_unlock_op(sbi);
> +	}

Any corner case?
Now, it allows updating node page when checkpoint is doing.

Thanks,

>  	sb_end_intwrite(inode->i_sb);
>  no_delete:
>  	stat_dec_inline_xattr(inode);
> -- 
> 2.7.2

------------------------------------------------------------------------------
