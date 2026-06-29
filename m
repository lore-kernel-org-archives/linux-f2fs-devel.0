Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F1BC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AIANKjm7Yaqu7WQiC77VihsKSclPkZvgXFmZVdleO94=; b=VfLDxj1i8OTJ0qlyuRJbyDWT2L
	d4nOa4QXxRZmq7BuuwWlV3xqgrLupDb3ghQg3bzqAhnheWjRikmUlFZewD1l1ie1IPA/ms/ke7cuW
	U27M9MuZS4j2M0o+INbcxddy4LFZGYo/qlppPBOPB5hFC54wnkxJBINwQPC6pUXUWYLs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weApa-0007mq-CK;
	Mon, 29 Jun 2026 12:11:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1weApK-0007mG-7R
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tJe3qyG6yJSlX8bod4MrinTdJQJp8aoDdUVMRgTxkYY=; b=Wl5cdei/9NxCYFSZ2XSe5+VusM
 /LXJ/MlSsoOu/2+mM4wLTYn5CG4oQ8+XlFgT5frMN+aaKNgMqDzno8eGUbrZWfZFQD8m7GH/jSHNV
 E5kmn6C0z1YkBUX0pKum4SRUa2XJDyXTuXlK0XJH2DJ1kwX6fll4sIzyLHZPYkLK/Vr0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tJe3qyG6yJSlX8bod4MrinTdJQJp8aoDdUVMRgTxkYY=; b=Pi54cS0rLLminlMdsjuCmxacJA
 NQCjazoRxEof7XJutjCMgFBaZVhzwyqkKHFSSLMBFNeDSYwCWeUbv89N/J86aT8K7GQtFQSIffrI8
 2P9r96gF2LuQGMHjbRUUgbThDAyrPAaFR17JK6eMCbRJGpfIp54hrqAPt02gFLS9Y7lc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weApF-0001YO-Q9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:10:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 475A541E4D;
 Mon, 29 Jun 2026 12:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DF61F000E9;
 Mon, 29 Jun 2026 12:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782734498;
 bh=tJe3qyG6yJSlX8bod4MrinTdJQJp8aoDdUVMRgTxkYY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bQXC1SyfOeivbaKkPkpU7HqBkwr0X186dD5tSOCCkm8QpvuHISP6pFUOu4KXiV92K
 L3+QZDjEz5aUPDda0uNOWOqxTH49Xol5aisboQvwZlzd6jVLdRdtWd9jxxys52CU+l
 2hca9k4X/aE6g2ns3A/xgQ2L2x+B+IpL+Iv69nOTQeAQzfsN8Qo0W7MmWUd7iupNle
 vml0RzRKULfOspVO4IzdABWMD87BXzCJ9waPlDAe3t6HmubARVjjdCSU7sphnMXmfY
 5Uqc6sLb5+VvRXy5MGsKKm96VNY3xkHuXAvDBAqbfJsKMOu2bLoD4+cbCRjB0AzkZ6
 MGNTnlXBmiiLA==
Message-ID: <4008f7f9-b2df-4cbf-82ff-289ec43624a3@kernel.org>
Date: Mon, 29 Jun 2026 20:01:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260626030728.1364795-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260626030728.1364795-1-zhanxusheng@xiaomi.com>
X-Headers-End: 1weApF-0001YO-Q9
Subject: Re: [f2fs-dev] [PATCH] f2fs: Remove unused curseg_segno() and
 curseg_alloc_type()
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/26/26 11:07, Zhan Xusheng wrote:
> The only callers of curseg_segno() and curseg_alloc_type() were removed by
> commit 5a4fed7cd97a ("f2fs: simplify do_checkpoint"); both helpers have
> been unused since then.
> 
> Being static inline functions they do not trigger -Wunused-function, so
> the dead code has gone unnoticed.  Remove them.  No functional change.
> 
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
