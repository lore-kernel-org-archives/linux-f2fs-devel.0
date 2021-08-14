Return-Path: <SRS0=w4/v=NF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99BC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Aug 2021 17:59:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BA760EB4
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Aug 2021 17:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2BA760EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mExvw-0001YX-47; Sat, 14 Aug 2021 17:59:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <frank.li@vivo.com>) id 1mExvt-0001YA-4b
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Aug 2021 17:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ab79RtEGmh6/60BcNJNb+Y7z+eBEGTQ6jL64mpP43iw=; b=iXIDFfpcEJp6R69MGdUawpzaMK
 aA9fGU2eQAX3SLwA6JMYHTUgXpm8GHYeBykTjXIRMmHDJhvPdvdKezC5zlI2mcplb6iTAlKUZQ3Dj
 e4O8li3vhXGy3RKKA6vKvzZ6vnRrjlrPnALfY9ByHspJ85gtYQer3HBhG9P6xyEwcxls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ab79RtEGmh6/60BcNJNb+Y7z+eBEGTQ6jL64mpP43iw=; b=M
 hOx/rpe26KfitPVHa1eXqH0WsV/Px1Ch4DN8op2d3Uou82DWvOjMSg1JeI8YhDPKlTSPEQmWUzN1S
 Aan3nC46sP6jgdF0RqHh6IFKP3sP130DlIzzbkg0W+0QR359m3yI3JmDZ48AZolY2kArYnxjsohqs
 8mlcMSfEcC90eAnA=;
Received: from mail-m17636.qiye.163.com ([59.111.176.36])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mExvm-006TwH-CX
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Aug 2021 17:58:57 +0000
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
 by mail-m17636.qiye.163.com (Hmail) with ESMTPA id A7591C400B0;
 Sun, 15 Aug 2021 01:58:42 +0800 (CST)
From: Yangtao Li <frank.li@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 15 Aug 2021 01:58:39 +0800
Message-Id: <20210814175840.115938-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlKGBlWTklCQxkdHUIYSk
 JCVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46HBw4LT9ITB8QKzYZDw4R
 FS4aFClVSlVKTUlDQk1IQklISUlMVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
 VUpLT1VKQ0NVSk1OWVdZCAFZQU9CTk43Bg++
X-HM-Tid: 0a7b45d0e38fd996kuwsa7591c400b0
X-Headers-End: 1mExvm-006TwH-CX
Subject: [f2fs-dev] [PATCH 1/2] f2fs: add sysfs nodes to get discard
 information
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
Cc: Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I've added new sysfs nodes to show discard stat since mount, which
will help us analyze whether the performance problem is related to
discard.

issued_discard  - Shows the number of issued discard
queued_discard  - Shows the number of cached discard cmd count
discard_cmd_cnt - Shows the number of cached discard cmd count
undiscard_blks  - Shows the number of undiscard blocks

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 20 +++++++++++
 fs/f2fs/sysfs.c                         | 44 +++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index ef4b9218ae1e..32df6d16d74f 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -493,3 +493,23 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	When ATGC is on, it controls age threshold to bypass GCing young
 		candidates whose age is not beyond the threshold, by default it was
 		initialized as 604800 seconds (equals to 7 days).
+
+What:		/sys/fs/f2fs/<disk>/issued_discard
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Shows the number of issued discard.
+
+What:		/sys/fs/f2fs/<disk>/queued_discard
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Shows the number of queued discard.
+
+What:		/sys/fs/f2fs/<disk>/discard_cmd_cnt
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Shows the number of cached discard cmd count.
+
+What:		/sys/fs/f2fs/<disk>/undiscard_blks
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Shows the number of undiscard blocks.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6642246206bd..b7d6c1adc7f8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -248,6 +248,42 @@ static ssize_t main_blkaddr_show(struct f2fs_attr *a,
 			(unsigned long long)MAIN_BLKADDR(sbi));
 }
 
+static ssize_t issued_discard_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)atomic_read(&dcc_info->issued_discard));
+}
+
+static ssize_t queued_discard_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)atomic_read(&dcc_info->queued_discard));
+}
+
+static ssize_t discard_cmd_cnt_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)atomic_read(&dcc_info->discard_cmd_cnt));
+}
+
+static ssize_t undiscard_blks_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)dcc_info->undiscard_blks);
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
@@ -690,6 +726,10 @@ F2FS_GENERAL_RO_ATTR(unusable);
 F2FS_GENERAL_RO_ATTR(encoding);
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
+F2FS_GENERAL_RO_ATTR(issued_discard);
+F2FS_GENERAL_RO_ATTR(queued_discard);
+F2FS_GENERAL_RO_ATTR(discard_cmd_cnt);
+F2FS_GENERAL_RO_ATTR(undiscard_blks);
 #ifdef CONFIG_F2FS_STAT_FS
 F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
 F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
@@ -750,6 +790,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
 	ATTR_LIST(main_blkaddr),
+	ATTR_LIST(issued_discard),
+	ATTR_LIST(queued_discard),
+	ATTR_LIST(discard_cmd_cnt),
+	ATTR_LIST(undiscard_blks),
 	ATTR_LIST(max_small_discards),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(batched_trim_sections),
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
