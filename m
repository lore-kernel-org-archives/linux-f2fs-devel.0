Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5363C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Apr 2022 10:01:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nfIlY-0005GB-4z; Fri, 15 Apr 2022 10:01:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jiapeng.chong@linux.alibaba.com>) id 1nfIlH-0005C4-So
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Apr 2022 10:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3lSg8Nk2VdvNvTZAFl/oTnO7aIqbKI+Uizd5QkeR/dg=; b=AFV6o3eTFIC10t9XQWjdZ8GL8s
 +ew/iNWTgw/aHSwkGxwpjt9oAbvtvMu4CmSDkdZEqQ/jn5mkHAow004nGZDF1e3bpgE83P2pUnDJ4
 LOtg14zuv6R6xZ6KVDz43YycSMPIDYrlAUsmU1H4kZlK4JEhaSnouimdORIEb1BDifpg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3lSg8Nk2VdvNvTZAFl/oTnO7aIqbKI+Uizd5QkeR/dg=; b=c
 3iTN/1Pm08MQ/H9hrJYdOsGzLP5A32xO06/zpSMuKVCjxPB0hQ9BYx7GyP6FkTEzsFaKLOI5IhE0/
 YTAsqyuQmyjAbcUIYyPOi08urJgg1fYcPeiaNFbYKNupk0+SlI2rYlGCmvpOOxnoPXM38do8swIEq
 J9IEMKiQvEiBaWGY=;
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nfIlC-0006OS-8d
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Apr 2022 10:01:06 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0VA6o-rv_1650012574; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VA6o-rv_1650012574) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 15 Apr 2022 16:49:40 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jaegeuk@kernel.org
Date: Fri, 15 Apr 2022 16:49:31 +0800
Message-Id: <20220415084931.49880-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
X-Headers-End: 1nfIlC-0006OS-8d
Subject: [f2fs-dev] [PATCH] f2fs: Fix signedness bugs in
 f2fs_gc_pinned_control functions
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Fix the following smatch warning:

fs/f2fs/gc.c:688 f2fs_gc_pinned_control() warn: signedness bug returning
'(-16)'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 34c097a7821d..4c8ce02a815b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -679,7 +679,7 @@ static void f2fs_unpin_all_sections(struct f2fs_sb_info *sbi, bool enable)
 	DIRTY_I(sbi)->enable_pin_section = enable;
 }
 
-static bool f2fs_gc_pinned_control(struct inode *inode, int gc_type,
+static int f2fs_gc_pinned_control(struct inode *inode, int gc_type,
 							unsigned int segno)
 {
 	if (!f2fs_is_pinned_file(inode))
-- 
2.20.1.7.g153144c



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
