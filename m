From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v2] f2fs: refactor bio-related operations
Date: Wed, 04 Dec 2013 14:01:05 +0800
Message-ID: <001101cef0b6$562766e0$027634a0$@samsung.com>
References: <1385792739-31405-1-git-send-email-jaegeuk.kim@samsung.com>
 <1385972847.2417.113.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1385972847.2417.113.camel@kjgkr>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

Comment as following.

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Monday, December 02, 2013 4:27 PM
> To: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: refactor bio-related operations
> 
> Change log from v1:
>  o remove redundant codes
> 
> >From a480dfc915490f4bca7275f6fbb44fa34aa00eaa Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> Date: Sat, 30 Nov 2013 12:51:14 +0900
> Subject: [PATCH] f2fs: refactor bio-related operations
> Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
> 
> This patch integrates redundant bio operations on read and write IOs.
> 
> 1. Move bio-related codes to the top of data.c.
> 2. Replace f2fs_submit_bio with f2fs_submit_merged_bio, which handles read
>    bios additionally.
> 3. Introduce __submit_merged_bio to submit the merged bio.
> 4. Change f2fs_readpage to f2fs_submit_page_bio.
> 5. Introduce f2fs_submit_page_mbio to integrate previous submit_read_page and
>    submit_write_page.

[snip]

> +static void __submit_merged_bio(struct f2fs_sb_info *sbi,
> +				struct f2fs_bio_info *io,
> +				enum page_type type, bool sync, int rw)
> +{
> +	enum page_type btype = PAGE_TYPE_OF_BIO(type);
> +
> +	if (!io->bio)
> +		return;
> +
> +	if (btype == META)
> +		rw |= REQ_META;
> +
> +	if (is_read_io(rw)) {
> +		if (sync)
> +			rw |= READ_SYNC;
> +		submit_bio(rw, io->bio);
> +		trace_f2fs_submit_read_bio(sbi->sb, rw, type, io->bio);
> +		io->bio = NULL;
> +		return;
> +	}
> +
> +	if (sync)
> +		rw |= WRITE_SYNC;

rw = WRITE_SYNC; ?

> +	if (type >= META_FLUSH)
> +		rw |= WRITE_FLUSH_FUA;

rw = WRITE_FLUSH_FUA; ?

> +
> +	/*
> +	 * META_FLUSH is only from the checkpoint procedure, and we should wait
> +	 * this metadata bio for FS consistency.
> +	 */
> +	if (type == META_FLUSH) {
> +		DECLARE_COMPLETION_ONSTACK(wait);
> +		io->bio->bi_private = &wait;
> +		submit_bio(rw, io->bio);
> +		wait_for_completion(&wait);
> +	} else {
> +		submit_bio(rw, io->bio);
> +	}
> +	trace_f2fs_submit_write_bio(sbi->sb, rw, btype, io->bio);
> +	io->bio = NULL;
> +}

[snip]

Thanks,
Yu
