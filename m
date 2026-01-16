Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077F9D4A613
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bt2aujOy6eXzyh1utK+hDokWbTaA/0S+cnQJx3sGUD4=; b=inya0MdBzFmjFYEwk/Epwff2ED
	1DCfZweJULg1M+ryl/pAUTHCUmN6xAAPo1IMoVAUV5xyyX6P3/5piJ9dw5j1f1CxW2+1pld9Yl7gL
	0la/ApwRapD6h8EMqtDsGfQMoMfl88mTzBKgUA7hvuaCUTPmh+1QjNuzS7IISaM+Tcts=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vgfb4-0003SG-L4;
	Fri, 16 Jan 2026 08:54:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vgfb3-0003SA-Jn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Jan 2026 08:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tHPF2gcf41VznmuCiuokS2T6elwRWVfJE/WrKvpJ44o=; b=HGcpv9eM53knWVwIERWSrgviml
 i1pGnF9/xTuTkIIcOO5at7cUEN7j9GoITz7AEm+T6Chu9VXoe6YO5risYxJrfXN6/mNYpWwUJjl/X
 /47pQTTHRUD2H5Y9HYqoX0SUHSnjt6xjw7JshekIbA00e+f1vOD3Q81YlyelTd/0H5gs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tHPF2gcf41VznmuCiuokS2T6elwRWVfJE/WrKvpJ44o=; b=apgqFRa71GcWYAECbl+luMq4qr
 X8s7jcbynxr5miARClE5u8XMLz87vgJuIKd+/0Tkh9sNwXIHvuu7EZJBTsVvtqDDs7HeLC9KHMvpW
 jQ24gkeDe9Ni3Whs/l4koVTuHhOfqnSKgqCG5hyYmPfdmpCivA8KyVdLS55klul4xkBQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vgfb3-0001Ay-8H for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Jan 2026 08:54:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CA4D0440FA;
 Fri, 16 Jan 2026 08:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E34DC19424;
 Fri, 16 Jan 2026 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768553650;
 bh=WTYIfhRF3loahoC8/Uf8T6lshLAr9N+SaWHOTfGAjtU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=uJyCEcC51x4+VOb/yk4o0DkxPWK9BaGIIJ68maewOqC29qTyi90k9G6yHFfYPVK29
 4TgSd52ogoVsTXS59B6vB2s3rFM9JZ0njOJ/3oepbaZ6++5FFAPB1ifJ2VWtcRkEMV
 1cqIXXAGnc4zfar85z9LGhGuKtUJNrgSoMXXDWnWhuaRFmliFWO6Lx544LmIyN9DWj
 d4a7NUIiCimokP04q08zps9RXaSzkWX5AnPtD5xVSQFUyev0ehp2K2xh1ocVP2872m
 Bry2xGAGJ+6bwMGAy+IB9TY6lxfoBv9Q+HY1WCzbY3o4/SDiFvmevzsTMA/FyhRd47
 vscFT8unYsPtQ==
Message-ID: <8b7a0a02-99c4-4b5b-8a37-b69a9bfd710f@kernel.org>
Date: Fri, 16 Jan 2026 16:54:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260116043203.2313943-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20260116043203.2313943-1-jaegeuk@kernel.org>
X-Headers-End: 1vgfb3-0001Ay-8H
Subject: Re: [f2fs-dev] [PATCH] f2fs: use folio_end_read
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/16/2026 12:32 PM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> No logic change.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
