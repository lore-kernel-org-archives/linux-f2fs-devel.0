From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 08/13 v2] f2fs: do checkpoint
	at	f2fs_put_super
Date: Tue, 19 Aug 2014 14:41:44 +0800
Message-ID: <002e01cfbb78$bf297ab0$3d7c7010$@samsung.com>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
	<1407872967-26423-8-git-send-email-jaegeuk@kernel.org>
	<20140815215818.GB53769@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XJd7w-0008N1-7Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Aug 2014 06:42:40 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XJd7u-0002uW-6o
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Aug 2014 06:42:40 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NAJ00K06JYU7UD0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Aug 2014 15:42:30 +0900 (KST)
In-reply-to: <20140815215818.GB53769@jaegeuk-mac02.mot.com>
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

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, August 16, 2014 5:58 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 08/13 v2] f2fs: do checkpoint at f2fs_put_super
> 
> Change log from v1:
>  o relocate F2FS_SET_SB_DIRT to avoid unnecessary checkpoints

In umount, we will encounter memory leak as we may skip releasing dirty inode
when IO error occurred in cp. Why not just invoking release_dirty_inode directly
in f2fs_put_super?

Thanks,
Yu

> 
> The generic_shutdown_super calls sync_filesystem, evict_inode, and then
> f2fs_put_super. In f2fs_evict_inode, we remain some dirty inode information
> so we should release them at f2fs_put_super.
> 
> But normally, it's more reasonable to set its superblock as dirty when
> evict_inode is called.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 1 +
>  fs/f2fs/super.c      | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 7e1c13b..01e1796 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -330,6 +330,7 @@ void add_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
>  {
>  	/* add new dirty ino entry into list */
>  	__add_ino_entry(sbi, ino, type);
> +	F2FS_SET_SB_DIRT(sbi);
>  }
> 
>  void remove_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 633315a..60e3554 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -432,7 +432,7 @@ static void f2fs_put_super(struct super_block *sb)
>  	stop_gc_thread(sbi);
> 
>  	/* We don't need to do checkpoint when it's clean */
> -	if (sbi->s_dirty && get_pages(sbi, F2FS_DIRTY_NODES))
> +	if (sbi->s_dirty)
>  		write_checkpoint(sbi, true);
> 
>  	iput(sbi->node_inode);
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
