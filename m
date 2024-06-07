Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB51FC27C53
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Jun 2024 09:01:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sFVTa-0005xg-1s;
	Fri, 07 Jun 2024 09:01:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1sFVTR-0005wE-OM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Jun 2024 09:01:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E0WoHtq2JtQwc4Qrul4y5A2HcvoTVKuDknap1UB384M=; b=UCVGgsROcabK5WuPI64vPGUvXR
 njlmqrwE7DJiGL9+9GG6L0sIiI7NrAQ37gnK2i9v8sFvYqjnzckAigXozzuIuWMgiq5OQiB/EUtR/
 CEHJKFZZMj7aSW21pnXG4dii0e0GGPkTX2G2ZTdfIBhugnYUPE0brbieS7ygidK3Lxtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E0WoHtq2JtQwc4Qrul4y5A2HcvoTVKuDknap1UB384M=; b=Z
 oayI9RhU2XZ1uWIPrUAhT364oniRUzVzauWeBA0sMlNMkXAwJl6vdBDgGnvIBrlil/uV9ixYccA5n
 6GoApYqST9IUzoA0/QKrrdtOmIRH4rU44IvvlprcSJ3HzIHG8eyzczR2AaixbAW6gXe/Imo74b8uO
 RSxAnJbxxbsEDdAs=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sFVTR-00016n-RR for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Jun 2024 09:01:26 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 45790osD077378;
 Fri, 7 Jun 2024 17:00:50 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VwZnV1WLkz2QcKjm;
 Fri,  7 Jun 2024 16:56:46 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 7 Jun 2024 17:00:48 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Fri, 7 Jun 2024 17:00:30 +0800
Message-ID: <1717750830-15423-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 45790osD077378
X-Headers-End: 1sFVTR-00016n-RR
Subject: [f2fs-dev] [PATCH V2] f2fs: enable atgc dynamically if conditions
 are met
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, zhiguo.niu@unisoc.com,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now atgc can only be enabled when umounted->mounted device
even related conditions have reached. If the device has not
be umounted->mounted for a long time, atgc can not work.

So enable atgc dynamically when atgc_age_threshold is less than
elapsed_time and ATGC mount option is on.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v2: try to enabe atgc in cp to avoid some race cases
---
---
 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/segment.c    | 27 ++++++++++++++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 55d444be..7cfe4e0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1718,6 +1718,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	}
 
 	f2fs_restore_inmem_curseg(sbi);
+	f2fs_reinit_atgc_curseg(sbi);
 	stat_inc_cp_count(sbi);
 stop:
 	unblock_operations(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9688df3..8d385a1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3693,6 +3693,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
 bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
+int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
 int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6e8a4b3..362cfb5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2931,12 +2931,12 @@ static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
 	return ret;
 }
 
-static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
+static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi, bool force)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
 	int ret = 0;
 
-	if (!sbi->am.atgc_enabled)
+	if (!sbi->am.atgc_enabled && !force)
 		return 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
@@ -2953,9 +2953,30 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
 	return ret;
 }
+
 int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
 {
-	return __f2fs_init_atgc_curseg(sbi);
+	return __f2fs_init_atgc_curseg(sbi, false);
+}
+
+int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi)
+{
+	int ret;
+
+	if (!test_opt(sbi, ATGC))
+		return 0;
+	if (sbi->am.atgc_enabled)
+		return 0;
+	if (le64_to_cpu(F2FS_CKPT(sbi)->elapsed_time) <
+			sbi->am.age_threshold)
+		return 0;
+
+	ret = __f2fs_init_atgc_curseg(sbi, true);
+	if (!ret) {
+		sbi->am.atgc_enabled = true;
+		f2fs_info(sbi, "reenabled age threshold GC");
+	}
+	return ret;
 }
 
 static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
-- 
1.9.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
