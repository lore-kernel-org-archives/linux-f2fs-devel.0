Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C38BC5AD55
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4xxyDFNEKYKtFqDuZ6WohikhVebY/GkVadTXdontimk=; b=YmIjs/3i0Y4jOcKnHAjQK434bY
	DB2s/wqAU57Py6eTl725eaE84eAlTmkSSALBAYdjMoaVn1RwSLRLL1zPoeqxWobJVTrTLCCtYLNNH
	AVUp8wytyQdegndwbeiC6eCUVbUrtrNd5nRRNgnQ2XmgnkKiVg5Qf5UojGP5TU1+aQBI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtFTA-0004cH-Dh;
	Mon, 10 Aug 2026 02:10:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wtFT9-0004cA-KH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 02:10:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YPgzYY5iPcBB9dAei64TOcifX0pTD7mBDEN5VxDnztI=; b=BxRoJK0H/dSu4J+k6KxyslSiif
 a6Ke7zcIzs1HUy/fdrAGpNDqn3lPtWo9wjTQ+/zSs8L864rPUytdZLoLcrWHTOa0oG07DRibVSmwz
 qMbxbVeSO8XQmuULB4KoBHwOnBQr4MKc3cfuMAuhMR7fHeE7twKEKMyOTU1Vo5y4rOmw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YPgzYY5iPcBB9dAei64TOcifX0pTD7mBDEN5VxDnztI=; b=Vfo+hvOAHmVw1TvIVaKNFk0yQ5
 gJabILmeHyhRjobuYStJI6MQwyDutStz1j6Sr9cUDB7rldLhyK9V1Qgr9aBq/kmWAmlJJHItfCv5+
 krMYDq3R8HoUa9IvIkKCSM1XMJbc1u6OnEPVg34DNhJkOKWljAAwfMeZ5sWE4p2B599M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtFT8-0000yS-MR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 02:10:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B35441787;
 Mon, 10 Aug 2026 02:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CA81F000E9;
 Mon, 10 Aug 2026 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786327821;
 bh=YPgzYY5iPcBB9dAei64TOcifX0pTD7mBDEN5VxDnztI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Az21/RPhCnOSS0Wxip5JOgvQxkvPZXbXYkXamn+RPvGQjmqrwIK2EC2/SGAnRqmv4
 2OQAbpYN7hv5JqPqABK4/u7sUHeIRaXVh+qFtDjqpoIfy6AGxRzqIxjlePt5moutl4
 q8TOg+QqKdcnMIEzQjaTXvPRaZH9Pg4TWT8hFzGlL69p6zpv9trYkBiZkOI8BntQD1
 ALHP7b1jidDS5h1VJfTpRmpxTlJJrJBfY88zusFXbxRMKIMWC6d1q44pA+VERayUZN
 gJXlADMXmf7J2sgKjeXxFBgD6pZpbAOtFOG7ZQ9g7OTMZG+1E5l+Q4TTrbbFjZq4r7
 lqrnkLKfPdmig==
Message-ID: <f7dabaa3-6d3c-4c70-b953-08dd52c35f49@kernel.org>
Date: Mon, 10 Aug 2026 02:10:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yonggil.song@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>
References: <20260707225035epcms2p812b92e6001afb57eb06d98225f1acd87@epcms2p8>
 <CGME20260707225035epcms2p812b92e6001afb57eb06d98225f1acd87@epcms2p4>
 <20260707225453epcms2p4f8323f4f8b88f3ee892cddc126da51a6@epcms2p4>
Content-Language: en-US
In-Reply-To: <20260707225453epcms2p4f8323f4f8b88f3ee892cddc126da51a6@epcms2p4>
X-Headers-End: 1wtFT8-0000yS-MR
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: introduce gcless mount option
 to avoid foreground GC
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, Seokhwan Kim <sukka.kim@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yonggil,

Sorry for the delay.

