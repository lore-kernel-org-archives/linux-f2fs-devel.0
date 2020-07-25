Return-Path: <SRS0=ThHd=BE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDD5C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2020 00:59:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E420520674;
	Sat, 25 Jul 2020 00:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GqAepIlY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GpbPMPbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E420520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jz8Xb-0004G4-BE; Sat, 25 Jul 2020 00:59:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack.qiu@huawei.com>) id 1jz8XY-0004Fk-Vz
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Jul 2020 00:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g9Ec5QUzFwUamZJ8ez0ZEgXG+AsL02BrT+ng9PF3rHs=; b=GqAepIlYZf01p1jRVUZP26mAJm
 3xGfvuXocnXlW+SACiBiBB88VPLz1rdvdKpoO240Zrz8jvlA3qKeMQWh8FIfp79gV9sqmzsJ+fW8p
 PcyXJbJ4zcRsNhEgdG7bo3ZXfcuJDaTu+baguqs5T6HOdNVaCwf1aD01n6PnXUYUwAzc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g9Ec5QUzFwUamZJ8ez0ZEgXG+AsL02BrT+ng9PF3rHs=; b=G
 pbPMPbt8yrjVHMIscylG5R4G67tad9MufxG2g0P75jkA7wqyV7s/kXOwcnhhI7QXgiHF3rASxIPZX
 2IuIZxdSUwx/N2eWVZjp5h2r1tz81ZWn7ZjnH9aSBK1RxkHwp7PUelqrlnokS8kiTkgvPS0kGHva3
 CoA/1KyF6BtZJOKk=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jz8XW-00GSvj-Pf
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Jul 2020 00:59:52 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 159E9F154F4366ED453B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2020 08:59:35 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 08:59:29 +0800
From: Jack Qiu <jack.qiu@huawei.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
Date: Sat, 25 Jul 2020 09:49:52 +0800
Message-ID: <20200725014952.19036-1-jack.qiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
X-Headers-End: 1jz8XW-00GSvj-Pf
Subject: [f2fs-dev] [PATCH] f2fs: use kfree() to free sbi->gc_thread
 allocated by f2fs_kmalloc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use kfree() instead of kvfree() to free sbi->gc_thread allocated
by f2fs_kmalloc(). Because the memory is allocated with kmalloc
inside f2fs_kmalloc().

Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5b95d5a146eb..696ceeedc76d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -147,7 +147,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(gc_th->f2fs_gc_task)) {
 		err = PTR_ERR(gc_th->f2fs_gc_task);
-		kvfree(gc_th);
+		kfree(gc_th);
 		sbi->gc_thread = NULL;
 	}
 out:
@@ -160,7 +160,7 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 	if (!gc_th)
 		return;
 	kthread_stop(gc_th->f2fs_gc_task);
-	kvfree(gc_th);
+	kfree(gc_th);
 	sbi->gc_thread = NULL;
 }

--
2.17.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
