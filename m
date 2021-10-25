Return-Path: <SRS0=GSv8=PN=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A130C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Oct 2021 12:19:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F17E60C49
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Oct 2021 12:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F17E60C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1meywa-0004Sd-3T; Mon, 25 Oct 2021 12:19:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangxiaojun11@huawei.com>) id 1meywY-0004SI-Ga
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Oct 2021 12:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J85dIzHW4ewa5JfLrY9a9bu08Z/19YmsGSqJ4PdDX/Q=; b=U9psS7vgkd2LithC5A5UuZu4xX
 0FWf2l+KUvh1u7xElQWdmzvB4Oi5dnzV066jLfHi967bGvMkUDBsxIX713oieuS6aFHmwLN+3HfbM
 Umzs762lKAPxHsy7jhSJ+DN9zfq4pfS8ml2OiBrU1ZeWDPTFyIdJWR/Wg0eE2B9Odyu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=J85dIzHW4ewa5JfLrY9a9bu08Z/19YmsGSqJ4PdDX/Q=; b=a
 ZqrwAUXE8fT8Y/4qH6Z0aU0F5/B9SWC7WRiHaEP+AuGw1xhtW6Y/mfw+jnOcUx9f3Wn+3KnyRZem4
 BppZsC4+ZpB7cAkqeSi5TPsEbmso213kZk5V4VOsG2763+sGahqUc2JccmQFKQLTSulsmbTldS/RG
 ilgfF0/U+Vo6JvpU=;
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1meywW-0004kb-Vb
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Oct 2021 12:19:10 +0000
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HdD7K40NYz1DHtQ;
 Mon, 25 Oct 2021 20:01:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeml756-chm.china.huawei.com
 (10.1.199.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Mon, 25
 Oct 2021 20:02:54 +0800
From: Wang Xiaojun <wangxiaojun11@huawei.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
Date: Mon, 25 Oct 2021 20:09:31 +0800
Message-ID: <20211025120931.1409835-1-wangxiaojun11@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml756-chm.china.huawei.com (10.1.199.158)
X-CFilter-Loop: Reflected
X-Headers-End: 1meywW-0004kb-Vb
Subject: [f2fs-dev] [PATCH] f2fs-tools: fix the wrong sbi->cur_cp setting
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If sbi->cur_cp is 2 and the duplicate_checkpoint function returns
in advance because sbi->cp_backuped is set to true, we cannot set
sbi->cur_cp to 1.

Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
---
 fsck/fsck.c  | 3 ---
 fsck/mount.c | 5 ++---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 110c1ec..aa77a34 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2383,9 +2383,6 @@ static void fix_checkpoints(struct f2fs_sb_info *sbi)
 {
 	/* copy valid checkpoint to its mirror position */
 	duplicate_checkpoint(sbi);
-
-	/* repair checkpoint at CP #0 position */
-	sbi->cur_cp = 1;
 	fix_checkpoint(sbi);
 }
 
diff --git a/fsck/mount.c b/fsck/mount.c
index c928a15..295170e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2998,6 +2998,8 @@ void duplicate_checkpoint(struct f2fs_sb_info *sbi)
 	ASSERT(ret >= 0);
 
 	sbi->cp_backuped = 1;
+	/* repair checkpoint at CP #0 position */
+	sbi->cur_cp = 1;
 
 	MSG(0, "Info: Duplicate valid checkpoint to mirror position "
 		"%llu -> %llu\n", src, dst);
@@ -3098,9 +3100,6 @@ void write_checkpoints(struct f2fs_sb_info *sbi)
 {
 	/* copy valid checkpoint to its mirror position */
 	duplicate_checkpoint(sbi);
-
-	/* repair checkpoint at CP #0 position */
-	sbi->cur_cp = 1;
 	write_checkpoint(sbi);
 }
 
-- 
2.31.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
