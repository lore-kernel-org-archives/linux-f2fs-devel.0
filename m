From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid wrong decrypted data from disk
Date: Thu, 30 Aug 2018 11:59:03 +0530
Message-ID: <20180830062903.GC12489@codeaurora.org>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827225226.14272-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Aug 27, 2018 at 03:52:26PM -0700, Jaegeuk Kim wrote:
> 1. Create a file in an encrypted directory
> 2. Do GC & drop caches
> 3. Read stale data before its bio for metapage was not issued yet
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 382c1ef9a9e4..c3557fd4a0bd 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1550,6 +1550,13 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  			bio = NULL;
>  		}
>  		if (bio == NULL) {
> +			/*
> +			 * If the page is under writeback, we need to wait for
> +			 * its completion to see the correct decrypted data.
> +			 */
> +			if (unlikely(f2fs_encrypted_file(inode)))
> +				f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
> +

I am not sure if this really helps the case.

When the data is being moved by GC, the writeback is set on the encrypted page
which belongs to meta mapping. But before that writeback could complete, the read
will happen on the original file where it's corresponding page will not have any
writeback set, right?

>  			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
>  					is_readahead ? REQ_RAHEAD : 0);
>  			if (IS_ERR(bio)) {
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
