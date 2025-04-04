Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6940FC36010
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Apr 2025 19:56:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u0n9K-0004Ek-SO;
	Fri, 04 Apr 2025 19:56:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1u0n9J-0004Ec-G2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Apr 2025 19:56:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WKtDJOOTCCFzZ3ugQd9joBzjPACkTPFCqMLJpmN6N/8=; b=PkKv8ccn9RyzZWyv5pG4pWRn7r
 VWCKabirIdAz/XBwBq7/l2acxUYfRqZvJRgYE5bnpapqE3sB+1OOyNaBtSw16Vv7wcU4k1mUTH5ie
 265xyjdD1/1RFfQsQOa0W13Qf9/FDs5NGjrxJOz+q6NkRVnjuhg50Q21OsTSJy6MV0pE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WKtDJOOTCCFzZ3ugQd9joBzjPACkTPFCqMLJpmN6N/8=; b=MP2OFpA100Fhh8k1oPJJk0ZrHR
 qU8A83Evk1wLuowfaHgK+AaIb6g5c+WXasoNF8d07UZfMucM7JUbxUSoiqZq25Z/sazhg52N1Kw+R
 zzGl9POMKKJjxuNNO7iYiLtZLNhV2RNDaf/aipKuNVxOv/XMpWOG18dQODfveAC9tcHc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u0n94-0006lI-7O for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Apr 2025 19:56:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 24AB661139;
 Fri,  4 Apr 2025 19:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B14C4CEDD;
 Fri,  4 Apr 2025 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743796555;
 bh=2kEGGwEpfW7hU23vb/09JvyfuhHSs2hXb2emfr4WRbA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C4NI6yjwKYfqKhJM5ktdsD1ng6byy1XmmnH37NZ0AmhZARz7vJrDWz1gbPWWPnrUE
 YDMbv7aNTDsOlSXmtdHCOfiAYKJgcrk7pT44hjdKVY1fLV3GaYPAeT2GxHWqI9gu1N
 LWGRVS/hfBRSGR8UzwfoTgqaZgU4ZhC9owCXuOPqomTl+DPKFDDA+XcNRvLzI6MUE+
 lPLtuXtFwwPb8qCotWIKC6tF6K7vvdgIXPaYIdDVt7Fby1fVJj9bGLs3QFzG/R9z0V
 7QZIbm0kmgNC01bYGVQVKJz0FCFbV1otb33IBIWleK5HOvtzO3MGuZzzBNwpvDPsQ5
 rMfdcTmBFzm+g==
Date: Fri, 4 Apr 2025 19:55:53 +0000
To: "yohan.joung" <yohan.joung@sk.com>
Message-ID: <Z_A5SWl1ueMTZxV0@google.com>
References: <20250403232107.2960-1-yohan.joung@sk.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250403232107.2960-1-yohan.joung@sk.com>
X-Headers-End: 1u0n94-0006lI-7O
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: prevent the current section from
 being selected as a victim during GC
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
Cc: pilhyun.kim@sk.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yohan,

I modified this patch after applying the clean up by

https://lore.kernel.org/linux-f2fs-devel/20250404195442.413945-1-jaegeuk@kernel.org/T/#u

--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -486,6 +486,11 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,

        free_i->free_sections++;

+       if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[BG_GC]) == secno)
+               sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
+       if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[FG_GC]) == secno)
+               sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
+
 unlock_out:
        spin_unlock(&free_i->segmap_lock);
 }

On 04/04, yohan.joung wrote:
> When selecting a victim using next_victim_seg in a large section, the
> selected section might already have been cleared and designated as the
> new current section, making it actively in use.
> This behavior causes inconsistency between the SIT and SSA.
> 
> F2FS-fs (dm-54): Inconsistent segment (70961) type [0, 1] in SSA and SIT
> Call trace:
> dump_backtrace+0xe8/0x10c
> show_stack+0x18/0x28
> dump_stack_lvl+0x50/0x6c
> dump_stack+0x18/0x28
> f2fs_stop_checkpoint+0x1c/0x3c
> do_garbage_collect+0x41c/0x271c
> f2fs_gc+0x27c/0x828
> gc_thread_func+0x290/0x88c
> kthread+0x11c/0x164
> ret_from_fork+0x10/0x20
> 
> issue scenario
> segs_per_sec=2
> - seg#0 and seg#1 are all dirty
> - all valid blocks are removed in seg#1
> - gc select this sec and next_victim_seg=seg#0
> - migrate seg#0, next_victim_seg=seg#1
> - checkpoint -> sec(seg#0, seg#1)  becomes free
> - allocator assigns sec(seg#0, seg#1) to curseg
> - gc tries to migrate seg#1
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/segment.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 0465dc00b349..0773283babfa 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -474,8 +474,15 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
>  		next = find_next_bit(free_i->free_segmap,
>  				start_segno + SEGS_PER_SEC(sbi), start_segno);
>  		if (next >= start_segno + usable_segs) {
> -			if (test_and_clear_bit(secno, free_i->free_secmap))
> +			if (test_and_clear_bit(secno, free_i->free_secmap)) {
>  				free_i->free_sections++;
> +
> +				if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[BG_GC]) == secno)
> +					sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
> +
> +				if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[FG_GC]) == secno)
> +					sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
> +			}
>  		}
>  	}
>  skip_free:
> -- 
> 2.33.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
