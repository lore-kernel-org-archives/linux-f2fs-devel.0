Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8647BC55182
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ovxTGs3HLLdEho1dwcbzthgVLAz4OSqweFlgtPfdiC4=; b=eVAnmJqEGMCXRZVGM0cOptw6XA
	f7StgSIlKDT0VGK9KviTfelrqZ5OJx5jz25KonwDJ599W7RVVc39oC/0kHCIn3ajJKxYU1qXAhfvH
	Te0ibujL3y40jPh7jkhKXoyJwWzSaGqnufTeA57J0cU1kgQNXODCmyJAEAUfiVA3d2uM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr3ck-0008FJ-Hs;
	Tue, 04 Aug 2026 01:07:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr3cc-0008ER-NQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 01:07:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iEEBXdGRwABnDoln3/Ejwf7r5wJNQUWqwaeWtBAdyQE=; b=AxY4hONiosRIcotLiZOtYBRWIA
 wd/CKgYj6bbqnVDvYhRD1Gcgdnu+aHzAFPquQrjFQg4jXiw8MueoBhnf4CGKFtMnfveUti+AMqrD/
 MOm54fzvTteO9E2+Vl0gDbsCFRQXMVGGtJ2IloVN2YSNU22t10oSZVVr/CMwuI3xxHdQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iEEBXdGRwABnDoln3/Ejwf7r5wJNQUWqwaeWtBAdyQE=; b=fejz+9vzBUDfk3RdRkYsS1U4pB
 1j/Vv9bbah5sAo4JFnOkKHB1FKF/gTQ4LYOV2LNFVreE7AWZZtsmMH5U8Zd4C/vnIx2ZGYEaWzA9j
 hCnUD08W3BFUeatsLOgGZToKlWYR6CUlJsvYLl7qXUCvjZKrSRGim6ns0D9ZXacgHBNw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr3cb-0003l7-Dg for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 01:07:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDE8160A59;
 Tue,  4 Aug 2026 01:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7101F000E9;
 Tue,  4 Aug 2026 01:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785805623;
 bh=iEEBXdGRwABnDoln3/Ejwf7r5wJNQUWqwaeWtBAdyQE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Hlh/8BEi9bThvwybowwJcPUwl7L27MJxgD2pBXfWZ0NueTDIFK+ARmwVW6132q3sU
 /ibSND03TrZOs5AUyjHc0/J4w0GMcB64kaS0uH0u5HpQzyCth3r4f2fF498mZjhMOF
 UvhJkyugsydPTc8wxSElzmilGyuA/mAR+Scaqkt7gcPd5iSzhCPQBh85xpOBfrHYD3
 SqEHCwcK+tWyuVyMdnB3+dKgihoU8rD2azUDoDQYefFq893hCH1p+PxyK3RDqDcCLB
 AJgtbpgc61W9uQqYTH1P8bF5lxq3x6w1a3MpduBCY2QEW2oKtNKisfyYNzSBkp9D4/
 IUzwEgzHPZOnA==
Message-ID: <b48f3dfe-0004-4aea-bf0e-1401b4301b4f@kernel.org>
Date: Tue, 4 Aug 2026 09:07:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260803182120.2291138-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260803182120.2291138-1-daeho43@gmail.com>
X-Headers-End: 1wr3cb-0003l7-Dg
Subject: Re: [f2fs-dev] [PATCH v2] fsck.f2fs: sanitize invalid segment type
 during block update
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/4/26 02:21, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> If an invalid segment type (type < 0 || type >= NO_CHECK_TYPE) is read
> from SIT during block update, update_block() now validates the type,
> reports corruption via ASSERT_MSG(), fixes se->type directly, and falls
> back to a valid active curseg type based on its SSA summary block type
> when fix_on is enabled. find_next_free_block() also validates want_type to
> prevent out-of-bounds accesses.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: used ASSERT_MSG() instead of ERR_MSG().
>      used the correct type info for fixed_type.
>      fixed se->type on top of fixing the local type only.
> ---
>   fsck/mount.c   |  5 +++++
>   fsck/segment.c | 20 ++++++++++++++++++--
>   2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 85ed404..916dfbf 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -3059,6 +3059,11 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left,
>   	u64 end_blkaddr = (get_sb(segment_count_main) <<
>   			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
>   
> +	if (want_type < 0 || want_type >= NO_CHECK_TYPE) {
> +		ASSERT_MSG("Invalid segment type %d for block allocation", want_type);
> +		return -EINVAL;
> +	}
> +
>   	if (c.zoned_model == F2FS_ZONED_HM && !new_sec) {
>   		struct curseg_info *curseg = CURSEG_I(sbi, want_type);
>   		unsigned int segs_per_zone = sbi->segs_per_sec * sbi->secs_per_zone;
> diff --git a/fsck/segment.c b/fsck/segment.c
> index 46dc747..43f85ec 100644
> --- a/fsck/segment.c
> +++ b/fsck/segment.c
> @@ -770,15 +770,32 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
>   	struct seg_entry *se;
>   	struct f2fs_summary sum;
>   	u64 new_blkaddr, old_blkaddr = *blkaddr, offset;
> -	int ret, type;
> +	int ret, type, sum_type;
>   
>   	if (c.zoned_model != F2FS_ZONED_HM)
>   		return dev_write_block(buf, old_blkaddr, WRITE_LIFE_NONE);
>   
> +	sum_type = get_sum_entry(sbi, old_blkaddr, &sum);
> +
>   	/* update sit bitmap & valid_blocks && se->type for old block*/
>   	se = get_seg_entry(sbi, GET_SEGNO(sbi, old_blkaddr));
>   	offset = OFFSET_IN_SEG(sbi, old_blkaddr);
>   	type = se->type;
> +	if (type < 0 || type >= NO_CHECK_TYPE) {
> +		int fixed_type = (sum_type == SEG_TYPE_NODE ||
> +				sum_type == SEG_TYPE_CUR_NODE) ?
> +				CURSEG_HOT_NODE : CURSEG_HOT_DATA;
> +
> +		ASSERT_MSG("Invalid SIT segment type %d at blkaddr 0x%"PRIx64,
> +				type, old_blkaddr);
> +
> +		if (!c.fix_on)
> +			return -EINVAL;
> +
> +		FIX_MSG("Correct invalid segment type %d -> %d for blkaddr 0x%"PRIx64"\n",
> +				type, fixed_type, old_blkaddr);
> +		se->type = se->orig_type = type = fixed_type;

We should not change se->orig_type, because fsck uses it to record original
se->type, so that in check_sit_types(), it can be compared w/ se->type to know
which se->type is fixed.

Thanks,

> +	}
>   	se->valid_blocks--;
>   	f2fs_clear_bit(offset, (char *)se->cur_valid_map);
>   	if (need_fsync_data_record(sbi))
> @@ -811,7 +828,6 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
>   	f2fs_set_sit_bitmap(sbi, new_blkaddr);
>   
>   	/* update SSA */
> -	get_sum_entry(sbi, old_blkaddr, &sum);
>   	update_sum_entry(sbi, new_blkaddr, &sum);
>   
>   	if (IS_DATASEG(type)) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
