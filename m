From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] libf2fs: Track AOSP libsparse API change.
Date: Mon, 30 Apr 2018 13:45:23 -0700
Message-ID: <20180430204523.GA6129@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180426074009.36270-1-tbao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fDFfv-0005fI-SK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Apr 2018 20:45:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fDFfu-00G3q4-6C
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Apr 2018 20:45:31 +0000
Content-Disposition: inline
In-Reply-To: <20180426074009.36270-1-tbao@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Tao Bao <tbao@google.com>
Cc: jaegeuk@google.com, linux-f2fs-devel@lists.sourceforge.net

Merged.
Thanks,

On 04/26, Tao Bao via Linux-f2fs-devel wrote:
> The libsparse in AOSP is updating the type for 'len', from 'int' to
> 'size_t', in the callback parameter of sparse_file_foreach_chunk(). The
> value represents a chunk size, which could be legitimately larger than
> INT_MAX. This patch tracks the libsparse API change.
> 
> The change is guarded with SPARSE_CALLBACK_USES_SIZE_T that's exposed as
> part of the libsparse change. This allows f2fs-tools to keep working
> against older libsparse versions.
> 
> Signed-off-by: Tao Bao <tbao@google.com>
> ---
>  lib/libf2fs_io.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
> index 4781517..76d283d 100644
> --- a/lib/libf2fs_io.c
> +++ b/lib/libf2fs_io.c
> @@ -114,8 +114,13 @@ static int sparse_write_blk(__u64 block, int count, const void *buf)
>  	return 0;
>  }
>  
> +#ifdef SPARSE_CALLBACK_USES_SIZE_T
> +static int sparse_import_segment(void *UNUSED(priv), const void *data,
> +		size_t len, unsigned int block, unsigned int nr_blocks)
> +#else
>  static int sparse_import_segment(void *UNUSED(priv), const void *data, int len,
>  		unsigned int block, unsigned int nr_blocks)
> +#endif
>  {
>  	/* Ignore chunk headers, only write the data */
>  	if (!nr_blocks || len % F2FS_BLKSIZE)
> -- 
> 2.17.0.484.g0c8726318c-goog
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
