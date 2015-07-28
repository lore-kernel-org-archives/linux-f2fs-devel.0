From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: handle error cases
	in	commit_inmem_pages
Date: Tue, 28 Jul 2015 18:25:26 +0800
Message-ID: <00e301d0c91f$d303dfc0$790b9f40$@samsung.com>
References: <1437870077-46892-1-git-send-email-jaegeuk@kernel.org>
	<1437870077-46892-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZK25Q-0001Mn-8Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 10:26:16 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZK25O-0007V6-6a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 10:26:16 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NS700GFQ0ZFAV70@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 19:26:06 +0900 (KST)
In-reply-to: <1437870077-46892-2-git-send-email-jaegeuk@kernel.org>
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
> Sent: Sunday, July 26, 2015 8:21 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/2] f2fs: handle error cases in commit_inmem_pages
> 
> This patch adds to handle error cases in commit_inmem_pages.
> If an error occurs, it stops to write the pages and return the error right
> away.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |  2 +-
>  fs/f2fs/file.c    |  6 ++++--
>  fs/f2fs/segment.c | 10 ++++++++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e73f2e2..58b05b5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1697,7 +1697,7 @@ void destroy_node_manager_caches(void);
>   * segment.c
>   */
>  void register_inmem_page(struct inode *, struct page *);
> -void commit_inmem_pages(struct inode *, bool);
> +int commit_inmem_pages(struct inode *, bool);
>  void f2fs_balance_fs(struct f2fs_sb_info *);
>  void f2fs_balance_fs_bg(struct f2fs_sb_info *);
>  int f2fs_issue_flush(struct f2fs_sb_info *);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 25d1a2f..a2b3656 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1358,7 +1358,9 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> 
>  	if (f2fs_is_atomic_file(inode)) {
>  		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
> -		commit_inmem_pages(inode, false);
> +		ret = commit_inmem_pages(inode, false);
> +		if (ret)
> +			return ret;
>  	}
> 
>  	ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
> @@ -1418,7 +1420,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
> 
>  	if (f2fs_is_atomic_file(inode)) {
>  		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
> -		commit_inmem_pages(inode, false);
> +		commit_inmem_pages(inode, true);
>  	}
> 
>  	if (f2fs_is_volatile_file(inode))
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f7bfc3b..509a2c4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -227,7 +227,7 @@ retry:
>  	trace_f2fs_register_inmem_page(page, INMEM);
>  }
> 
> -void commit_inmem_pages(struct inode *inode, bool abort)
> +int commit_inmem_pages(struct inode *inode, bool abort)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> @@ -239,6 +239,7 @@ void commit_inmem_pages(struct inode *inode, bool abort)
>  		.rw = WRITE_SYNC | REQ_PRIO,
>  		.encrypted_page = NULL,
>  	};
> +	int err = 0;
> 
>  	/*
>  	 * The abort is true only when f2fs_evict_inode is called.
> @@ -263,8 +264,12 @@ void commit_inmem_pages(struct inode *inode, bool abort)
>  					inode_dec_dirty_pages(inode);
>  				trace_f2fs_commit_inmem_page(cur->page, INMEM);
>  				fio.page = cur->page;
> -				do_write_data_page(&fio);
> +				err = do_write_data_page(&fio);
>  				submit_bio = true;
> +				if (err) {
> +					unlock_page(cur->page);

Shouldn't we invoke f2fs_put_page(,1) here?

> +					break;
> +				}
>  			}
>  			f2fs_put_page(cur->page, 1);
>  		} else {
> @@ -283,6 +288,7 @@ void commit_inmem_pages(struct inode *inode, bool abort)
>  		if (submit_bio)
>  			f2fs_submit_merged_bio(sbi, DATA, WRITE);
>  	}
> +	return err;
>  }
> 
>  /*
> --
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
