Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B05FEFCE39
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJXlSutFt8Mxoinydbz72tvRbmVPFccWpvcjhc6wxhw=; b=LYkGTOWXUz+5e/XKYaP4r+1yVm
	kaBOYsR2S99pC0cxtsGi5Wuy7wRIJO5feC7PFlEcSLBaL2T7WHX65yW6uGeEqmLCG8QUujKobkRQU
	GbhnVdBM5WadlzfMbZsmHotytwLRWru91F/PaWyXxTIwFLeVf6ypjbEx5B7x9foiKnu8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxrWd-00053x-NU;
	Wed, 04 Mar 2026 19:04:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <agruenba@redhat.com>) id 1vxrWa-00053n-A0
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 19:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=content-type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nM7kNBSEq9uce0DB9nBNjzTI/YSlQuc5UuGQ7K2UugI=; b=fIKKtKsoGDalpm9Dv9H6V23OX1
 lVjG6FXNknJt9ofe6X3ZZ7X2o4rd+2rphWM6S2ySCrHw5bGM7Bw1EQUfkHuPNSf64ynjVGh+Zrj8E
 ABBkHBlYcPvxVMdRrA5MGH3ql9r5F26+fhdOnsxP6HfhDWAc5UTtrZf13qUE2PG144e8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=content-type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nM7kNBSEq9uce0DB9nBNjzTI/YSlQuc5UuGQ7K2UugI=; b=Of/pDBAyQNjrTs/skVM4IJuad5
 VL2qAZY/rDmoWMBclGT8TqAK3p3pfKnewFDP5KAhguyYG4DRQQwuxnUl72HBGXPb1k1khzPppEDGO
 KqG13V7AcLMGEcaP3Y1jTc9OzUi0XEMSnOlNbK8Ftx6bmKSu5MhHrMbGT2hJTKLkQfvc=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxrWZ-0001WF-Rm for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 19:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772651077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nM7kNBSEq9uce0DB9nBNjzTI/YSlQuc5UuGQ7K2UugI=;
 b=fS4x4TYUWdabcFgc1tL0pjuTCwpUZM5OpxMv71PsVEXkYtRk1S0Q/rPqHXpvqoIwk4GR9i
 6BCoPbM4hQwV488A8f/KgaLF8hYkpH5cl8exdAoHpVibILXsKmYMzomZS8CkeYicA71kac
 OQah3ufJYjIP/+UtroyTfPccQgOb1Xk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-ng3K5dKrOE6uUqSz4RUfzQ-1; Wed,
 04 Mar 2026 14:04:35 -0500
X-MC-Unique: ng3K5dKrOE6uUqSz4RUfzQ-1
X-Mimecast-MFC-AGG-ID: ng3K5dKrOE6uUqSz4RUfzQ_1772651074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B99019560A3; Wed,  4 Mar 2026 19:04:34 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2E941800576; Wed,  4 Mar 2026 19:04:31 +0000 (UTC)
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  4 Mar 2026 20:04:07 +0100
Message-ID: <20260304190424.291743-3-agruenba@redhat.com>
In-Reply-To: <20260304190424.291743-1-agruenba@redhat.com>
References: <20260304190424.291743-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: _r45CXHSEHr7L55Y7QPW-CIj5Mq6dGVhvBgT5xBm9WI_1772651074
X-Mimecast-Originator: redhat.com
X-Headers-End: 1vxrWZ-0001WF-Rm
Subject: [f2fs-dev] [PATCH 2/4] block: get rid of blk_status_to_{errno,
 str} inconsistency
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
From: Andreas Gruenbacher via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: dm-devel@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Change blk_status_to_str() to be consistent with blk_status_to_errno()
and return "I/O" for undefined status codes.

With that, the fallback case in the blk_errors array can be removed with
no change in behavior.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 474700ffaa1c..a20042f15790 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -161,9 +161,6 @@ static const struct {
 	[BLK_STS_DURATION_LIMIT]	= { -ETIME, "duration limit exceeded" },
 
 	[BLK_STS_INVAL]		= { -EINVAL,	"invalid" },
-
-	/* everything else not covered above: */
-	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
 
 blk_status_t errno_to_blk_status(int errno)
@@ -194,7 +191,7 @@ const char *blk_status_to_str(blk_status_t status)
 	int idx = (__force int)status;
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
-		return "<null>";
+		return "I/O";
 	return blk_errors[idx].name;
 }
 EXPORT_SYMBOL_GPL(blk_status_to_str);
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
