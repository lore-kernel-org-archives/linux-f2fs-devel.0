From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 04/13] f2fs: clear FI_INC_LINK during the
 recovery
Date: Wed, 13 Aug 2014 18:18:13 +0800
Message-ID: <009c01cfb6e0$07d4f480$177edd80$@samsung.com>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
	<1407872967-26423-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XHVeh-0003KU-0U
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 Aug 2014 10:19:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XHVef-0007RU-HR
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 Aug 2014 10:19:42 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NA80026GQ04FFB0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 Aug 2014 19:19:16 +0900 (KST)
In-reply-to: <1407872967-26423-4-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, August 13, 2014 3:49 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 04/13] f2fs: clear FI_INC_LINK during the recovery
> 
> If an inode are fsynced multiple times with fsync & dent marks, this inode will
> set FI_INC_LINK at find_fsync_dnodes during the recovery.
> But, in recover_inode, recover_dentry doesn't clear that flag when multiple hits
> were occurred.
> 
> So this patch removes the flag for the further consistency.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/recovery.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index fe1c6d9..cfb2aa9 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -62,8 +62,10 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
>  	}
>  retry:
>  	de = f2fs_find_entry(dir, &name, &page);
> -	if (de && inode->i_ino == le32_to_cpu(de->ino))
> +	if (de && inode->i_ino == le32_to_cpu(de->ino)) {
> +		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
>  		goto out_unmap_put;
> +	}
>  	if (de) {
>  		einode = f2fs_iget(inode->i_sb, le32_to_cpu(de->ino));
>  		if (IS_ERR(einode)) {
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
