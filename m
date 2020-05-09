Return-Path: <SRS0=U1zQ=6X=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DBDC28CBC
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2020 11:22:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BE824956
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2020 11:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="FCs3qGWf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Y5Lb6swv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BE824956
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jXNZ0-0006pk-AN; Sat, 09 May 2020 11:22:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuehaibing@huawei.com>) id 1jXNYz-0006pc-HZ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 May 2020 11:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YWzCc1H6ntxS1SvenEwcTtuD770RxXog9I7WjJJaTdY=; b=FCs3qGWfURHGNEbCxGFF2RUL+Z
 +OEqPXifvFaDytiWKeY1KlDKVxa4HC+rZrk58nQ9NxJed4/nlFolMKinT9424AxhDeNEzvJcyyDHP
 9u35JjhiEDST3io/q8mNKePsBgoyWZwFE9op/pyQGbR1BSPlFudaofp9vEMwtue/K91Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YWzCc1H6ntxS1SvenEwcTtuD770RxXog9I7WjJJaTdY=; b=Y
 5Lb6swvWlfoAa9sN0Omq63pvCcdPxJ50I5wsL0EeuhL/hQF2iBB8GjBLSbsoddgP2bpwX7bqT8yGG
 dJ4S8JdP2GWid6emRtPl2eD8ps36j8RuUu/f2uN+2wpO9ahRIa5z8jwl+dKW0+uel821JgjBQ17a5
 GJIAkLToUUTzfodI=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jXNYv-000mpY-RV
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 May 2020 11:22:37 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B12B76FC3B2A1C4C2794;
 Sat,  9 May 2020 19:22:14 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 19:22:08 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <hridya@google.com>
Date: Sat, 9 May 2020 19:21:35 +0800
Message-ID: <20200509112135.51960-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
X-Headers-End: 1jXNYv-000mpY-RV
Subject: [f2fs-dev] [PATCH -next] f2fs: Fix wrong stub helper update_sit_info
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
Cc: YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

update_sit_info should be f2fs_update_sit_info,
otherwise build fails while no CONFIG_F2FS_STAT_FS.

Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 747d09264147..b06a14ed218e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3686,7 +3686,7 @@ static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
 static inline void __init f2fs_create_root_stats(void) { }
 static inline void f2fs_destroy_root_stats(void) { }
-static inline void update_sit_info(struct f2fs_sb_info *sbi) {}
+static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
 
 extern const struct file_operations f2fs_dir_operations;
-- 
2.17.1




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
