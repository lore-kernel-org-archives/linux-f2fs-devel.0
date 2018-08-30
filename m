From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: avoid wrong decrypted data from disk
Date: Thu, 30 Aug 2018 10:20:12 +0800
Message-ID: <ac310f4d-8ad8-bfd9-97f3-66e786f0f51e@huawei.com>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
 <20180830014858.GA91444@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830014858.GA91444@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/8/30 9:48, Jaegeuk Kim wrote:
> 1. Create a file in an encrypted directory
> 2. Do GC & drop caches
> 3. Read stale data before its bio for metapage was not issued yet
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> Change log from v1:
>  - move to bio != NULL
> 
>  fs/f2fs/data.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 382c1ef9a9e4..159e411785e9 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1556,6 +1556,12 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  				bio = NULL;
>  				goto set_error_page;
>  			}
> +		} else if (unlikely(f2fs_encrypted_file(inode))) {

For android scenario, encryption becomes a common case now, so I think we can
remove unlikely here.

> +			/*
> +			 * If the page is under writeback, we need to wait for
> +			 * its completion to see the correct decrypted data.
> +			 */
> +			f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
>  		}

Look at this again, it seems f2fs_wait_on_block_writeback() is not related to
f2fs_grab_read_bio(), so we can move it here to make code logic more clear:

if (f2fs_encrypted_file(inode)) {
	/* */
	f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
}

Also, in f2fs_submit_page_read(), we need to adjust to:

- f2fs_grab_read_bio()
- f2fs_wait_on_block_writeback()
- bio_add_page()

How do you think?

Thanks,

>  
>  		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
> 
