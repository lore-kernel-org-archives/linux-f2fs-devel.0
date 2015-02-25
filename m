From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix recover orphan inodes
Date: Wed, 25 Feb 2015 10:35:23 -0800
Message-ID: <20150225183403.GA51593@jaegeuk-mac02.mot.com>
References: <1424840017-97604-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424840017-97604-1-git-send-email-wanpeng.li@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wanpeng Li <wanpeng.li@linux.intel.com>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Wanpeng,

On Wed, Feb 25, 2015 at 12:53:37PM +0800, Wanpeng Li wrote:
> recover_orphan_inodes is used to recover orphan inodes, the meta pages 
> which readahead should be orphan_blkaddr - start_blk instead of orphan_blkaddr.
> This patch fix it.
> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
> ---
>  fs/f2fs/checkpoint.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index e6c271f..0f42ff3 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -468,9 +468,9 @@ void recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  		le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);

Actually it seems the name, orphan_blkaddr, was wrong.
That should be orphan_blocks which is no need to fix like this.

Instead, I found there is another bug below.

>  	orphan_blkaddr = __start_sum_addr(sbi) - 1;
        orphan_blocks = __start_sum_addr(sbi) - 1 - 
			le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);

It may help to define a macro to get cp_payload.

>  
> -	ra_meta_pages(sbi, start_blk, orphan_blkaddr, META_CP);
> +	ra_meta_pages(sbi, start_blk, orphan_blkaddr - start_blk, META_CP);

The orphan_blocks is enough. No need to fix this.

>  
> -	for (i = 0; i < orphan_blkaddr; i++) {
> +	for (i = 0; i < orphan_blkaddr - start_blk; i++) {

ditto.

Thanks,
