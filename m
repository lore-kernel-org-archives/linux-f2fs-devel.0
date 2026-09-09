Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8393C79FAD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iac9h0wxZtSp6myM2oAUPrQdaBVkluzepHAgX3d9U+Q=; b=EjqR5YcFrXZm8pz6B11gXIvCgh
	BF/aKpMho/Amjv1wXMNaiQGgrtGnq79B8kKBdVP4KwnAEJvesk7y7I7MLvVgwsyFUUCxJyQyaffvI
	+XumapoR7KXITh+RdWuPZa5FossVuvLbaqyQ2h/nxn7Btu8L0SCYQwCvnzEgJ7t5Myf4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4HLj-00047n-JA;
	Wed, 09 Sep 2026 12:24:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4HLh-00047c-U0
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 12:24:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cBzhxQxiITnYJOzsVsN3hQMa5zYjZWLywNfvsBGbMl0=; b=V4mdaTe1fsMwzbV3cRSA4+LMRX
 F9P1/NXdXgJeRYzGWP0WfuQBEmULkoz1gR/FUi/lxUlIgqFvpijY/9OGlepD3VM+iRlx61nls55u3
 qp1ZHDXCINzCrbxMCMost5/6zGZvK+NojMMXL2uOGCo9hOoM+YKnj3pyOJJmcqMogYps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cBzhxQxiITnYJOzsVsN3hQMa5zYjZWLywNfvsBGbMl0=; b=CuTqSOjK5cqamngGZmzTQqQnVq
 2XJg1KMAUSdOO89xPxE5WVBL6tRVdq8p8yTEaEi0QwCZKbv3lF2SkApb1zcQRNuvMjPyXVxD9LDZz
 SuosV75zN1WswcXTawS+BA1FExpD5dcboPGvSPvixg7sY3IfhaIqHneI8V1Iyj+GTeUA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4HLi-0000BR-6v for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 12:24:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7910A40F51;
 Wed,  9 Sep 2026 12:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918EF1F00A3A;
 Wed,  9 Sep 2026 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788956655;
 bh=cBzhxQxiITnYJOzsVsN3hQMa5zYjZWLywNfvsBGbMl0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DA8quWIZKD2QNv7LTGnTOsIRNKzpwuZ4ISU90P1n+X2eidA/Gdfeznj0eWfqndKIW
 xFocVm1IaceDKaLVF4QXdKHQiYuMX/Tj/i5hmlKoCMoCXT4evHaY7oHezy6JjVYWt+
 q69QIR5e+xOGrHhj8qQH0ARcmHJsdkWFnsE7cpPMfaiiR8VSrACC8CNqWh0H46psmE
 OJ3Qj+LBvW8ZdYQCDVC5Ihf1qr//Gwt/mZDbolt0t7vZLYUhQjcoLyREzCftBubmc6
 91L3TJpxKOMmMDndGmQPqg2tOrMkkVFzTb5fGpqBcfc5NbnAY3OMTqtzBQxw0nPxT/
 3KxN+mG4IdH8w==
Message-ID: <572c036a-cedf-4ed6-9814-b821626d56a6@kernel.org>
Date: Wed, 9 Sep 2026 20:24:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>, jaegeuk@kernel.org
References: <20260906145614.2749-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20260906145614.2749-1-jsjlee1020@gmail.com>
X-Headers-End: 1x4HLi-0000BR-6v
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip node_change lock for inline data
 writes
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

On 9/6/26 22:56, Seongjae Jeong wrote:
> The node_change lock serializes block reservation in the PRE_AIO path
> against checkpoint preparation, since block reservation can create
> dirty node pages and update checkpoint accounting.
> 
> However, writes that remain within the inline data area return before
> the block reservation path. Thus, they do not call
> inc_valid_block_count(), change a node mapping from NULL_ADDR to
> NEW_ADDR, or create a dirty node page as a result of block reservation.
> They also do not update total_valid_block_count or
> alloc_valid_block_count.
> 
> The inline path only copies the existing inline data to the data folio,
> sets FI_DATA_EXIST, and marks the inode folio for deferred inline data
> flushing. FI_DATA_EXIST can dirty inode metadata, but it does not
> reserve a block or update the node mapping and checkpoint accounting
> that node_change is intended to serialize.
> 
> Skip f2fs_map_lock() for writes that fit within MAX_INLINE_DATA. Keep
> the existing locking for inline conversion, which can update filesystem
> metadata and requires checkpoint serialization.
> 
> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
