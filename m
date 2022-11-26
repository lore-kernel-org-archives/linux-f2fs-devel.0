Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D847CC4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 26 Nov 2022 02:40:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oyl6u-0003Ai-Ve;
	Sat, 26 Nov 2022 02:40:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oyl6t-0003AY-Jt
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 26 Nov 2022 02:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Wn27ixaXMLku95VoxaPpQ8eUSSWm+I+YPaeOHENglM=; b=GAU5NC3CuJyVynhw+XOdKu1Hbs
 2C4hTza5qTcaCTaiZobBysBT2E7aM3hzRiKsm/h1/6ojlt6z4XeLvJOJXCG2DGNFikYNQV3ApkI9T
 vnn/TfKOt5zeSBXlrgAk4Tqiwha0TPQqb6FkdOSBrFvNmYduY46cNc9sNkVSaPmqcxW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1Wn27ixaXMLku95VoxaPpQ8eUSSWm+I+YPaeOHENglM=; b=Y
 g+A95apmQTHti+1n+8oLnskiHmKL7OCa0tWOBEcg7ZdWmxLm1HhJwMMSrpZbsn9YvTn60PKaJ+hOA
 LEIDoSvuHg0eh8Sh01aa4nmWaaPXX65Hz4IILuQkN4YQYpcBTZ+I0JmdPXfHfy7Kvwl67ibC4Jpaq
 ekjrtU/RNL+apxXQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oyl6q-00DwR7-G8 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 26 Nov 2022 02:40:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5788C61008
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 26 Nov 2022 02:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A88C433C1;
 Sat, 26 Nov 2022 02:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669430394;
 bh=hNp6kkavaA4fFEtDxD/RPPtCE6oh1dDhusRYeGSmsy0=;
 h=From:To:Cc:Subject:Date:From;
 b=U6bj76mOt6z+WXCP4Na0X3vxR+JMS8DKAIInJnpun6dOoNU9YOVT1G+qRXDCjArvB
 XS4v0flEKV1+xaGhlhqNRLOjvFQ3fGVQFdDDTgKBaQJi8R3tcfqa6AEpKQf8rzKPm5
 yDdCtNjm28vj8egsYNA5ygpUkoRqBmJLoHPlz0EIOPtoLYLhYQyU6Yfshi0l1QrkiM
 PtycVjBVxPrCre5JhTGm4bgzmZLSsChVFmqAu5Fd1Y1u4jxsiAK/ryguCfSJOKiyFn
 IBZ+wRiUwIpT9Jz6cC3IWlBQmfD8dVyZjoAIOhesR5PRuULNfeCj6dBI/7aYZlsD1e
 NKcQyyYtj555w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sat, 26 Nov 2022 10:38:07 +0800
Message-Id: <20221126023807.3490189-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oyl6q-00DwR7-G8
Subject: [f2fs-dev] [PATCH] MAINTAINERS: Add f2fs bug tracker link
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As f2fs component in bugzilla.kernel.org was created and used since
2018-7.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..01fdbb592ea7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7828,6 +7828,7 @@ M:	Chao Yu <chao@kernel.org>
 L:	linux-f2fs-devel@lists.sourceforge.net
 S:	Maintained
 W:	https://f2fs.wiki.kernel.org/
+B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=f2fs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 F:	Documentation/ABI/testing/sysfs-fs-f2fs
 F:	Documentation/filesystems/f2fs.rst
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
