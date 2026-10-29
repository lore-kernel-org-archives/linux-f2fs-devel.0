Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794A606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Sh19OnzG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ocu5l7z3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T82TgON+;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8SlSu1Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QpAcIWPLXbNX+oq2kX1p3noOViwwJezD6R30iNNzg+4=; b=Sh19OnzGwo0jpR
	PXWM9HjOJXkZnbeBPnuUIxVsXk4ATLaR9+TQUwcVmog1XfihL/YTiDrDQVKQBJg+plNj8oZ2xkZMw
	qwQOmCuvjb8aqxtQ8W7dI90z9CmQUWZCDrjH6+2NzZMeWcS/R1OF52YK8xALjQK2Xyz76ppVpz+jQ
	ouI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMEyy-000000004gH-2kL7;
	Thu, 29 Oct 2026 01:31:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMEyw-000000004gA-0hfP
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q0ZKJPgJU67rNrM9GQ++LxkEhkMlTwB29Xurgfacd4M=; b=Ocu5l7z3cgY/WrAnUb4INTxrlE
 dRcnGwVBflgLMoEE/2GbopLf1t4ZqSdKARPN5ucrcKLEqEjeB5R0B6AECsU+fyzeR5huIetb7Mszz
 5VgIkHaEPw2JbPrpEVxtFoWz218UADG6b0WKTFp5mQ7MuqrhNe5pbyeyFn7IxDHDR8xM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q0ZKJPgJU67rNrM9GQ++LxkEhkMlTwB29Xurgfacd4M=; b=T82TgON+m/q1Mxr2SEX13XCcO9
 XvTjdXmfRY2my6cMyjXmSlYFaBqhOD/TCWoimCoBKZBdt9bqsA6VyAXnFjN7VtcmEFsRWPJzZXAEh
 LBrCEZh4vnLxn4XUApDuEUwSPjpLMKsT9ebs7Q8Tr5rLYeJSjcjgBbiUMt2QUoKQso4w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMEyu-000000001V2-2v0K
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:31:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10589600D1;
 Thu, 29 Oct 2026 01:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710C81F01828;
 Thu, 29 Oct 2026 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237458;
 bh=q0ZKJPgJU67rNrM9GQ++LxkEhkMlTwB29Xurgfacd4M=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=g8SlSu1ZZkJva0Uk25sxluD+zl/3O4xzpnYvBFwx5q0DeS7PkPttgHY/pXuGpUuKn
 Tn+Sc/s6DxfCTsItKLsYRtY6VWpkwJImXq4WH+NWo/8FX6yYFP/ouyUT+Ra7VtqD2o
 mPdgodkplIWlJze/u8aUtnXlMZNe4ZVjDJj15ZLYPru7QDSe510nMnrgfWjrqOxUth
 M4p+DO2pOE4nlwBneezQADzaZ7uhxGuEUnrVbPK7nieRLyqf0Axa6nt3eOEBW4cM2U
 gfc64Y9xiBYdp7S1YUtjI9poujqfo108loY6ffrEDulvZj+txopuIfCjBzZmO2dFHi
 DsUq8e8xBpAFA==
Message-ID: <50b8a3e7-a779-46b9-9238-b1e345d03841@kernel.org>
Date: Thu, 29 Oct 2026 09:30:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-2-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-2-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMEyu-000000001V2-2v0K
Subject: Re: [f2fs-dev] [PATCH v8 01/15] f2fs: extend folio state for large
 folio write path
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:43, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> Large folio write path needs a subpage status bitmap and write
> pages pending counter, while keeping compatible with f2fs private
> flags.
> 
> Move struct f2fs_folio_state to f2fs.h, add private_flags and
> subpage state bitmap, and change PAGE_PRIVATE functions to be
> compatible with f2fs_folio_state. Allocate f2fs_folio_state via kzalloc
> instead of kmem_cache, since the state size depends on the folio order.
> 
> Note: Now if a path wants to use f2fs_folio_state, it must call
> `folio_has_ffs` instead of `folio_test_large`` to make check.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
