Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC009C02182
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jan 2025 12:25:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tZqqJ-0008G2-17;
	Mon, 20 Jan 2025 12:25:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tZqqI-0008Fu-5c
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jan 2025 12:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kXuhl0sVPqbzFCiNpoRoSW2l4bGz4mMl9q/+PX28WRU=; b=U0Q/opyz3YgWLtmH+MeLMniUBB
 EPYmYjPqgVDSfIYWCUsYh+VmcwrPRiFSNI9OrPnyag4g4ZW7ghIUPWma/NVxu6X8TPQwEGyO/ABkP
 SB64ZywXnAfbTX7yvFqoo0Zy8Q4aD0mbwJkh6po04vWGRZsSg1J/n67VF6NsN79c9ybE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kXuhl0sVPqbzFCiNpoRoSW2l4bGz4mMl9q/+PX28WRU=; b=Nz3216wZQSKlVUJTg00jZkIbJX
 QoTpJAjSxk7A+4X10YUl1e6CuMEohHiLvdYDhZ4BhBdY1qnZzAPDBhcUcbKGhWAsx1/9j9HPS58Lz
 C6XeW9S4OA/ojOvd9wfhsUJKzYygB3TKpMsiXywx+izydPzkGvIhf3r6QtqnNLAD0c0c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tZqqH-0001vj-Fd for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jan 2025 12:25:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 998405C59F2;
 Mon, 20 Jan 2025 12:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E662BC4CEDD;
 Mon, 20 Jan 2025 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737375910;
 bh=sPS18muDCtBOUW0OqUdtnsEKIul3j7CdK5hJRv/QnHU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Ld2MY9RNACM0BYN7MwrUyjoAVkYhMrhcCEizUfuiVE5qyaPmXhg2JMtReY0mBUTfx
 d6SUtbeydLiYGYHm7emnpVI1C/nyqaUVcM/tcfDmQuMHwA36ydOycWrHdVOdOgVpKX
 IH8pc1AQ6t3DUZ5/aiv8XOLXeVb60k6LFzOnpjyRlLeEuCFrJnAhtCUsl31MuhTymy
 AxXExtFNQjVr0gc7QC9NP/OYGi73J1Ogns18MwuHmwxpWuHhhvDBGjRTq3nOCn2rsE
 uZPn/DQtno8hoLVPDlBz7QFyOp24UePZiZyyWPOeaKUkZ5BfiqAS+UVFPPYO5/AY1P
 0a6CJb4Et8xpg==
Message-ID: <4270b213-e4f9-46b2-958a-df3dbaaed969@kernel.org>
Date: Mon, 20 Jan 2025 20:25:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250109122755.177926-1-guochunhai@vivo.com>
Content-Language: en-US
In-Reply-To: <20250109122755.177926-1-guochunhai@vivo.com>
X-Headers-End: 1tZqqH-0001vj-Fd
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix missing discard for active
 segments
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/9/25 20:27, Chunhai Guo wrote:
> During a checkpoint, the current active segment X may not be handled
> properly. This occurs when segment X has 0 valid blocks and a non-zero

How does this happen? Allocator selects a dirty segment w/ SSR? and the
left valid data blocks were deleted later before following checkpoint?

If so, pending discard count in that segment should be in range of (0, 512)?

Thanks,

> number of discard blocks, for the following reasons:
> 
> locate_dirty_segment() does not mark any active segment as a prefree
> segment. As a result, segment X is not included in dirty_segmap[PRE], and
> f2fs_clear_prefree_segments() skips it when handling prefree segments.
> 
> add_discard_addrs() skips any segment with 0 valid blocks, so segment X is
> also skipped.
> 
> Consequently, no `struct discard_cmd` is actually created for segment X.
> However, the ckpt_valid_map and cur_valid_map of segment X are synced by
> seg_info_to_raw_sit() during the current checkpoint process. As a result,
> it cannot find the missing discard bits even in subsequent checkpoints.
> Consequently, the value of sbi->discard_blks remains non-zero. Thus, when
> f2fs is umounted, CP_TRIMMED_FLAG will not be set due to the non-zero
> sbi->discard_blks.
> 
> Relevant code process:
> 
> f2fs_write_checkpoint()
>      f2fs_flush_sit_entries()
>           list_for_each_entry_safe(ses, tmp, head, set_list) {
>               for_each_set_bit_from(segno, bitmap, end) {
>                   ...
>                   add_discard_addrs(sbi, cpc, false); // skip segment X due to its 0 valid blocks
>                   ...
>                   seg_info_to_raw_sit(); // sync ckpt_valid_map with cur_valid_map for segment X
>                   ...
>               }
>           }
>      f2fs_clear_prefree_segments(); // segment X is not included in dirty_segmap[PRE] and is skipped
> 
> Since add_discard_addrs() can handle active segments with non-zero valid
> blocks, it is reasonable to fix this issue by allowing it to also handle
> active segments with 0 valid blocks.
> 
> Fixes: b29555505d81 ("f2fs: add key functions for small discards")
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v1: https://lore.kernel.org/linux-f2fs-devel/20241203065108.2763436-1-guochunhai@vivo.com/
> v1->v2:
>   - Modify the commit message to make it easier to understand.
>   - Add fixes to the commit.
> ---
>   fs/f2fs/segment.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 86e547f008f9..13ee73a3c481 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2090,7 +2090,9 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>   		return false;
>   
>   	if (!force) {
> -		if (!f2fs_realtime_discard_enable(sbi) || !se->valid_blocks ||
> +		if (!f2fs_realtime_discard_enable(sbi) ||
> +			(!se->valid_blocks &&
> +				!IS_CURSEG(sbi, cpc->trim_start)) ||
>   			SM_I(sbi)->dcc_info->nr_discards >=
>   				SM_I(sbi)->dcc_info->max_discards)
>   			return false;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
