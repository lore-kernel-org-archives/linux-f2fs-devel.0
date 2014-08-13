From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 03/13] f2fs: fix the initial inode page
	for	recovery
Date: Wed, 13 Aug 2014 18:17:01 +0800
Message-ID: <009b01cfb6df$d4ba5fe0$7e2f1fa0$@samsung.com>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
	<1407872967-26423-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XHVdB-00037q-FE
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 Aug 2014 10:18:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XHVd4-0006HI-Tn
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 Aug 2014 10:18:09 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NA800EZRPXQWO40@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 Aug 2014 19:17:50 +0900 (KST)
In-reply-to: <1407872967-26423-3-git-send-email-jaegeuk@kernel.org>
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
> Subject: [f2fs-dev] [PATCH 03/13] f2fs: fix the initial inode page for recovery
> 
> If a new inode page is needed for recover_dentry, we should assing i_inline
> as zero.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/node.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 1f33299..093d799 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1651,6 +1651,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
>  	dst->i_blocks = cpu_to_le64(1);
>  	dst->i_links = cpu_to_le32(1);
>  	dst->i_xattr_nid = 0;
> +	dst->i_inline = src->i_inline & F2FS_INLINE_XATTR;
> 
>  	new_ni = old_ni;
>  	new_ni.ino = ino;
> @@ -1659,6 +1660,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
>  		WARN_ON(1);
>  	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
>  	inc_valid_inode_count(sbi);
> +	set_page_dirty(ipage);
>  	f2fs_put_page(ipage, 1);
>  	return 0;
>  }
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
