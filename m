Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6730DC5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Ggb3wubveYGPTZHkWt9Xp6ygvngL7B68T5v6UNlz1k=; b=XeAdc4ex/+1ZJZTQcjmTngjlFC
	6Ai7xuoYDU64AMH5Qhuv3IuGg2Xh1oMXyykicBCMzxYeu5LRx3vAY+KZ/vbVwNkT9hAR/5TRERS7r
	W9gVCMGUOf6qdci7Njx8I2tNv3SFzLWv0IpsqYJJIrZDtXp98KEy6lyt5S5xsiJMXesw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyWeG-0002nb-Ta;
	Mon, 24 Aug 2026 15:31:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wyWeF-0002nU-HM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h8ws7RgoQofyyCp5kw/7FWdC01v/ejsgAf/62LWzxjw=; b=eemywhK6KNa3UoCBSesSi3LncH
 em1lpaNrpP+H2l1aK8HBFuyNPJkKX/u2yL5lrvYQaqVFS3pHcazEspqBLk3OWWFDkLBxqUzUWRIV8
 Rg1WbBlV3FnGzzJc+LhdVHXwj0TZU0OZgVoi1rOORz2hv82O37B1g4UT2YbFvsQAvc4I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h8ws7RgoQofyyCp5kw/7FWdC01v/ejsgAf/62LWzxjw=; b=I+3yOcorVcgK7LHlXS2MJublsd
 Vt/ZM+AtqMy+CzW+x7daNj7lCbazZ3bB84si4epMAvanBm/NnRJxJhDBB6QrCoCMPA0OdFYCtYd9S
 xkqxRxw0aFgjjeD81cnqyWSaek1ZU43jnQL94+G0ZQmO/0V322af3MMzH/7jQFJihx38=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyWeE-0005iO-Hp for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:31:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A68C41B13;
 Mon, 24 Aug 2026 15:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD751F000E9;
 Mon, 24 Aug 2026 15:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787585497;
 bh=h8ws7RgoQofyyCp5kw/7FWdC01v/ejsgAf/62LWzxjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WJDQsoQODiW8TmhdaPF+anpMFtzXG6MU3qffrvvrLrIaGHEjreO059OgBy7lWvmHw
 REdUHGxUZ8yUCwitSAnH/8umE2xxg9tr2Wj3bz9VAnMPYOvlCapdB/QONKFxRLAQCR
 ZDDr822qOpuIFOSYERg8lgUvWNloFK1Km69ouGvsVGXduQmq+wLBqdKVuvQG3C8a7Y
 u6l8WIHDPkEaiwidLiT0bRi0FyXYfdp2RcJqsWQT4LV4qgbAWoMy8ctJK4svts/V6i
 Pw7zqDmOlNfqT2mLHOKmBVOh6XjZf8OMobmM+ZZcgNnM7GLMXurOOHUSKoBjfi4Qgc
 d9FA+UT/HQtmg==
Date: Mon, 24 Aug 2026 15:31:35 +0000
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <aoxj14P3727GvKQu@google.com>
References: <20260818195150.102048-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260818195150.102048-1-daeho43@gmail.com>
X-Headers-End: 1wyWeE-0005iO-Hp
Subject: Re: [f2fs-dev] [PATCH] f2fs: support pinned boundary section and
 unify pinned allocation
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

Could you please rebase on top of dev-test?

Thanks,

