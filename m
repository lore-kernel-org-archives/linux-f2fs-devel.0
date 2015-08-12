From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: do not write any node pages related to
	orphan inodes
Date: Wed, 12 Aug 2015 17:45:28 +0800
Message-ID: <00b901d0d4e3$b9a4e2c0$2ceea840$@samsung.com>
References: <1439330562-17646-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1439330562-17646-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, August 12, 2015 6:03 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH] f2fs: do not write any node pages related to orphan inodes
> 
> We should not write node pages when deleting orphan inodes.
> In order to do that, we can eaisly set POR_DOING flag earlier before entering
> orphan inode routine.

If no error occurs in recover_orphan_inodes, it will clear SBI_POR_DOING before
return, so our protect region is broken since we remove SBI_POR_DOING setting in
the beginning of recover_fsync_data.

How about removing all SBI_POR_DOING related ops in recover_orphan_inodes?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/recovery.c | 3 ---
>  fs/f2fs/super.c    | 6 +++++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index d2ef0c9..cdcca7c 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -545,9 +545,6 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
> 
>  	INIT_LIST_HEAD(&inode_list);
> 
> -	/* step #1: find fsynced inode numbers */

Nitpick, this makes the left comment "/* step #2: recover data */" looks
strange, how about modifying the left one too?

Thanks,
