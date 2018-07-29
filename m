From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] mkfs.f2fs: Missing error check statement
 while allocating memory to write the super block.
Date: Sat, 28 Jul 2018 18:17:18 -0700
Message-ID: <20180729011718.GC83620@jaegeuk-macbookpro.roam.corp.google.com>
References: <602FCFCA-C2CF-4BFA-B689-37822AEE5393@cs.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fjaKs-00055J-1I
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 01:17:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fjaKq-001DdZ-Gl
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 01:17:25 +0000
Content-Disposition: inline
In-Reply-To: <602FCFCA-C2CF-4BFA-B689-37822AEE5393@cs.toronto.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 07/26, Sotirios-Efstathios Maneas wrote:
> Added a missing error check statement while allocating memory to write the super block.
> 
> ---
>  mkfs/f2fs_format.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 1a2deae..491a9da 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -975,6 +975,10 @@ static int f2fs_write_super_block(void)
>  	u_int8_t *zero_buff;
>  
>  	zero_buff = calloc(F2FS_BLKSIZE, 1);
> +	if (!zero_buff) {
> +		MSG(1, "\tError: Calloc Failed for f2fs_write_super_block!!!\n");
                                        ------
                                        failed to follow your typo patch?

> +		return -1;
> +	}
>  
>  	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
>  	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
> -- 
> 2.7.4
> 
> Kind regards,
> Stathis Maneas
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
