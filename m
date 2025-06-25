Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46315C77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Jun 2025 02:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QBRahsn9A+GcPDSj5s3BK/RrQn1c7eYK7N8MiyBf4NU=; b=S4Pi7j8R0xsGksvoRh/iuU/eU2
	c5v378BPN80Jq1ZCm8y8jkd7XdyTBC0KTLHqvJE2eXfmtiYxLvGpadL+boqGu008T6ldCMhW7177n
	04F91oJC6OP57osvWYWoChYKAA9g9UwwiqemPRxowyg8mP7XdebDxoFoKQ5F/y0c6Sw4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uUFn0-0004qi-PP;
	Wed, 25 Jun 2025 02:23:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uUFmz-0004qU-7d
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Jun 2025 02:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0YTrNzUckdCZBzOu/XgioKucuPQaqUUyI0NBUCrS0GU=; b=W4bKmgvo/i7OebrCW9e5H20bdI
 X6r4fUp+lNRRbhRgfKylgIhO6zdGV0kzX3DxCopbJKbB+SZRWQwC2FiskollEUFpT8AOOBAgN5QxA
 35uNRgrQKKzCVgQjwmTyjMlIvGqZYKUlFczmiCm8AEBMUJy6DhsVkZsp3DmbNtnSTkg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0YTrNzUckdCZBzOu/XgioKucuPQaqUUyI0NBUCrS0GU=; b=OL3Zazj2OWH4OrLrsSvyCWRZSm
 C0wh39lgn3kdDNqmD0x+0iU68n3s4MoA9IV0+3zngFKl5t6d4wlbdrtCKIKdDA9J2UeH2/380JKwD
 LIjcNzLJkHeL29bvkotWvJg5ajvXcmc8EZLBgften+XCz/hErcyP2kaAjoHIfqWJQgVY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uUFmy-0002q8-Sl for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Jun 2025 02:23:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 159D15C5B4B;
 Wed, 25 Jun 2025 02:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BD3C4CEE3;
 Wed, 25 Jun 2025 02:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750818179;
 bh=pguSRycrNbFdkyJPsIgfnM0XWMKUhRIIm7qAZD2y19w=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=CmMFHkHe+ifsEcsKBdFsZJIiXI40oyrRGAjlladXEbIyCl03wmwcXqWCDQSn0kESI
 Fu5i4At5zs2D2MaZfkuzR9wUe2Lgu0e9F9M0Gty/je98o+uXAoehSNqgV5lt+PvMUZ
 Oid3DzLiDf1PTWXJ3ZRnDrGfprTp/ILh1ouax86ameUM82H/gF8F7CdBBuDxxqktKP
 SXmRx5WOhN8zoMVGQ1j2HxjtpLHEZ36toNijexB0Tcs6uM3BSc2DPoFwoRf3rN4R0V
 +pq/KMiMCkNchjNBwYoS7bDANJ9x/oaX9J0ntVeJHDvrd09DXTi9urQYksPWtZ/sfi
 hNrQJcr6RpMWA==
Message-ID: <c5109563-a233-42f2-946e-e5b7339a03d5@kernel.org>
Date: Wed, 25 Jun 2025 10:22:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "yohan.joung" <yohan.joung@sk.com>, jaegeuk@kernel.org
References: <20250625001408.1961-1-yohan.joung@sk.com>
Content-Language: en-US
In-Reply-To: <20250625001408.1961-1-yohan.joung@sk.com>
X-Headers-End: 1uUFmy-0002q8-Sl
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check upper boundary for value
 of gc_boost_zoned_gc_percent
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
Cc: pilhyun.kim@sk.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/25/25 08:14, yohan.joung wrote:
> to check the upper boundary when setting gc_boost_zoned_gc_percent
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>

Fixes: 9a481a1c16f4 ("f2fs: create gc_no_zoned_gc_percent and gc_boost_zoned_gc_percent")

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
