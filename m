Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5DBC87FCF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Aug 2025 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J+l/OySuqE6eZ6aGrWQe5ZpMnzAHrxU7z5lF8Oq08x4=; b=hlmD/d7xi6kLHjF0prSrqT8rsN
	22sTY12T1wqPsiDgA/VGqYjXvO2q5FwaVmSuDy2ICZcSLyyx+OGTkjIHYGf6TEGrbQmiYdameggWd
	1KdbY7MReyQlTNkBBCi/XK6Hhw2dvAKzeQadehYUYo/AGlwtWCHbjSyFjo4LAJb7QEb4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ujvwi-00012G-D8;
	Thu, 07 Aug 2025 08:25:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ujvwh-00011z-1k
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Aug 2025 08:25:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OR9QHI00LT0ur9guZMJm8vRWMWcI+8YCYUJ015GwRDQ=; b=KenTUSD0mB6WhdYKQNGENFGzSY
 p6pe403EMx3y0StHnRxNorEWIz4AXLHrN7TlGm1ezIIi10hl/tkqwxtF8JA/gsDaL7DuwmK9O77Sc
 WXQ8LTKOWfxumFj5jBS2eIj9Y3JsQeAGHS3kir5AhN7Sl0PGQMfHxTh9mtvraQF6peR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OR9QHI00LT0ur9guZMJm8vRWMWcI+8YCYUJ015GwRDQ=; b=luHYYnYT0QaklDaBzdCF+LpeFv
 MPytB/gNoFt9tjFxMEmhXdWyNFMuFgf6yMLkJN/JKKTOunvopln/gktvehP764UOW9mZRHoIzZCmF
 H9zyUIhQp7LN6oNNmobtqvrWKwEMjsTWe7vj5DCEpQ9A453tzMa7mSKd/eLztbQG+Y6M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ujvwh-0005tN-Fv for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Aug 2025 08:25:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B4A3419A8;
 Thu,  7 Aug 2025 08:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0338C4CEEB;
 Thu,  7 Aug 2025 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754555150;
 bh=Mn79SyilYTWcUb+3uimRZQL/uEQPnSniG2yXTYBSAKA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=XxuStNyRcjp45qq/uEWQOjVSNgAXp9QDSPEOAnToeYRv0n/L8IBm9CuA/bwp28HZW
 quLdVJbkHaltlZW+55V+RkYCTzU07iGle31+/OwHlCvFzyyDk0PGEALmqQV3wOlqfg
 0BcvQep2sOmQFFi3B8787hrz+OooqrMC+mIdgnDwxXzfRnTSB7/gHBP/38rqZTnTlI
 lq0nvyB6tWqOur15Jistde4b1bmpNsg1RnsHCaGhNqRuQ4tWIkNgmgb980WlueSA+9
 uO9rsNmza6ZkdzjodusaaNB/alVz/+Ko29mTRZNDMbcveN6xnbWQnjLa3ciBsCymN5
 NB19gUzbiqyFg==
Message-ID: <bc3f73b8-688a-4f1e-a0ce-abe3ce13f237@kernel.org>
Date: Thu, 7 Aug 2025 16:25:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250806091954.180602-1-guochunhai@vivo.com>
Content-Language: en-US
In-Reply-To: <20250806091954.180602-1-guochunhai@vivo.com>
X-Headers-End: 1ujvwh-0005tN-Fv
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: add reserved nodes for privileged
 users
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/6/25 17:19, Chunhai Guo wrote:
> This patch allows privileged users to reserve nodes via the
> 'reserve_node' mount option, which is similar to the existing
> 'reserve_root' option.
> 
> "-o reserve_node=<N>" means <N> nodes are reserved for privileged
> users only.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
