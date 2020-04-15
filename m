Return-Path: <SRS0=cknU=57=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C0EC2BB55
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:43:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B9D206A2;
	Wed, 15 Apr 2020 11:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Qd2KmIkA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="iqmDBqUm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0lA0kIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B9D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jOgRq-0003VX-0F; Wed, 15 Apr 2020 11:43:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1jOgRp-0003VR-HR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Apr 2020 11:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KFwP3scTAKF78Lco/+z0m3Drf/7qS5OgwMW4nAqVEeE=; b=Qd2KmIkABkCMa5FK0RneGQTiyQ
 wCrp8JmlqtET+1RWbMogSMmQTn7cvH2rvJq3qobt0rRLqzGRN+MTZ7QF7xXqouHcZ6FyZGrMMMWP4
 shXd0+7B+4vbRdZe1YidAuFYGmQeUgJmrnYoOZ2ktJprqjuF/6Dmjycr1a35uqwBdzpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KFwP3scTAKF78Lco/+z0m3Drf/7qS5OgwMW4nAqVEeE=; b=iqmDBqUmW7PJh6v+t8O0Z2dcEC
 3ryX8YWVNOzdGlnUyecQCU2pPfWusr9Q6NLcUpwdzOSiTBMssBn4eVxlZMOopUjiyTN4f4N/22Fu4
 B5CWfzkjgX/B6AJSPjpju9JYF0Ce2v/2JMHOldWbFvIvAAi4UjRTRdB1H4z4NpHNPDM4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jOgRn-002Yc9-Ra
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Apr 2020 11:43:17 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9916F20936;
 Wed, 15 Apr 2020 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586950989;
 bh=hTRxnYZ1co6Pn1/bWbg7KuCbkL9xS1F43IkbvJiqbr8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o0lA0kIPPz7CW97jnwF097bOd5rsyywi/F4nCqOnEKr9eYQqLpwC9Qw0XjJGSzEHs
 kcPrtZ4/kmG9GSQTd3PduBX/tDj/97Ex0pg2RNu1Kkgprh5XlYmQQQWU4urb4ceJrU
 csICgW4R0jwex1ARmoeWgfkwKR1IoolhMy7BJqH8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed, 15 Apr 2020 07:41:16 -0400
Message-Id: <20200415114226.13103-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1jOgRn-002Yc9-Ra
Subject: [f2fs-dev] [PATCH AUTOSEL 5.5 036/106] f2fs: fix to update
 f2fs_super_block fields under sb_lock
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit a4ba5dfc5c88e49bb03385abfdd28c5a0acfbb54 ]

Fields in struct f2fs_super_block should be updated under coverage
of sb_lock, fix to adjust update_sb_metadata() for that rule.

Fixes: 04f0b2eaa3b3 ("f2fs: ioctl for removing a range from F2FS")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b3d3996232901..d6705ded0141a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1432,12 +1432,19 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
 static void update_sb_metadata(struct f2fs_sb_info *sbi, int secs)
 {
 	struct f2fs_super_block *raw_sb = F2FS_RAW_SUPER(sbi);
-	int section_count = le32_to_cpu(raw_sb->section_count);
-	int segment_count = le32_to_cpu(raw_sb->segment_count);
-	int segment_count_main = le32_to_cpu(raw_sb->segment_count_main);
-	long long block_count = le64_to_cpu(raw_sb->block_count);
+	int section_count;
+	int segment_count;
+	int segment_count_main;
+	long long block_count;
 	int segs = secs * sbi->segs_per_sec;
 
+	down_write(&sbi->sb_lock);
+
+	section_count = le32_to_cpu(raw_sb->section_count);
+	segment_count = le32_to_cpu(raw_sb->segment_count);
+	segment_count_main = le32_to_cpu(raw_sb->segment_count_main);
+	block_count = le64_to_cpu(raw_sb->block_count);
+
 	raw_sb->section_count = cpu_to_le32(section_count + secs);
 	raw_sb->segment_count = cpu_to_le32(segment_count + segs);
 	raw_sb->segment_count_main = cpu_to_le32(segment_count_main + segs);
@@ -1451,6 +1458,8 @@ static void update_sb_metadata(struct f2fs_sb_info *sbi, int secs)
 		raw_sb->devs[last_dev].total_segments =
 						cpu_to_le32(dev_segs + segs);
 	}
+
+	up_write(&sbi->sb_lock);
 }
 
 static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
