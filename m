Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809B606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dNnF704C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kavNB33Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HyfW0JeH;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWPGoSjk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=y+z6nsRFyLC6HYcPvDG5Dw56LWDkeYs/bgJ0BJ9bQy0=; b=dNnF704CU8XgcP
	l8MQMC6RSP0+Z3P99Phf5xVYmZmuRVB2gno587A1nWzEO0a5L90Tq2WQwZUmMUb2lXMa+g/WyuZdA
	EV439onCHI0hmA3xsGdY156EwyaoaFvy4pZIAGiC/CxlMCGfeDwpzwqfxPzW97HCS96vyKfMcvw6a
	B0w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF0N-000000004mc-0lre;
	Thu, 29 Oct 2026 01:32:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF0M-000000004mV-3K00
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=15Ra/rwdO/Kadg/p8Kzkk2D7noAWdrRG1iepoM3Bqqs=; b=kavNB33YJjnNUc6JdqFpIGbBKf
 xQx9/ItmpgqlSDEotvGdowq6ztyg1jcHlO656R9JVdnO8O6h7HnQNh+UDhDm6YN+xG330Nr2FNdbZ
 Ld9NMQfarPm+TwkWZi53U3i6EVSYtxZC2s4y5AxsDadj91KrZ9eNwI79V6Tle8Op4mpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=15Ra/rwdO/Kadg/p8Kzkk2D7noAWdrRG1iepoM3Bqqs=; b=HyfW0JeHmQ6anK2p2ryzBv5Sod
 BXgUcFFayHK+k1SnO8byrKcCqnVPt3yuFh85DI8zYayl57B+ODKhzM7bYHI8GS6qw6LT7D3nF4ggo
 +Dn6sH/DyyWAlQFNoILF0M7Dsov85Zqge1tSoyYup08kb3ZJLTymIaYXezKZTgs4/268=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF0M-000000001Xv-0xub
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:32:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D847600D1;
 Thu, 29 Oct 2026 01:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A3F1F01825;
 Thu, 29 Oct 2026 01:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237548;
 bh=15Ra/rwdO/Kadg/p8Kzkk2D7noAWdrRG1iepoM3Bqqs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=OWPGoSjkJAl5EDFwakE/PvpPSCBgad75UHQG7YIE7Cj/PQIBgVXybVVdZbOKJgGwW
 0l8m0EwKgBTMWfaSZqdzQi8nC0Np6geZD7yiVkvcy2BqrSb/jCYAslrBU8NLB3n4hT
 CDqSTmNzfbgo8p0MYEq1SlEHHztgJvBcJQeF/PV8RhRB+ivGhK3CdGbSTPEka4/oNF
 UE8wAXd4PW9+Ef58af149R+STnhmU263EeCHaqhp4i2Aaxuv4QhekKydG9BwpZHmW4
 m1sbJwwZLvlX3N2qJvcnHWd+/N2FgGLr0JSQHYLV4TlT01uOpwCCVFzYmOJvwD2wLo
 N9nHHiT+rf8pw==
Message-ID: <288cd311-055a-4116-9425-133064548c96@kernel.org>
Date: Thu, 29 Oct 2026 09:32:24 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-7-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-7-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF0M-000000001Xv-0xub
Subject: Re: [f2fs-dev] [PATCH v8 06/15] f2fs: account large folio dirty
 data at block granularity
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
> Originally inode->dirty_pages was accounted once per folio, but f2fs
> needs the counter to be accounted in blocks.
> 
> This introduces batch dirty page add/sub accounting; for a large folio
> the changed dirty page count is computed from the dirty bitmap bit
> changes.
> 
> Found by f2fs/006 (lfs + checkpoint=disable) and generic/363.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
