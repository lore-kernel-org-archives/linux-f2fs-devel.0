From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] f2fs: Introduce lifetime write IO statistics
Date: Sat, 20 Feb 2016 18:08:02 +0100
Message-ID: <20160220170802.GB4662@amd>
References: <1453778182-66323-1-git-send-email-liushuoran@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453778182-66323-1-git-send-email-liushuoran@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liu Shuoran <liushuoran@huawei.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi!

> From: Shuoran Liu <liushuoran@huawei.com>
> 
> Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
> Signed-off-by: Pengyang Hou <houpengyang@huawei.com>

> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -921,6 +921,10 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	int cp_payload_blks = __cp_payload(sbi);
>  	block_t discard_blk = NEXT_FREE_BLKADDR(sbi, curseg);
>  	bool invalidate = false;
> +	struct super_block *sb = sbi->sb;
> +	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
> +	__u64 kbytes_written;
> +

No need to __prefix in kernel.

> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h

> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index e59c3be..05ae034 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -387,6 +387,11 @@ struct sit_journal {
>  	__u8 reserved[SIT_JOURNAL_RESERVED];
>  } __packed;
>  
> +struct f2fs_extra_info {
> +	__le64 kbytes_written;
> +	__u8 reserved[SUM_JOURNAL_SIZE - 10];
> +} __packed;
> +

Unless this is exported to userspace, no need for __ here, either.

(Would it make sense to store bytes_written, as it is not going to
overflow, anyway?)

Is this going to be exported to userspace somehow?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
