Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A3FC55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qXWBgSvhB9pNFFKSAWDvi1sVXayKcaoQwSJVC1todjM=; b=QsBQV4BChmy1ObJCH4zPL6Eybh
	BIw5ZJA+g2VkZzJnfCX9rjT72wX1JFUD4eS/6zC6Jy7MFb/42UU38P8PbmlejdfVbIFb2i4Jl6Lz5
	95QL4XRzMDLwsL8PJKk5vyAc5DFGvZ5Wq1mOd1bMp29e8CwZD1ood+jFPoIX/DNWImPY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqnNM-00033b-R5;
	Mon, 03 Aug 2026 07:46:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqnNK-00033E-WD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:46:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n+a3AaSWuqxbjv9Ky++6rdkhgJLQbuwaNSpxDI5Tj1s=; b=DrFOk9Nd7sxQE0KHKTCYJtiKfa
 3VVlXxlRM0EqJjmEdPLLSexA0OfrtliKpQh4qFqbpM5GotdC5QPBH2V0V9OE8FNBHLsxGKvOr9niv
 it3lN7T6/kn2y3l5x8sRBdRJNIuRyBbb+oMLeDz/8DUnvWIRB0uy34swxUVLt/IcpldI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n+a3AaSWuqxbjv9Ky++6rdkhgJLQbuwaNSpxDI5Tj1s=; b=NvUsEPNI3es8sIK3t3yYSvtRpj
 i9zlktPjJKuCywCQELQBkFb9SSytnp2tZwcCmuAPnNtAEhig03AZWjdZDZHl/rM9+Nx8X2rUzLW+7
 iHB2C3FDRG1GzdQOmVsoSSdT3UG0MBaPShVjDgOWSTYBpwtA5Xo+1/6NLNyyvqLK5GZ4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqnNN-0007JP-Ln for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:46:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F63460A59;
 Mon,  3 Aug 2026 07:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA86F1F000E9;
 Mon,  3 Aug 2026 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785743172;
 bh=n+a3AaSWuqxbjv9Ky++6rdkhgJLQbuwaNSpxDI5Tj1s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=L4rxjS9lcJCuwNJdInBtJPlQHcX7PC2mcE0PsM+NYtux8wpSO8rW89R/2xv6ajC++
 8MCKEWKdUr9QtqvDuVDNtPB5tnAhnEsQ2Imy08ZBvu+cDayp2d0/EUOnBL5UAik0PO
 akMEzFEwjoOskuCrSEo9SUNzCdZEWbuThHyZ/T2gmbHAhWro9/WnVnsUb+DClmgw9b
 pEl8AgngbK2YmWaPN8m8i6x/PHjKVuJ9Lkpcr6doGcs74nnp+zEJsGxaXU6hHLnHjU
 1ry39SDE+75kDGo+wYYiF44qAKjjpG1skg/HnoMmtVikiKyZ1jDjx8F+8Kr29bZ3XK
 oeCn+0O2PewNQ==
Message-ID: <23ec02b1-aff7-40f2-80be-7cb904cb9acb@kernel.org>
Date: Mon, 3 Aug 2026 15:46:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260723200218.2528887-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260723200218.2528887-1-daeho43@gmail.com>
X-Headers-End: 1wqnNN-0007JP-Ln
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: sanitize invalid segment type
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

On 7/24/26 04:02, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> If an invalid segment type (type < 0 || type >= NO_CHECK_TYPE) is read
> from SIT during block update, update_block() now validates the type,
> reports corruption, and falls back to a valid active curseg type when
> fix_on is enabled. find_next_free_block() also validates want_type to
> prevent out-of-bounds accesses.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fsck/mount.c   |  5 +++++
>   fsck/segment.c | 14 ++++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 85ed404..ce96a44 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -3059,6 +3059,11 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left,
>   	u64 end_blkaddr = (get_sb(segment_count_main) <<
>   			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
>   
> +	if (want_type < 0 || want_type >= NO_CHECK_TYPE) {
> +		ERR_MSG("Invalid segment type %d for block allocation\n", want_type);

Use ASSERT_MSG() instead? it can set c.bug_on.

> +		return -EINVAL;
> +	}
> +
>   	if (c.zoned_model == F2FS_ZONED_HM && !new_sec) {
>   		struct curseg_info *curseg = CURSEG_I(sbi, want_type);
>   		unsigned int segs_per_zone = sbi->segs_per_sec * sbi->secs_per_zone;
> diff --git a/fsck/segment.c b/fsck/segment.c
> index 46dc747..1ae90bf 100644
> --- a/fsck/segment.c
> +++ b/fsck/segment.c
> @@ -779,6 +779,20 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
>   	se = get_seg_entry(sbi, GET_SEGNO(sbi, old_blkaddr));
>   	offset = OFFSET_IN_SEG(sbi, old_blkaddr);
>   	type = se->type;
> +	if (type < 0 || type >= NO_CHECK_TYPE) {
> +		MSG(0, "[FSCK] Invalid SIT segment type %d at blkaddr 0x%"PRIx64"\n",
> +				type, old_blkaddr);
> +		c.bug_on = 1;

Ditto,

> +
> +		if (!c.fix_on)
> +			return -EINVAL;
> +
> +		int fixed_type = IS_NODESEG(type) ? CURSEG_HOT_NODE : CURSEG_HOT_DATA;
> +
> +		FIX_MSG("Correct invalid segment type %d -> %d for blkaddr 0x%"PRIx64"\n",
> +				type, fixed_type, old_blkaddr);
> +		type = fixed_type;

How about fixing se->type directly, otherwise we may fix this in local stack
repeatly whenever encounter this buggy se->type.

Please refer to fix_section_type().

Thanks,

> +	}
>   	se->valid_blocks--;
>   	f2fs_clear_bit(offset, (char *)se->cur_valid_map);
>   	if (need_fsync_data_record(sbi))



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