On 7/7/26 22:54, Yonggil Song wrote:
> Under heavy out-of-place overwrite at near-full utilization, foreground
> GC picks nearly-fully-valid victims and relocates almost every block,
> while the scattered invalid space is not SSR-reusable until a checkpoint
> stabilizes it.  WAF explodes even though reclaimable space exists.
> 
> Add a "gcless" mount option that counts checkpoint-stable invalid blocks
> (invalid as of the last checkpoint, hence SSR-reusable) and credits them
> as free sections in has_not_enough_free_secs().  The watermark then sees
> the slack as free, so f2fs_balance_fs() skips foreground GC and
> allocation reclaims the space through SSR instead.  The count is
> recomputed at mount and after each successful checkpoint under
> block_operations(), where it is exact and needs no locking.
> 
> The option is limited to adaptive (non-LFS) mode.
> 
> 8 GiB UFS, 2 GiB random overwrite at 99% utilization:
>    baseline: WAF 76.7, foreground GC calls 578k
>    gcless:   WAF  1.2, foreground GC calls 504

Can we mitigate this by increasing min_ssr_sections?

> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
> v2:
>   - split out the BIT_ULL() conversion for mount option bits into a
>     preparation patch, fixing the 32-bit shift-count-overflow warning
>     reported by kernel test robot <lkp@intel.com>
>   Documentation/filesystems/f2fs.rst |  8 +++++
>   fs/f2fs/checkpoint.c               |  1 +
>   fs/f2fs/debug.c                    |  4 +++
>   fs/f2fs/f2fs.h                     | 12 ++++++++
>   fs/f2fs/gc.c                       |  5 ++--
>   fs/f2fs/segment.c                  | 47 ++++++++++++++++++++++++++++++
>   fs/f2fs/segment.h                  | 15 ++++++++++
>   fs/f2fs/super.c                    | 17 +++++++++++
>   8 files changed, 107 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 7e4031631286..05ac3f76bfba 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -409,6 +409,14 @@ lookup_mode=%s		 Control the directory lookup behavior for casefolded
>   					        on-disk `SB_ENC_NO_COMPAT_FALLBACK_FL`
>   					        flag.
>   			     ================== ========================================
> +gcless			 Avoid foreground GC by crediting checkpoint-stable invalid
> +			 blocks (invalid at the last checkpoint and thus SSR-reusable)
> +			 as free space in the free section watermark, so allocation
> +			 recycles that slack via SSR instead of relocating valid
> +			 blocks. Intended for heavy out-of-place overwrite at
> +			 near-full utilization, where it reduces write amplification.
> +			 Not allowed in LFS mode (including zoned block devices),
> +			 by default it's disabled.
>   ======================== ============================================================
>   
>   Debugfs Entries
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 01e1ba77263e..0d83e90b583c 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1932,6 +1932,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>   		f2fs_release_discard_addrs(sbi);
>   	} else {
>   		f2fs_clear_prefree_segments(sbi, cpc);
> +		f2fs_update_cib(sbi);
>   	}
>   
>   	f2fs_restore_inmem_curseg(sbi);
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index af88db8fdb71..b1435e01447d 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -285,6 +285,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>   	for (i = 0; i < MAX_CALL_TYPE; i++)
>   		si->cp_call_count[i] = atomic_read(&sbi->cp_call_count[i]);
>   
> +	si->cib_total_blocks = READ_ONCE(sbi->cib_total_blocks);
> +
>   	for (i = 0; i < 2; i++) {
>   		si->segment_count[i] = sbi->segment_count[i];
>   		si->block_count[i] = sbi->block_count[i];
> @@ -623,6 +625,8 @@ static int stat_show(struct seq_file *s, void *v)
>   		seq_printf(s, "  - Total : %4d\n", si->nr_total_ckpt);
>   		seq_printf(s, "  - Cur time : %4d(ms)\n", si->cur_ckpt_time);
>   		seq_printf(s, "  - Peak time : %4d(ms)\n", si->peak_ckpt_time);
> +		seq_printf(s, "GCless CIB budget : %u blocks\n",
> +			   si->cib_total_blocks);
>   		seq_printf(s, "GC calls: %d (gc_thread: %d)\n",
>   			   si->gc_call_count[BACKGROUND] +
>   			   si->gc_call_count[FOREGROUND],
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 20a1e2353f60..a2a85eaa636d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -137,6 +137,7 @@ enum f2fs_mount_opt {
>   	 * string rather than using the MS_LAZYTIME flag, so this must remain.
>   	 */
>   	F2FS_MOUNT_LAZYTIME,
> +	F2FS_MOUNT_GCLESS,
>   	F2FS_MOUNT_RESERVE_NODE,
>   };
>   
> @@ -1870,6 +1871,15 @@ struct f2fs_sb_info {
>   
>   	struct f2fs_mount_info mount_opt;	/* mount options */
>   
> +	/*
> +	 * Checkpoint-stable invalid blocks: sum of blocks that were invalid at
> +	 * the last checkpoint and are thus SSR-eligible while their section stays
> +	 * dirty.  Written only by f2fs_update_cib() (mount and after each
> +	 * successful checkpoint, under block_operations()), read locklessly, so a
> +	 * plain block_t with READ_ONCE()/WRITE_ONCE() suffices -- no atomic.
> +	 */
> +	block_t cib_total_blocks;
> +
>   	/* for cleaning operations */
>   	struct f2fs_rwsem gc_lock;		/*
>   						 * semaphore for GC, avoid
> @@ -4000,6 +4010,7 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
>   void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   					struct cp_control *cpc);
>   void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
> +void f2fs_update_cib(struct f2fs_sb_info *sbi);
>   block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi);
>   int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
>   void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
> @@ -4289,6 +4300,7 @@ struct f2fs_stat_info {
>   	int dirty_count, node_pages, meta_pages, compress_pages;
>   	int compress_page_hit;
>   	int prefree_count, free_segs, free_secs;
> +	block_t cib_total_blocks;
>   	int cp_call_count[MAX_CALL_TYPE], cp_count;
>   	int gc_call_count[MAX_CALL_TYPE];
>   	int gc_segs[2][2];
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e60c1106f70b..ebf47ef5fff0 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1964,10 +1964,11 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   		 * threshold, we can make them free by checkpoint. Then, we
>   		 * secure free segments which doesn't need fggc any more.
>   		 */
> -		if (prefree_segments(sbi)) {
> +		if (prefree_segments(sbi) || test_opt(sbi, GCLESS)) {
>   			stat_inc_cp_call_count(sbi, TOTAL_CALL);
>   			ret = f2fs_write_checkpoint(sbi, &cpc);
> -			if (ret)
> +			if (ret ||
> +			    (test_opt(sbi, GCLESS) && has_enough_free_secs(sbi, 0, 0)))
>   				goto stop;
>   			/* Reset due to checkpoint */
>   			sec_freed = 0;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 788f8b050249..e020714261ff 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -305,6 +305,53 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
>   		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
>   }
>   
> +static inline u32 cib_contrib_of_se(struct f2fs_sb_info *sbi, unsigned long seg)
> +{
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> +	struct free_segmap_info *free_i = SM_I(sbi)->free_info;
> +	struct seg_entry *se = get_seg_entry(sbi, seg);
> +	u32 usable = f2fs_usable_blks_in_seg(sbi, seg);
> +	u32 ckpt_v = se->ckpt_valid_blocks;
> +
> +	/* free, prefree and current segments hold no reusable SSR slack */
> +	if (test_bit(seg, free_i->free_segmap))
> +		return 0;
> +	if (test_bit(seg, dirty_i->dirty_segmap[PRE]))
> +		return 0;
> +	if (is_curseg(sbi, seg))
> +		return 0;
> +	if (ckpt_v >= usable)
> +		return 0;
> +
> +	return usable - ckpt_v;

If SSR is enabled, there may be valid but not checkpointed blocks in section?
such space can not be treated as free?

And, only updating sbi->cib_total_blocks w/ f2fs_update_cib() in checkpoint()
is not enough? since free space in section may change due to SSR allocation
and deletion. right?

> +}
> +
> +/*
> + * Recompute the checkpoint-stable invalid-block budget by scanning all main
> + * segments via ckpt_valid_blocks (free/prefree/current segments contribute
> + * nothing).  Called at mount and after every successful checkpoint, both under
> + * block_operations(), so it is the only writer and needs no atomic; readers use
> + * READ_ONCE().  ckpt_valid_blocks is fixed between checkpoints, so the value is
> + * exact at each checkpoint -- gcless checkpoints often enough to keep it fresh,
> + * which is why no per-allocation delta hooks are needed.
> + */
> +void f2fs_update_cib(struct f2fs_sb_info *sbi)
> +{
> +	unsigned long nsegs = MAIN_SEGS(sbi);
> +	unsigned long seg;
> +	block_t total = 0;
> +
> +	if (!test_opt(sbi, GCLESS)) {
> +		WRITE_ONCE(sbi->cib_total_blocks, 0);
> +		return;
> +	}
> +
> +	for (seg = 0; seg < nsegs; seg++)
> +		total += cib_contrib_of_se(sbi, seg);
> +
> +	WRITE_ONCE(sbi->cib_total_blocks, total);
> +}
> +
>   static int __f2fs_commit_atomic_write(struct inode *inode)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 068845660b0f..3226930d759a 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -702,6 +702,21 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>   	free_secs = free_sections(sbi) + freed;
>   	required_secs = needed + reserved_sections(sbi) +
>   			__get_secs_required(sbi);
> +	/*
> +	 * Credit the checkpoint-stable invalid-block budget (SSR-reusable slack)
> +	 * to free_secs, so the watermark lets allocation recycle that slack via
> +	 * SSR instead of running foreground GC.  cib_total_blocks is a section/
> +	 * block count (always non-negative), so the math stays in unsigned int and
> +	 * is capped at the sections still unaccounted for.
> +	 */
> +	if (test_opt(sbi, GCLESS)) {
> +		unsigned int sec_blks = CAP_BLKS_PER_SEC(sbi);
> +		unsigned int add_secs = READ_ONCE(sbi->cib_total_blocks) / sec_blks;
> +		unsigned int room = free_secs < MAIN_SECS(sbi) ?
> +					MAIN_SECS(sbi) - free_secs : 0;
> +
> +		free_secs += min(add_secs, room);

A free section can be reused by any DATA or NODE type write, but above GCLESS
"free_secs" may not, e.g. all free_secs are from DATA type, then latter checkpoint
won't write any node into DATA type section w/ SSR.

Thanks,

> +	}
>   
>   	return free_secs < required_secs;
>   }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 62d3a58cb1b2..07c7d88719a6 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -234,6 +234,7 @@ enum {
>   	Opt_jqfmt,
>   	Opt_checkpoint,
>   	Opt_lookup_mode,
> +	Opt_gcless,
>   	Opt_err,
>   };
>   
> @@ -336,6 +337,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
>   	fsparam_flag("usrquota", Opt_usrquota),
>   	fsparam_flag("grpquota", Opt_grpquota),
>   	fsparam_flag("prjquota", Opt_prjquota),
> +	fsparam_flag("gcless", Opt_gcless),
>   	fsparam_string("usrjquota", Opt_usrjquota),
>   	fsparam_flag("usrjquota", Opt_usrjquota),
>   	fsparam_string("grpjquota", Opt_grpjquota),
> @@ -1230,6 +1232,9 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   	case Opt_nat_bits:
>   		ctx_set_opt(ctx, F2FS_MOUNT_NAT_BITS);
>   		break;
> +	case Opt_gcless:
> +		ctx_set_opt(ctx, F2FS_MOUNT_GCLESS);
> +		break;
>   	case Opt_lookup_mode:
>   		F2FS_CTX_INFO(ctx).lookup_mode = result.uint_32;
>   		ctx->spec_mask |= F2FS_SPEC_lookup_mode;
> @@ -1603,6 +1608,13 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
>   		f2fs_err(sbi, "Allow to mount readonly mode only");
>   		return -EROFS;
>   	}
> +
> +	/* Only for adaptive mode */
> +	if (test_opt(sbi, GCLESS) && f2fs_lfs_mode(sbi)) {
> +		f2fs_err(sbi, "gcless is not allowed in LFS mode");
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -2542,6 +2554,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>   	else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_AUTO)
>   		seq_show_option(seq, "lookup_mode", "auto");
>   
> +	if (test_opt(sbi, GCLESS))
> +		seq_puts(seq, ",gcless");
> +
>   	return 0;
>   }
>   
> @@ -5344,6 +5359,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   	if (err)
>   		goto sync_free_meta;
>   
> +	f2fs_update_cib(sbi);
> +
>   	/*
>   	 * If filesystem is not mounted as read-only then
>   	 * do start the gc_thread.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