On 08/18, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Currently, zoned block devices restrict pinned file allocations to
> conventional zones at the beginning of the storage (before
> first_seq_zone_segno), triggering range GC when conventional space is
> exhausted.
> 
> To support pinned area boundary configuration on regular block devices
> as well, introduce a unified `pinned_area_max_secno` boundary
> abstraction in `f2fs_sb_info`:
> 1. Add `-o pinned_boundary_secno=%u` mount option to allow configuring
>    the pinned area upper bound at mount time.
> 2. In `f2fs_fill_super()`, initialize `sbi->pinned_area_max_secno` as:
>    min(MAIN_SECS(sbi), zoned_max_sec, boundary_opt_sec).
> 3. In `get_new_segment()`, restrict segment allocation for pinned files
>    (`pinning == true`) to `0 .. sbi->pinned_area_max_secno - 1`. If no
>    free section is available in the pinned area, return -EAGAIN.
> 4. In `f2fs_allocate_pinning_section()`, unify the range GC trigger to
>    run `f2fs_gc_range()` up to `sbi->pinned_area_max_secno` whenever
>    `sbi->pinned_area_max_secno < MAIN_SECS(sbi)` and allocation
>    returns -EAGAIN.
> 5. Expose `/sys/fs/f2fs/<dev>/pinned_area_max_secno` as a read-only
>    sysfs node.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++
>  Documentation/filesystems/f2fs.rst      |  5 ++++
>  fs/f2fs/f2fs.h                          |  2 ++
>  fs/f2fs/segment.c                       | 39 ++++++++++++++-----------
>  fs/f2fs/segment.h                       |  1 +
>  fs/f2fs/super.c                         | 36 +++++++++++++++++++++++
>  fs/f2fs/sysfs.c                         |  2 ++
>  7 files changed, 75 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 39ac8566822a..9e021312d6ae 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -1011,3 +1011,10 @@ Description:	Every time a write operation completes f2fs_write_end_io() is
>  		e.g. from inside an interrupt handler. This attribute controls
>  		the maximum size of a write bio that is completed in atomic
>  		(atc) context.
> +
> +What:		/sys/fs/f2fs/<disk>/pinned_area_max_secno
> +Date:		August 2026
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	This is a read-only entry to show the upper bound section number
> +		for pinned files. Pinned files will only be allocated within
> +		sections 0 to pinned_area_max_secno - 1.
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 8c4a14ae444f..f71a23c079be 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -418,6 +418,11 @@ lookup_mode=%s		 Control the directory lookup behavior for casefolded
>  					        on-disk `SB_ENC_NO_COMPAT_FALLBACK_FL`
>  					        flag.
>  			     ================== ========================================
> +pinned_boundary_secno=%u Control the upper bound section number for pinned files.
> +			 Pinned files will only be allocated within sections
> +			 0 to pinned_boundary_secno - 1. If set to 0 (default),
> +			 there is no boundary restriction unless running on a
> +			 zoned block device where conventional zones are used.
>  ======================== ============================================================
>  
>  Debugfs Entries
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f1774d4e18d2..021407186af8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -254,6 +254,7 @@ struct f2fs_mount_info {
>  	block_t unusable_cap;		/* Amount of space allowed to be
>  					 * unusable when disabling checkpoint
>  					 */
> +	unsigned int pinned_boundary_secno;	/* upper bound section for pinned files */
>  
>  	/* For compression */
>  	unsigned char compress_algorithm;	/* algorithm type */
> @@ -1970,6 +1971,7 @@ struct f2fs_sb_info {
>  	spinlock_t dev_lock;			/* protect dirty_device */
>  	bool aligned_blksize;			/* all devices has the same logical blksize */
>  	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
> +	unsigned int pinned_area_max_secno;	/* upper bound section for pinned files */
>  	unsigned int bggc_io_aware;		/* For adjust the BG_GC priority when pending IO */
>  	unsigned int allocate_section_hint;	/* the boundary position between devices */
>  	unsigned int allocate_section_policy;	/* determine the section writing priority */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d71ddb3ee918..12a561d8f8c2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2777,6 +2777,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
>  	unsigned int alloc_policy = sbi->allocate_section_policy;
>  	unsigned int alloc_hint = sbi->allocate_section_hint;
> +	unsigned int max_secno = MAIN_SECS(sbi);
>  	bool init = true;
>  	int i;
>  	int ret = 0;
> @@ -2802,7 +2803,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  	 */
>  	if (f2fs_sb_has_blkzoned(sbi)) {
>  		/* Prioritize writing to conventional zones */
> -		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
> +		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV)
>  			segno = 0;
>  		else
>  			segno = max(sbi->first_seq_zone_segno, *newseg);
> @@ -2818,18 +2819,22 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  		alloc_hint > MAIN_SECS(sbi))
>  		alloc_hint = MAIN_SECS(sbi);
>  
> -	if (alloc_policy == ALLOCATE_FORWARD_FROM_HINT &&
> -		hint < alloc_hint)
> +	if (pinning) {
> +		max_secno = sbi->pinned_area_max_secno;
> +		hint = 0;
> +	} else if (alloc_policy == ALLOCATE_FORWARD_FROM_HINT &&
> +		hint < alloc_hint) {
>  		hint = alloc_hint;
> -	else if (alloc_policy == ALLOCATE_FORWARD_WITHIN_HINT &&
> -			hint >= alloc_hint)
> +	} else if (alloc_policy == ALLOCATE_FORWARD_WITHIN_HINT &&
> +			hint >= alloc_hint) {
>  		hint = 0;
> +	}
>  
>  find_other_zone:
> -	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> +	secno = find_next_zero_bit(free_i->free_secmap, max_secno, hint);
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> -	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
> +	if (secno >= max_secno && f2fs_sb_has_blkzoned(sbi) && !pinning) {
>  		/* Write only to sequential zones */
>  		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ) {
>  			hint = GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno);
> @@ -2845,11 +2850,11 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  	}
>  #endif
>  
> -	if (secno >= MAIN_SECS(sbi)) {
> -		secno = find_first_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi));
> -		if (secno >= MAIN_SECS(sbi)) {
> -			ret = -ENOSPC;
> +	if (secno >= max_secno) {
> +		secno = find_first_zero_bit(free_i->free_secmap, max_secno);
> +		if (secno >= max_secno) {
> +			ret = (pinning && has_pinned_area(sbi)) ?
> +					-EAGAIN : -ENOSPC;
>  			f2fs_bug_on(sbi, !pinning);
>  			goto out_unlock;
>  		}
> @@ -2886,9 +2891,8 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  		goto out_unlock;
>  	}
>  
> -	/* no free section in conventional device or conventional zone */
> -	if (new_sec && pinning &&
> -		f2fs_is_sequential_zone_area(sbi, START_BLOCK(sbi, segno))) {
> +	/* no free section in pinned area */
> +	if (new_sec && pinning && secno >= sbi->pinned_area_max_secno) {
>  		ret = -EAGAIN;
>  		goto out_unlock;
>  	}
> @@ -3357,9 +3361,10 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
>  	err = f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
>  	f2fs_unlock_op(sbi, &lc);
>  
> -	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
> +	if (has_pinned_area(sbi) && err == -EAGAIN && gc_required) {
>  		f2fs_down_write_trace(&sbi->gc_lock, &lc);
> -		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
> +		err = f2fs_gc_range(sbi, 0,
> +				sbi->pinned_area_max_secno * SEGS_PER_SEC(sbi) - 1,
>  				true, ZONED_PIN_SEC_REQUIRED_COUNT);
>  		f2fs_up_write_trace(&sbi->gc_lock, &lc);
>  
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index b0c06b3580b4..057139107935 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -43,6 +43,7 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>  
>  #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
>  #define MAIN_SECS(sbi)	((sbi)->total_sections)
> +#define has_pinned_area(sbi)	((sbi)->pinned_area_max_secno < MAIN_SECS(sbi))
>  
>  #define TOTAL_SEGS(sbi)							\
>  	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index c448d992ff2a..746c003f3aad 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -235,6 +235,7 @@ enum {
>  	Opt_jqfmt,
>  	Opt_checkpoint,
>  	Opt_lookup_mode,
> +	Opt_pinned_boundary_secno,
>  	Opt_err,
>  };
>  
> @@ -366,6 +367,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
>  	fsparam_flag("age_extent_cache", Opt_age_extent_cache),
>  	fsparam_enum("errors", Opt_errors, f2fs_param_errors),
>  	fsparam_enum("lookup_mode", Opt_lookup_mode, f2fs_param_lookup_mode),
> +	fsparam_u32("pinned_boundary_secno", Opt_pinned_boundary_secno),
>  	{}
>  };
>  
> @@ -551,6 +553,17 @@ static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
>  			F2FS_OPTION(sbi).unusable_cap_perc);
>  }
>  
> +static inline void adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
> +{
> +	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
> +	if (f2fs_sb_has_blkzoned(sbi) && sbi->first_seq_zone_segno != NULL_SEGNO)
> +		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
> +				GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno));
> +	if (F2FS_OPTION(sbi).pinned_boundary_secno)
> +		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
> +				F2FS_OPTION(sbi).pinned_boundary_secno);
> +}
> +
>  static void init_once(void *foo)
>  {
>  	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
> @@ -1235,6 +1248,9 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		F2FS_CTX_INFO(ctx).lookup_mode = result.uint_32;
>  		ctx->spec_mask |= F2FS_SPEC_lookup_mode;
>  		break;
> +	case Opt_pinned_boundary_secno:
> +		F2FS_CTX_INFO(ctx).pinned_boundary_secno = result.uint_32;
> +		break;
>  	}
>  	return 0;
>  }
> @@ -1771,6 +1787,12 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
>  
>  static int f2fs_sanity_check_options(struct f2fs_sb_info *sbi, bool remount)
>  {
> +	if (remount &&
> +	    F2FS_OPTION(sbi).pinned_boundary_secno >= MAIN_SECS(sbi)) {
> +		f2fs_err(sbi, "Option pinned_boundary_secno is larger than or equal to total sections (%u >= %u)",
> +				F2FS_OPTION(sbi).pinned_boundary_secno, MAIN_SECS(sbi));
> +		return -EINVAL;
> +	}
>  	if (f2fs_sb_has_device_alias(sbi) &&
>  	    !test_opt(sbi, READ_EXTENT_CACHE)) {
>  		f2fs_err(sbi, "device aliasing requires extent cache");
> @@ -2543,6 +2565,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  	else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_AUTO)
>  		seq_show_option(seq, "lookup_mode", "auto");
>  
> +	if (F2FS_OPTION(sbi).pinned_boundary_secno)
> +		seq_printf(seq, ",pinned_boundary_secno=%u",
> +				F2FS_OPTION(sbi).pinned_boundary_secno);
> +
>  	return 0;
>  }
>  
> @@ -2585,6 +2611,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
>  	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
>  	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
>  	F2FS_OPTION(sbi).errors = MOUNT_ERRORS_CONTINUE;
> +	F2FS_OPTION(sbi).pinned_boundary_secno = 0;
>  
>  	set_opt(sbi, INLINE_XATTR);
>  	set_opt(sbi, INLINE_DATA);
> @@ -3042,6 +3069,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
>  
> +	adjust_pinned_area_boundary(sbi);
>  	limit_reserve_root(sbi);
>  	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
>  
> @@ -5251,6 +5279,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	/* get segno of first zoned block device */
>  	sbi->first_seq_zone_segno = get_first_seq_zone_segno(sbi);
>  
> +	if (F2FS_OPTION(sbi).pinned_boundary_secno >= MAIN_SECS(sbi)) {
> +		f2fs_err(sbi, "Option pinned_boundary_secno is larger than or equal to total sections (%u >= %u)",
> +				F2FS_OPTION(sbi).pinned_boundary_secno, MAIN_SECS(sbi));
> +		err = -EINVAL;
> +		goto free_nm;
> +	}
> +	adjust_pinned_area_boundary(sbi);
> +
>  	sbi->reserved_pin_section = f2fs_sb_has_blkzoned(sbi) ?
>  			ZONED_PIN_SEC_REQUIRED_COUNT :
>  			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi));
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 47b378ccf07a..e0c51f9ec7eb 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1311,6 +1311,7 @@ F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
>  #endif
>  F2FS_SBI_GENERAL_RW_ATTR(carve_out);
>  F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
> +F2FS_SBI_GENERAL_RO_ATTR(pinned_area_max_secno);
>  F2FS_SBI_GENERAL_RW_ATTR(bggc_io_aware);
>  F2FS_SBI_GENERAL_RW_ATTR(max_lock_elapsed_time);
>  F2FS_SBI_GENERAL_RW_ATTR(lock_duration_priority);
> @@ -1523,6 +1524,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(max_read_extent_count),
>  	ATTR_LIST(carve_out),
>  	ATTR_LIST(reserved_pin_section),
> +	ATTR_LIST(pinned_area_max_secno),
>  	ATTR_LIST(allocate_section_hint),
>  	ATTR_LIST(allocate_section_policy),
>  	ATTR_LIST(max_lock_elapsed_time),
> -- 
> 2.55.0.691.gc56d675ccc-goog
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
