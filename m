Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441A606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=InlVvdse;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kuw2A0Ui;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kzJ0v61v;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkQ6ASTF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GKW3bWbcq+TCGSN4/8TzS+2r9kGkXFs1MuoVPs9tzM8=; b=InlVvdseKXfWoi
	R1KqhglBrht2LYEcoRuq0vJd5wnU3yqt1JMh21rX0E9ZtgFSYp8dhu2BHpbbc3y8Q0ynTUxJapSe8
	y3dJyMp9YZ8C1Yyh7qbQ8x2V2dI6665C3GX44cO9t37aFooErQ2CmF/XVYEp7oXfGdUlWcb1DaZ2p
	xq8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF47-000000003jr-1uPs;
	Thu, 29 Oct 2026 01:36:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF46-000000003jk-0Jaf
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AylnBCCcdsK+79U9qo95ZrQ+43bLKujyoqzIn5/dEs4=; b=kuw2A0Ui5JcEBy3Dm+Ug3PepMS
 x74JToA9Xc4uawrobpBG1cHxEwqMTzDm8FH1nRRPBxaorhZVUAFJJoDhZevQlcrzK8i0CrXflaSLu
 CJhIIvU4Juew1bSkaxBmEgqEYZfqix3EmO2tdGNBlOIlV05GKMNu3dXZGP1uDkg5byuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AylnBCCcdsK+79U9qo95ZrQ+43bLKujyoqzIn5/dEs4=; b=kzJ0v61vxDcw5eO43Xp9Ig/jIr
 9q32k5mZ08zqSyaXqhY4NTuqXR0fXArN/Ehhgxo+etcJiL1YRJ9ZgxiOuwsvuawR8x7f2lq4waiDU
 /lW01/gbiYRxLLhFPhsC5emD+L4B9hgZ4+NlB5KEySavJDx+V+m3NSd2jne0C8FnBctE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF45-000000001gR-2meM
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:36:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A28F600D1;
 Thu, 29 Oct 2026 01:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA61B1F01825;
 Thu, 29 Oct 2026 01:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237779;
 bh=AylnBCCcdsK+79U9qo95ZrQ+43bLKujyoqzIn5/dEs4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=OkQ6ASTFMzz1yXF3njzDb/xUm8DX/UL4mY9uf3JuD4FWS0dVtGHzXKvmmgp9uyD8O
 FrMgTm+gR54TFIT5eLqWmrif4wu7jPIf3RiAYGdqY4OS1qN5qVGYhMLHwXM5BpST/R
 k2pSnkDiNg15azn4hMLObjA6g8gU5riji0JD8txU8BKyPoZFK3jST2PDqwz7a6qKH4
 66d36vsPyioPcGdGaPO3N+deIu8PX5lGpt0YD8vPh0FWweP707XhHGcfZuEyOZZlgb
 4hfqc+KiC1SzEV67pjISFkvDHOjdKcq3WS+58vfZqCz5/SDlJx27MgWrBYP3t1swYX
 fQPcVPoFGJOUg==
Message-ID: <1ebf8257-ad31-4bc1-b8fc-048dcd1819c0@kernel.org>
Date: Thu, 29 Oct 2026 09:36:15 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-15-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-15-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF45-000000001gR-2meM
Subject: Re: [f2fs-dev] [PATCH v8 14/15] f2fs: allow large folio support to
 writeable files
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

On 10/28/26 23:44, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> Now we make all write path support large folios,
> so we open permission to let writeable file set
> large folio mapping.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
