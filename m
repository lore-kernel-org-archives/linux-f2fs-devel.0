From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] mkfs.f2fs: Fixed typos in several
 printed messages.
Date: Sat, 28 Jul 2018 18:15:09 -0700
Message-ID: <20180729011509.GB83620@jaegeuk-macbookpro.roam.corp.google.com>
References: <0B31334F-7114-4C65-B79F-3BD8D12BAD3E@cs.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fjaIo-0005VP-GN
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 01:15:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fjaIm-001QlC-NK
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 01:15:18 +0000
Content-Disposition: inline
In-Reply-To: <0B31334F-7114-4C65-B79F-3BD8D12BAD3E@cs.toronto.edu>
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
> Fixed typos in several printed messages.

Thanks, merged.

> 
> ---
>  mkfs/f2fs_format.c      | 18 +++++++++---------
>  mkfs/f2fs_format_main.c |  8 ++++----
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 491a9da..d844563 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -586,19 +586,19 @@ static int f2fs_write_check_point_pack(void)
>  
>  	cp = calloc(F2FS_BLKSIZE, 1);
>  	if (cp == NULL) {
> -		MSG(1, "\tError: Calloc Failed for f2fs_checkpoint!!!\n");
> +		MSG(1, "\tError: Calloc failed for f2fs_checkpoint!!!\n");
>  		return ret;
>  	}
>  
>  	sum = calloc(F2FS_BLKSIZE, 1);
>  	if (sum == NULL) {
> -		MSG(1, "\tError: Calloc Failed for summay_node!!!\n");
> +		MSG(1, "\tError: Calloc failed for summary_node!!!\n");
>  		goto free_cp;
>  	}
>  
>  	sum_compact = calloc(F2FS_BLKSIZE, 1);
>  	if (sum_compact == NULL) {
> -		MSG(1, "\tError: Calloc Failed for summay buffer!!!\n");
> +		MSG(1, "\tError: Calloc failed for summary buffer!!!\n");
>  		goto free_sum;
>  	}
>  	sum_compact_p = sum_compact;
> @@ -608,13 +608,13 @@ static int f2fs_write_check_point_pack(void)
>  						F2FS_BLKSIZE - 1);
>  	nat_bits = calloc(F2FS_BLKSIZE, nat_bits_blocks);
>  	if (nat_bits == NULL) {
> -		MSG(1, "\tError: Calloc Failed for nat bits buffer!!!\n");
> +		MSG(1, "\tError: Calloc failed for nat bits buffer!!!\n");
>  		goto free_sum_compact;
>  	}
>  
>  	cp_payload = calloc(F2FS_BLKSIZE, 1);
>  	if (cp_payload == NULL) {
> -		MSG(1, "\tError: Calloc Failed for cp_payload!!!\n");
> +		MSG(1, "\tError: Calloc failed for cp_payload!!!\n");
>  		goto free_nat_bits;
>  	}
>  
> @@ -920,7 +920,7 @@ static int f2fs_write_check_point_pack(void)
>  	}
>  
>  	/* cp page 1 of check point pack 2
> -	 * Initiatialize other checkpoint pack with version zero
> +	 * Initialize other checkpoint pack with version zero
>  	 */
>  	cp->checkpoint_ver = 0;
>  
> @@ -1634,13 +1634,13 @@ int f2fs_format_device(void)
>  
>  	err = f2fs_init_sit_area();
>  	if (err < 0) {
> -		MSG(0, "\tError: Failed to Initialise the SIT AREA!!!\n");
> +		MSG(0, "\tError: Failed to initialise the SIT AREA!!!\n");
>  		goto exit;
>  	}
>  
>  	err = f2fs_init_nat_area();
>  	if (err < 0) {
> -		MSG(0, "\tError: Failed to Initialise the NAT AREA!!!\n");
> +		MSG(0, "\tError: Failed to initialise the NAT AREA!!!\n");
>  		goto exit;
>  	}
>  
> @@ -1658,7 +1658,7 @@ int f2fs_format_device(void)
>  
>  	err = f2fs_write_super_block();
>  	if (err < 0) {
> -		MSG(0, "\tError: Failed to write the Super Block!!!\n");
> +		MSG(0, "\tError: Failed to write the super block!!!\n");
>  		goto exit;
>  	}
>  exit:
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index 449a0ed..0024393 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -193,22 +193,22 @@ static void f2fs_parse_options(int argc, char *argv[])
>  
>  	if (!(c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR))) {
>  		if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
> -			MSG(0, "\tInfo: project quota feature should always been"
> +			MSG(0, "\tInfo: project quota feature should always be "
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
>  		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) {
> -			MSG(0, "\tInfo: inode checksum feature should always been"
> +			MSG(0, "\tInfo: inode checksum feature should always be "
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
>  		if (c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) {
> -			MSG(0, "\tInfo: flexible inline xattr feature should always been"
> +			MSG(0, "\tInfo: flexible inline xattr feature should always be "
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
>  		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
> -			MSG(0, "\tInfo: inode crtime feature should always been"
> +			MSG(0, "\tInfo: inode crtime feature should always be "
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
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
