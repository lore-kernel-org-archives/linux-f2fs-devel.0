Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F7CD98E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ebflSOS41mAOkbqHr+3wluv9tND15wIRcL0X8M7d4+0=; b=aCY2x3hgE0svl7EgfhptVbefxi
	nwum1apSfBDw9GTjtsqsMHjCqcrPsvTed0GDD0xsO88jtCTwb1KGgodVK9RbltYM9IKgKXiciueLH
	PDRJFaXQDgXL5/VgJ4quN+QjWUXDdUT/DGTE2BFhUh777qZsIHn5tKjL2wyVH2Pc0ouY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZuht-0007ln-EK;
	Wed, 17 Jun 2026 18:09:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wZuhs-0007lg-L5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 18:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jWEa6RP1Pi3Ycy/oGmflXx0TMIdx6fHkv2r2sAHUe5M=; b=K1RaD/CA6B7LwSgzePOWihSB76
 /NV+lQj6K3SqvnzItUQPIVI7xSQGkO1GdKnfYlHkR0F4Y6qtLlENn4aUDc3z4sFAfxiusqM6rPphb
 J17TbnUjiEeeINvz1a+1O3D9Gjtcva52pI01OueZEamaXZqvNmoV2RbJE/eSlrwRnS3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jWEa6RP1Pi3Ycy/oGmflXx0TMIdx6fHkv2r2sAHUe5M=; b=DXGdRSmUZYyIOdOUp4YqAzsMhG
 LAYBGR9hJuxE6iu0J2bFX/Mq/BdhmaXIoGz6XNF1xAakd0sEH9J18RlMZagNYxAP34PolvKJMT3U3
 MI5GlmlnY5finV4cFqiYDIMAqqx2ekUfulMJDy7Ht9FBQ+oeHO6qZJKZyGGYXExaFBVA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZuhp-0006Sg-Vt for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 18:09:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF23D6001D;
 Wed, 17 Jun 2026 18:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F19B1F000E9;
 Wed, 17 Jun 2026 18:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781719776;
 bh=jWEa6RP1Pi3Ycy/oGmflXx0TMIdx6fHkv2r2sAHUe5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FvR2WSXb120GdkouzMt5pxNolEXMByOMorJ2qh7bQ5fpzAlqYLc4BrvcueSaoHTXa
 Cn1vkCsT+oHzPgJW2IWomMhsHj1FYD0FAlZURjHcNCRiqHpa11+nDYxxO95Adikfrm
 Sy6AdDOCZBPOeDzqGhismne1s7GGF9TG81ifMqvtfgHuZg/nMwxfIwUdlL5FyVlBTP
 qmMZm8/JW4us9Tpyy3+ZoJtliXwZ6/woJo0rnPBm2lTLVAeu14AcCiGWgMsSEre9je
 e4kcQe46sD7adaUGKfRwq0A99LjZhoUGdYz3+ICnCC19PxB91DLbZ+lL+IfKvDRsym
 n9s7yl3xl7NHQ==
Date: Wed, 17 Jun 2026 18:09:34 +0000
To: Wenjie Qi <qwjhust@gmail.com>
Message-ID: <ajLi3nLqyS31Y6J4@google.com>
References: <20260616135637.1439319-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616135637.1439319-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wZuhp-0006Sg-Vt
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: use post-decrement count for
 cp_wait wakeup
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
Cc: geoo115@gmail.com, yangyongpeng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/16, Wenjie Qi wrote:
> f2fs_write_end_io() decrements the writeback page counter and then
> reads it again with get_pages() to decide whether the last
> F2FS_WB_CP_DATA completion should wake cp_wait.
> 
> Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
> decision is made from the value produced by the decrement itself. Keep
> the existing dec_page_count() path for other writeback counters.

Is there a race condition to do this? If so, can you describe? And, I think
we need a wrapper function instead of calling nr_pages directly.

> 
> Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>  fs/f2fs/data.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d83a21998ec2..58d23eb74ec2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
>  		if (f2fs_in_warm_node_list(folio))
>  			f2fs_del_fsync_node_entry(sbi, folio);
>  
> -		dec_page_count(sbi, type);
> -
>  		/*
>  		 * we should access sbi before folio_end_writeback() to
>  		 * avoid racing w/ kill_f2fs_super()
>  		 */
> -		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> -			wake_up(&sbi->cp_wait);
> +		if (type == F2FS_WB_CP_DATA) {
> +			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
> +			    wq_has_sleeper(&sbi->cp_wait))
> +				wake_up(&sbi->cp_wait);
> +		} else {
> +			dec_page_count(sbi, type);
> +		}
>  
>  		folio_clear_f2fs_gcing(folio);
>  		folio_end_writeback(folio);
> 
> base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
> -- 
> 2.43.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
