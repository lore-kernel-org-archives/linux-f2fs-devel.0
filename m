Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C326C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V9wLPQmQOZ+PZGUxI2nx83Raglr7VU2OIJdickvx+8M=; b=RsslQW74TXywNy9aiF8xFiV/k4
	B7MimsiNNVb4hBzrnAEdjzYDnjE0D2YIev0876l0s8GP2ykdwIPHZHKvJDRiwTGdmvoNU3jbbiByF
	b/W3IQCUy9swc0oUWdH78q5BosRUKPYHvsmRNP2XN6q0FGDs21owsgdDQpytYnmwtUhQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoB9-0001vY-JV;
	Fri, 14 Aug 2026 09:26:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoB8-0001vM-9g
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=thIo2/1hw+ojTe/xNPHRiyG1yeQkk5de3ZJFeVRsmoM=; b=eduPQyDA9USSicqsZ6F1d2k2cz
 s2ubXTtKClHunSjbRYaaNwRQyHg3OFUUAaK8+97xw5cr99MBr0rK5X6hpJxESy1E1FhROE/y1nkuL
 mQMMghU+rYAAyw/IMd0cP3ZMrXQAZe+JYMeyNNOXMOgbxbcZg2Woo91X1l7hCLO7epfE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=thIo2/1hw+ojTe/xNPHRiyG1yeQkk5de3ZJFeVRsmoM=; b=NUffoR4aZIMQrOi6ivJBa28Ark
 FEsDW3n3THnxZSXW2yf8oRAB21e1NZuqzM39To/hOGlg8tnblF7LjwrBuFBFvFMxgSFZbqQVl5oZX
 xtq4KJllk6rDdOXAx62YkE773eDXMxv3gBZ3vJVZVZ5Pm4lcHGRm7e40VB5W+OXobzas=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoBC-0000nl-4S for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4585F412E0;
 Fri, 14 Aug 2026 09:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBDA1F000E9;
 Fri, 14 Aug 2026 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699573;
 bh=thIo2/1hw+ojTe/xNPHRiyG1yeQkk5de3ZJFeVRsmoM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N03TDZZjfpmiLarfDYDPPQ2E62dA1SuD9+t9GRO1owqNunKTQGbfV9BQUsXG0AM0E
 bSEcfG+CsnhVqcoFHtwi3SCEhKa4QJWcN1px5Qv7yN0+P2DNyNK2yUcnNAW99MZI5N
 5ZZl3zkncKliQNAq/IEun1j8zPYNrKDDovMxkd2+PKwpX1BklwvBqarRAdWmY1qANx
 0RO0vC3qAHiHl43pFH41RqL6nDt5INwvFOrycEEVfm7mWul2se38jQL+gN58mxknCK
 Aaz8SRNdG/wPeH9EOQKKcFeOUWygRYIaZ77oWkZQ5Dl/T9aKMflObVGt04xuMwux66
 FySW+bq/tcBWg==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:25 +0200
Message-ID: <20260814092448.1818082-9-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoBC-0000nl-4S
Subject: [f2fs-dev] [PATCH v15 08/25] block: don't delay bio task completions
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Christoph Hellwig <hch@lst.de>

The delay causes a more than an order of magnitude slow down when using
it to defer the T10 PI processing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index f228940d6b42..79fb94f85a5f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1811,7 +1811,7 @@ void __bio_complete_in_task(struct bio *bio)
 
 	if (was_empty)
 		mod_delayed_work_on(batch->cpu, bio_complete_wq,
-				    &batch->work, 1);
+				    &batch->work, 0);
 }
 EXPORT_SYMBOL_GPL(__bio_complete_in_task);
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
