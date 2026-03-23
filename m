Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2D7D58CC5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2026 03:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bWbBS8uVgP2o5QvWojyBo6NOL66Fs6Dbi87hckh3W90=; b=AV3fD7b1JOxACqpaL57v6hso/z
	j5193X7gwYPmfVio82Iul+1xllKpV0WVlCwmTibWaUq6HHpLZ/qDIDp0bHrl/q8TqsBT/DMSxb9IY
	nzWnpYiwvC2MMkExkXyMyn4nlcC2FwZj1IVls+DRMqigQZdyXJ6NVu+O8nyfQOekvQnw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w4Vjs-0005lq-Bb;
	Mon, 23 Mar 2026 03:14:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w4Vjq-0005lh-OW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Mar 2026 03:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X9vz0wls6/AuT5y5W4DjeWFadE3ugVws2VQ7J15K1Jg=; b=VKGhSiipA1H5t6Zv0sVvfcEzLI
 UYoYIzno7xeEn0lZu4fmQZw0ZUFJaRDruu5k20ID/dTwFPBW1tyZK/3K/NYnTrjQqDZ5nVP0Tw5of
 vj0T/cU0QuaC6VNGQXt/IlYlqoKbzt5cpPYE11fEauuHsAiegHr/uYvVFhYTv9pt7x9Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X9vz0wls6/AuT5y5W4DjeWFadE3ugVws2VQ7J15K1Jg=; b=REFce/OH4Sujs3AnjnaCsoNynu
 gyY+ywXkyIIXpH56Zt4do5TTPIkGajNdU34H2xVor45u9QljV5oIKmhtD4U0BKrg1KG6xh8XLT4Xb
 YS3soNUwBiWOQLH4IQAg11BIs5QfKwJdjxdwICbUx8pt0X+qmtRNboKOMOT1F8bVkbOU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w4Vjq-00007y-6K for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Mar 2026 03:13:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A421E42D98;
 Mon, 23 Mar 2026 03:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82067C19424;
 Mon, 23 Mar 2026 03:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774235627;
 bh=e5zTK41GDb0sBWypvuuACzz2sghGfVU2I9TaWnwqMVY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=rgsrIqhKSVlhWrVYdRNMnim5f+YD96EM1ZTyIwo8+dRnVCe87jFzCuB/4Gd2EoDMC
 Hh5D9DrWw/Fep8kZgDKf8Bn7aUzqQNvOVGAxvmxe3JaugtYTytar4xK176SpDPtx+E
 btchRQiCF7ZiIlC7yVwYjHz7jXRB2a4oA45giBOzNLYNMejSzlBUiWIvr/c6lagmTw
 fdanwFVYqv5cJ+1pAu2giG5p9OP+riDdQ5TDS58iPLiMq0ouCOYRiWhTDPa+oKyL1E
 PU4rubN1fgLuIdZDkksOgRnfIbDPlv/kRN3SVIQKx9WBgRwniOejB2XjlVYXhpSFyw
 +GBUXhmaR/aXQ==
Message-ID: <d2355ea3-50d6-4be5-88e2-eaa21ec1c143@kernel.org>
Date: Mon, 23 Mar 2026 11:13:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260319083525.603728-3-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260319083525.603728-3-monty_pavel@sina.com>
X-Headers-End: 1w4Vjq-00007y-6K
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop unused ri parameter from
 truncate_partial_nodes()
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/19/26 16:35, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> The ri parameter in truncate_partial_nodes() is unused. Remove it along
> with the related code. No logical changes.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
