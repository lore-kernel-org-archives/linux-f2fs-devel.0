From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: avoid wrong decrypted data from disk
Date: Wed, 29 Aug 2018 10:14:32 +0800
Message-ID: <40e115de-0ec8-62e8-098a-57263b62595f@huawei.com>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827225226.14272-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/8/28 6:52, Jaegeuk Kim wrote:
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

I think we have did this in f2fs_grab_read_bio(), so we just need to cover 'bio
!= NULL' case, right?

Thanks,

> +
>  			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
>  					is_readahead ? REQ_RAHEAD : 0);
>  			if (IS_ERR(bio)) {
> 
