Return-Path: <SRS0=yNny=5L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AD7C2D0E8
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:44:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE2E2070A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dvzrObY9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="B9kX/mhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE2E2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jHP3l-0000P9-Q1; Thu, 26 Mar 2020 09:44:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jHP3j-0000Or-Kd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 09:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DmdmGMrvkmN/x7pT9DXyecgpYbnTNWqpbN92swg2X6M=; b=dvzrObY90fZokLOVt4mYJE7hJ+
 xJR6yV5DD+MX/eKR2xgWsNQGxOmv4Ahh10TsQolAozsSsbEzj2NLgaBX9+vyyZmuf5ytl0XwBNyNR
 FBuuWfRcig050kc6kV1TnRRAonZvhkj/kCSC0bBD4iA6aybdn0yTuQxzrA59hDt+zpJ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DmdmGMrvkmN/x7pT9DXyecgpYbnTNWqpbN92swg2X6M=; b=B
 9kX/mhS6ovGtJipUfFqHQTS6W6iI7ZNdXgafjw3zMjWvUeJQosaM0w+MKSKkD1Rb4t6kbGX+vdmMr
 8ewJ06pczRoQCjwqGfow9wC6N6rteIgygND1j1P+G4Yd0diSRt1pJLK3z6HcMqRBVw5/7iLE1So16
 XhUhS5SNw+klXagE=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jHP3g-0080wf-Hh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 09:44:19 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C03A666A181C6217AC79;
 Thu, 26 Mar 2020 17:44:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 17:43:58 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Thu, 26 Mar 2020 17:43:56 +0800
Message-ID: <20200326094356.87838-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jHP3g-0080wf-Hh
Subject: [f2fs-dev] [PATCH] f2fs: switch discard_policy.timeout to bool type
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

While checking discard timeout, we use specified type
UMOUNT_DISCARD_TIMEOUT, so just replace doplicy.timeout with
it, and switch doplicy.timeout to bool type.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d3eda362582f..9274399d9505 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -330,8 +330,8 @@ struct discard_policy {
 	bool io_aware;			/* issue discard in idle time */
 	bool sync;			/* submit discard with REQ_SYNC flag */
 	bool ordered;			/* issue discard by lba order */
+	bool timeout;			/* discard timeout for put_super */
 	unsigned int granularity;	/* discard granularity */
-	int timeout;			/* discard timeout for put_super */
 };
 
 struct discard_cmd_control {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 83d778ebea71..86e944700535 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1083,7 +1083,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 
 	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
 	dpolicy->io_aware_gran = MAX_PLIST_NUM;
-	dpolicy->timeout = 0;
+	dpolicy->timeout = false;
 
 	if (discard_type == DPOLICY_BG) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
@@ -1108,6 +1108,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 		dpolicy->io_aware = false;
 		/* we need to issue all to keep CP_TRIMMED_FLAG */
 		dpolicy->granularity = 1;
+		dpolicy->timeout = true;
 	}
 }
 
@@ -1490,8 +1491,8 @@ static bool __should_discard_retry(struct f2fs_sb_info *sbi,
 
 	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(dc, tmp, &(dcc->retry_list), list) {
-		if (dpolicy->timeout != 0 &&
-			f2fs_time_over(sbi, dpolicy->timeout)) {
+		if (dpolicy->timeout &&
+			f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT)) {
 			retry = false;
 			break;
 		}
@@ -1521,13 +1522,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	int i, err, issued = 0;
 	bool io_interrupted = false;
 
-	if (dpolicy->timeout != 0)
-		f2fs_update_time(sbi, dpolicy->timeout);
+	if (dpolicy->timeout)
+		f2fs_update_time(sbi, UMOUNT_DISCARD_TIMEOUT);
 
 retry:
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
-		if (dpolicy->timeout != 0 &&
-				f2fs_time_over(sbi, dpolicy->timeout))
+		if (dpolicy->timeout &&
+				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
 			break;
 
 		if (i + 1 < dpolicy->granularity)
@@ -1548,8 +1549,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
-			if (dpolicy->timeout != 0 &&
-				f2fs_time_over(sbi, dpolicy->timeout))
+			if (dpolicy->timeout &&
+				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
 				break;
 
 			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
@@ -1741,7 +1742,6 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
 					dcc->discard_granularity);
-	dpolicy.timeout = UMOUNT_DISCARD_TIMEOUT;
 	__issue_discard_cmd(sbi, &dpolicy);
 	dropped = __drop_discard_cmd(sbi);
 
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
