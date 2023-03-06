Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429B3C6FD1A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Mar 2023 21:52:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pZIke-0000vj-5D;
	Mon, 06 Mar 2023 21:52:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pZIkd-0000vc-8e
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Mar 2023 21:52:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H2G+TP6hjkKgQJ+566EXr0uZ/IGR8HgAQW4cwLBXGRQ=; b=VwwWFHfMW+Vq1R5CRDUM8+HzbO
 wZeKn7PQucMxVIFKHLyLzVUWpeCAo1AeTkDWivbGKRPdF5VGUDV13QQsCh4DXlIZiuvhk8jUioLRd
 6obkeOoP0EKqVbadjvQg6kmsRgYkZS8zxtsiAaJ7lDpWpTHsjUeA2LSfCfOJnZyfOfcQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H2G+TP6hjkKgQJ+566EXr0uZ/IGR8HgAQW4cwLBXGRQ=; b=S7IJb/YDTvZdYqCaI0fcTs2Zxr
 Q4GXIFKhgQMcIZs2fgv377971gfA9XwDh3eoFvS9OqRuhkF/WcE0GosyIF/bbH82Er8Yq8EEOLGVS
 DmF4OmnH4+9UPJRdkXRt6aXaUQlhotUVRegBKKebvkrTrlErswf3Pw43dcbnJ7Ryurjk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pZIkZ-001RNt-6z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Mar 2023 21:52:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B9C1960F59;
 Mon,  6 Mar 2023 21:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDA2C4339B;
 Mon,  6 Mar 2023 21:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678139521;
 bh=kO0Keh//hnfQf8ULbQJWCH8cX47nO17LVIchs+as6WU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YB3IQJ2xZiXWlJSkxMXIgc658PghDmAlpzfen7DzM6yBsYExhqY7DYF741alTyqRi
 KoPeGZ99XE2t7ZQc86cJfnpXmQA1hXLiuPz7WTQlIlP4wOcdQt5E0W6w3kaXBUT7B3
 +lEo80rezUP/7mpU9wFNdmaHAsoayTfEF8ZOxCiWohBBmYwHS4Ot/BbRd1q8O7nnMZ
 KG1uuMAqQeaLZzkPiydzMLscJT+QCRpFb5TUrZvoh9t+dQseK0sjZulbHoO3DWsw7P
 cxdKlQoMJ34cWpBofSl6UBH5qO9e6E+74Bp72zlQP5+C8VQDWAp0c8C8MGiMtPAgs+
 oXVxtLf7w8ZDg==
Date: Mon, 6 Mar 2023 13:51:59 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yonggil Song <yonggil.song@samsung.com>
Message-ID: <ZAZgf4sbh14sVZMp@google.com>
References: <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p7>
 <20230216071350epcms2p7b3f5f37b168b634ec7a7ba8555fd0b49@epcms2p7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230216071350epcms2p7b3f5f37b168b634ec7a7ba8555fd0b49@epcms2p7>
X-Headers-End: 1pZIkZ-001RNt-6z
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix uninitialized skipped_gc_rwsem
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
Cc: "daehojeong@google.com" <daehojeong@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, Seokhwan Kim <sukka.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 02/16, Yonggil Song wrote:
> When f2fs skipped a gc round during victim migration, there was a bug which
> would skip all upcoming gc rounds unconditionally because skipped_gc_rwsem
> was not initialized. It fixes the bug by correctly initializing the
> skipped_gc_rwsem inside the gc loop.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")

Applied with the below fix.

Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc"

> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index b22f49a6f128..81d326abaac1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1786,8 +1786,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>  				prefree_segments(sbi));
>  
>  	cpc.reason = __get_cp_reason(sbi);
> -	sbi->skipped_gc_rwsem = 0;
>  gc_more:
> +	sbi->skipped_gc_rwsem = 0;
>  	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
>  		ret = -EINVAL;
>  		goto stop;
> -- 
> 2.34.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
