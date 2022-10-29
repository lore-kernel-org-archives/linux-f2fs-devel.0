Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FDC38A02
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Oct 2022 15:08:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oonRl-0005AQ-F7;
	Sat, 29 Oct 2022 15:08:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <wangkailong@jari.cn>) id 1oonRh-0005AJ-Cb
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Oct 2022 15:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AbHY9yLTxHn2TNb9fLdoLL18ztSy3mhImVErewlpdhc=; b=XJ+ALIkCJMMFGQud7O8VunhCwQ
 ulwWadr+gtuQeIdfb91GSLQcxhqyRcj4O9HsKNJShAlCoAZfLGdkr+L27TK2pPR8CHulHfpUMj4wA
 h4IeTYgSGrmmxP24MNbWnNak3YdIjHl6EvZmeN/spf5m+bygpI2AuyY5I8uEE2bJbBy0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Cc
 :To:From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AbHY9yLTxHn2TNb9fLdoLL18ztSy3mhImVErewlpdhc=; b=J
 HNeKQaFOoCaP5GrGdQAfCymBCrV8j5K/dzoSwIxnaN46ziMPBi5jgpviG+8sROANBMd3iVqpbFtSX
 RhuHlxbaIt2txTY4raGeZxE7l7wJc+K4xsN+pqT6RMgz/Jc/q8KkYnHfahBXy8O3QMQN3TFPC/CpJ
 z9gfg08EtjXGgvks=;
Received: from [218.92.28.115] (helo=jari.cn)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1oonRU-004b8P-TW for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Oct 2022 15:08:25 +0000
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sat, 29 Oct
 2022 22:49:30 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.81]
Date: Sat, 29 Oct 2022 22:49:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: wangkailong@jari.cn
To: jaegeuk@kernel.org, chao@kernel.org
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
MIME-Version: 1.0
Message-ID: <44b06118.3c.18424382765.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCnu+F6PV1j+d0AAA--.25W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAKB2FEYx0AVwAJsJ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Headers-End: 1oonRU-004b8P-TW
Subject: [f2fs-dev] [PATCH] f2fs: replace ternary operator with max()
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

Fix the following coccicheck warning:

./fs/f2fs/segment.c:877:24-25: WARNING opportunity for max()

Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ada21e83d279..6da92518328c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -874,7 +874,7 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi)
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
-	unusable = holes[DATA] > holes[NODE] ? holes[DATA] : holes[NODE];
+	unusable = max(holes[DATA], holes[NODE]);
 	if (unusable > ovp_holes)
 		return unusable - ovp_holes;
 	return 0;
-- 
2.25.1

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
