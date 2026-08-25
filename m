Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE69C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7q1feCgXaa9jU/+StPSys5NzKy9Op1HVXaw8TEQLRY=; b=ZH5o2lMX3QibFegYiJZihhtebh
	E0gUwytyGU27lSIpoY3/UtygtS2VV3UnDsS3oWOCy1p9ATXjVqX4WbWpkpAbhSoZ8Vlkplexf2vBV
	U6pjoNyFD2S/XSK4GtCQpwheer7+ni3Vph5Ytmiux21Rg+jJUVm0uADwhj5rGCvB10IY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyjvR-0001j3-L0;
	Tue, 25 Aug 2026 05:42:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyjvQ-0001ix-IA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+j0qM0BXUEQ/J2YBhFyUKh0hqXhTNS20o+SR7bnInP4=; b=FkimzU+9lVG0CmVEiym7RdK3Q4
 +LoCNzWU7tVDEySajr19pQ868zMh/XS88tOX9ei2YLuJkm7E2d+4ny7AYtiClXRWslUl7fFSL5sEL
 dRPlcSGLd4oA+H3I0IuavdwJnxN1Kfh8DdHNlhlqUeJmy1aIWQIcElctEHzdywtYkC8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+j0qM0BXUEQ/J2YBhFyUKh0hqXhTNS20o+SR7bnInP4=; b=MYcoiQf4BmcnHIabaqCGP4HcDB
 FwwqIG+J+TYzARSWtrECOS/PaJZ0tsJY/V94U4FgCQaE1uHaM5RDct5Y1kr8NeHCtuXno0u1GuxoD
 648kdBz0oynhUZh8/jGmWd709egwtJ3ilGryZfYAm+yM4Asift+4BBCWjYJcp/sBBvCI=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyjvP-00033W-OX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:42:21 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso5460463a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 22:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787636534; x=1788241334; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+j0qM0BXUEQ/J2YBhFyUKh0hqXhTNS20o+SR7bnInP4=;
 b=AWoxZTaUUN7+xrr2CxrSuHOu8budJ01Tzv24UPjg3OQm9KH+76/04flvlin96LNBxZ
 Q0SatIXhSUQrvx2SsRtPlAwnwu8MKynHVt/rRgoOVJ3+Q4LebhLBRNEfWGx9jyH5TERZ
 7Jom1m76rxNZ2DGm9h3sTj2iwfNwjkteu+imZL8n4asPNQ5E2WsF3qYAzj1MF0JkWIf3
 J0HMkVWa8orElsopd7q2edgY4a0j1KYYMOIud6hNOHlN1Ds8ap96cxS3yxA7wuJA9fOn
 IOLYdn2ax043xTx3rqbu/M0T8Bz+BmIVINHh2APmzhQI0HEJUy+NsXRecJ5LRbCG2o2w
 Yr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787636534; x=1788241334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+j0qM0BXUEQ/J2YBhFyUKh0hqXhTNS20o+SR7bnInP4=;
 b=pF6X8FtaIVO0Xh8V9gXt8T8EesEvRX2TJy4GyH/Cv556bQglTpL95dqsuBX74Aq/rk
 +RRurZPdTGZg1/otJLz0oXLEmXMA64s/OO5sHC8mJi1aCgxhIl57chPcFNYPoW69dmDB
 iKA94YA+546TNz6qXnqxQef3XrUILVf56fAMxg+0LHWjDAzX4+KKx+J4TByrgjHzipkt
 MH/E/Genv2NcJhUGt1BcDhcl7WCHV1RCbVbXjDqBNDcqggx//EhO1Ze3mLaliFyk8H+1
 V/WlHxUDv1bTKSUGdwQJMGw+IlithgPcfJdWYjI9AoQuAoHAhrWcZYKOB6PLdScKs4LU
 DAow==
X-Forwarded-Encrypted: i=1;
 AHgh+RorBWNm3Rnk3PbWqXAPMDmH6mz3p328CBJZJWAHC5VKMs9uYQ00XbgubaxqmbVFeY8xrtKC7rujbx5VAjAQZfJ8@lists.sourceforge.net
X-Gm-Message-State: AFuF++nP31AGOW/wUOiOhuyg0wgGuZiAkP03ttWRkOUMtVzMBuHlHgwJ
 b4T277NjU3eoK8VNjJx94rQG4dxu2XxieqGRbrQwGi8omBg0CKr6fV3T
X-Gm-Gg: AR+sD11srsVKAdSc91lafB7MnC77vzErVAEcB2DnbUO6QaLeqtg0GzcYsMeZ+Bl28+8
 ZF1JBE7WX+DthCxS4buFS7an+KkdQzYZd65PlGMxtmL0dFIgZrd51xz6mlMdgRNj28HHJ3gg+QX
 EcqAIvpCYkCYI4zw6z3MmrJSeoOmZVQbT1seSfWo//FSFF4oeU8wSFwUjEUqlpOMbKItsrBIjHT
 GZOla5MK1OBdF8B07ZiIzFUB+0IfTQg9MJRNYnJ6SAehXGUgfdN2xVQHq27YT8qnYt2f5Aj2BCg
 pe/6x37Yl9VytSVQ+g8u9wTRpekem2r94i1CyB4dLTWPLcLQ8rJHboLJE1hfhpIeBAdtsCkcf8s
 2I+9fpV7vu1trg7RS85oCXJv8aOpnOMon7WRvSi7FuceliifJs9nj4pe7Vv9tE90NrAcKujPI6p
 KMyHU3xqyg803S4TeZvlJ+dyoOkgJtkTEkT+HEtO8F1CnGGMvjwQ04x5nYkupsyl2Jc+E3qwxik
 +1CybcV6vxZafn60rOJgHyP
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id
 98e67ed59e1d1-395df4dcdbcmr48699828a91.15.1787636533898; 
 Mon, 24 Aug 2026 22:42:13 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d69065sm2480376a91.13.2026.08.24.22.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 22:42:13 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Tue, 25 Aug 2026 13:42:05 +0800
Message-ID: <20260825054205.397297-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824134731.3704352-4-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-4-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyjvP-00033W-OX
Subject: Re: [f2fs-dev] [PATCH v2 03/12] f2fs: cache: introduce shrinker
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> static unsigned long __count_cache(struct f2fs_sb_info *sbi)
> {
> 	return sbi->meta_blocks.num_entries +
> 		sbi->node_blocks.num_entries;
> }

and the scan path includes:

> freed += f2fs_do_shrink_cache(COMPRESS_CACHE(sbi),
> 					nr_to_scan - freed);

The count path includes the meta and node caches, while the scan path also
includes `COMPRESS_CACHE`.

Is `COMPRESS_CACHE` intentionally excluded from `__count_cache()` even though
`f2fs_shrink_cache()` scans it?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
