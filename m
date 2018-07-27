From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] mkfs.f2fs: Fix the checkpoint version
 written to the footer of the root inode
Date: Fri, 27 Jul 2018 19:07:27 +0900
Message-ID: <20180727100727.GE16155@jaegeuk-macbookpro.roam.corp.google.com>
References: <E9C77C37-B3B8-4B76-A2F9-66B5A5A0183D@cs.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fj6JD-0004cf-Qr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 17:13:43 +0000
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fj6JB-0001Bb-92
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 17:13:43 +0000
Content-Disposition: inline
In-Reply-To: <E9C77C37-B3B8-4B76-A2F9-66B5A5A0183D@cs.toronto.edu>
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

On 07/23, Sotirios-Efstathios Maneas wrote:
> Dear all,
> 
> The following patch fixes the checkpoint version written to the footer of the inode associated with the root directory, while creating
> the file system from scratch. Furthermore, the patch fixes some typos in the printed messages.
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 1a2deae..25febd1 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -28,6 +28,7 @@ extern struct f2fs_configuration c;
>  struct f2fs_super_block raw_sb;
>  struct f2fs_super_block *sb = &raw_sb;
>  struct f2fs_checkpoint *cp;
> +int f2fs_checkpoint_version;
>  
>  /* Return first segment number of each area */
>  #define prev_zone(cur)		(c.cur_seg[cur] - c.segs_per_zone)
> @@ -592,13 +593,13 @@ static int f2fs_write_check_point_pack(void)
>  
>  	sum = calloc(F2FS_BLKSIZE, 1);
>  	if (sum == NULL) {
> -		MSG(1, "\tError: Calloc Failed for summay_node!!!\n");
> +		MSG(1, "\tError: Calloc Failed for summary_node!!!\n");
>  		goto free_cp;
>  	}
>  
>  	sum_compact = calloc(F2FS_BLKSIZE, 1);
>  	if (sum_compact == NULL) {
> -		MSG(1, "\tError: Calloc Failed for summay buffer!!!\n");
> +		MSG(1, "\tError: Calloc Failed for summary buffer!!!\n");
>  		goto free_sum;
>  	}
>  	sum_compact_p = sum_compact;
> @@ -619,8 +620,7 @@ static int f2fs_write_check_point_pack(void)
>  	}
>  
>  	/* 1. cp page 1 of checkpoint pack 1 */
> -	srand(time(NULL));
> -	cp->checkpoint_ver = cpu_to_le64(rand() | 0x1);
> +	cp->checkpoint_ver = cpu_to_le64(f2fs_checkpoint_version);
>  	set_cp(cur_node_segno[0], c.cur_seg[CURSEG_HOT_NODE]);
>  	set_cp(cur_node_segno[1], c.cur_seg[CURSEG_WARM_NODE]);
>  	set_cp(cur_node_segno[2], c.cur_seg[CURSEG_COLD_NODE]);
> @@ -920,7 +920,7 @@ static int f2fs_write_check_point_pack(void)
>  	}
>  
>  	/* cp page 1 of check point pack 2
> -	 * Initiatialize other checkpoint pack with version zero
> +	 * Initialise other checkpoint pack with version zero
>  	 */
>  	cp->checkpoint_ver = 0;
>  
> @@ -975,6 +975,10 @@ static int f2fs_write_super_block(void)
>  	u_int8_t *zero_buff;
>  
>  	zero_buff = calloc(F2FS_BLKSIZE, 1);
> +	if (!zero_buff) {
> +		MSG(1, "\tError: Calloc Failed for f2fs_write_super_block!!!\n");
> +		return -1;
> +	}
>  
>  	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
>  	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
> @@ -1057,9 +1061,12 @@ static int f2fs_write_root_inode(void)
>  		return -1;
>  	}
>  
> +	srand(time(NULL));
> +	f2fs_checkpoint_version = rand() | 0x1;
> +
>  	raw_node->footer.nid = sb->root_ino;
>  	raw_node->footer.ino = sb->root_ino;
> -	raw_node->footer.cp_ver = cpu_to_le64(1);
> +	raw_node->footer.cp_ver = cpu_to_le64(f2fs_checkpoint_version);

We don't check this cp version in f2fs tho?

Thanks,

>  	raw_node->footer.next_blkaddr = cpu_to_le32(
>  			get_sb(main_blkaddr) +
>  			c.cur_seg[CURSEG_HOT_NODE] *
> @@ -1630,13 +1637,13 @@ int f2fs_format_device(void)
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
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index 449a0ed..95eec67 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -193,22 +193,22 @@ static void f2fs_parse_options(int argc, char *argv[])
>  
>  	if (!(c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR))) {
>  		if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
> -			MSG(0, "\tInfo: project quota feature should always been"
> +			MSG(0, "\tInfo: project quota feature should always be"
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
>  		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) {
> -			MSG(0, "\tInfo: inode checksum feature should always been"
> +			MSG(0, "\tInfo: inode checksum feature should always be"
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
>  		if (c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) {
> -			MSG(0, "\tInfo: flexible inline xattr feature should always been"
> +			MSG(0, "\tInfo: flexible inline xattr feature should always be"
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
>  		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
> -			MSG(0, "\tInfo: inode crtime feature should always been"
> +			MSG(0, "\tInfo: inode crtime feature should always be"
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
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
