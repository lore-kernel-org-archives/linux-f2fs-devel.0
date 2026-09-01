Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B328C624D4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=maglrNuJEB+Gy80MmQlXZFPidi91LBAlXldYLzHMZfs=; b=hqaJANzODw1IMJGk4puUiRr6bf
	4Al73abj/4n9gXhGabvXOK4Vd3hNZPX/T91x0oOYMTHul/srhmijmNQZQEP+xF+LxEWtRuJ30xWCE
	jxQSz45mUfMym52n0AgbIOoIT7biCnpDZfdL5TT8o2AA9jY0tRAMU3h9qppwSilE/Ucw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1PAt-0008N0-BC;
	Tue, 01 Sep 2026 14:09:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1PAd-0008Mm-NG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k+0LONJ4G1sroaO33U1ZGH+R6K9EfmZf2pk20ljy1Ss=; b=cp0nAm04IrgU923I/8I3lMGV5W
 bEoENyIDxEIKukvwSdiAQiHUOD47soVWxWV5nJna7CD2B0ZshIc67yXBa33nzONoVJWuiHzjv+4h9
 EudqBMN9p5QpF3qZz6VSa0TaPdCLVgvQ8xfxQcgu4G48kzjpZVEq9ATOH5kGEk/KJ2yE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k+0LONJ4G1sroaO33U1ZGH+R6K9EfmZf2pk20ljy1Ss=; b=H
 nMX5y9iNuUTIs/V8YaBid10GmHJB2TBomkDlCIulXRMYl+w5L0LHcGViB7szktEAAZxqSO5utJWG/
 NKLz4zGHKoq7JvpzZJ+azhdjIohU8kXk7TcVdpMLK+9awEc0bb/A5i0a+tgija3YXqUX4el5BLtgM
 1LErKFXPZhpcdWxg=;
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1PAc-000225-BU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:09:03 +0000
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-853c401326eso2786816b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788271737; x=1788876537; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k+0LONJ4G1sroaO33U1ZGH+R6K9EfmZf2pk20ljy1Ss=;
 b=LJBYfIusI0u99pPP/UNc8OZkFMTT7MVSOzFKQ2nkf3hp4jnf0Y7xiDI9GoRliE7rh9
 20RdSQd2jag2FaqSekkvwLjE85G6pVedF4gh7gH+xo4XdtRtXRR055V3NvKx2MzH/jHZ
 6IGJDnZehpdvN4wFAvHm0fiqKyDpvY2lEGDbr+qKngo8W0vOV7MnyBD1ELmWxwudaDzW
 X2zhzpjPvYX74bGWhhSjfOyI4jQFFzr9voW2NEjwtNXvLzUogkoGGRdMg5VpeE+QRys6
 XKf10HQxWluTkCYNleW9BiyrL4UfnT3QGLq9UyO5ZwWq4TwQDD35mxktXt7+8jmnt7s5
 yuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788271737; x=1788876537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k+0LONJ4G1sroaO33U1ZGH+R6K9EfmZf2pk20ljy1Ss=;
 b=avimw0jtn9jONUrfhIZ1ost7nHFlaCskapHPK+Q5ASEVdJg5Va8im09JYSy9wRNiOm
 nuJu4r0UEz3T+8VwyJp8lx2L2NLh6R8vE13vzvlmo+F+VDHmD+Uhb4vzZBcRiUtGgzUP
 3q0m0gotkArmJfBVyt3869Qa4wVavFabq1V4QQUc+0Imo5i8lRKDWkPryUL3yxjH2xEB
 AoH9LpbNik+C6NRtX2Ab0WLj5dp/QxH7O3RE45dQWoZYhu86eFs7OVc6CHDqdyc7UGdf
 HDc/shkb2XMZPrPLIc978mAeLG15r5igO8rmqeO3Rh9uTtger++fYFCqNqsQD898pfQX
 4L9g==
X-Gm-Message-State: AFuF++nAeNykDj8Bky2U5Lciz0okgEQ55pKYJGBf+jmiGP09OzzeSKPW
 lsLJv/0fbuLQTFcjXYkatYPTVzTwZzBoDAgvnT5PKZgn+3YypP9gRmYhmvdFbJpr
X-Gm-Gg: AR+sD13/jgRflzxG3ZyqQpxrg980tyaQ4X9Pvq51QOx3b7Y5vMU+H71TkudSWlxCrB/
 9ZJPUuPr3BQZRSGOry/ABuCMxFZPKPi9LNP9rO3G39+Fnqjy3iIhfz4Ql3Fux4AyfvwVCE9uvlk
 kpyrwT0lPAx0L+mTP5N8IeAV8/6Xrp0ogPcIXUlZZ6apTOgmeq824+kqXZwGDBT7r15fySLiqmQ
 D3VEXfPUIvYHeaZGpQuBqeOjxGwgFTTJmeTMv9cZziEMClqM6bhYTkgiWiBUhB8LmPe1I1Cdg2Q
 MFenmVVkqaKoxQE4LEYHkkJ5rlrsdRSlBcGFtVt5518RJr0YucXjUtnqhHj0O6R336x/qpeFE9Y
 jsiXmSPbEz3OsxQCvsaXoHBhAcU+QBlOO2KaSNaJfav3xDJn7+9bE8mhBuCAVxi0nNBZoAnRL5h
 nLH0GY++coBASXMTHN2a40ampK+JSTbYj7CoP4iJCDF9cZF6/iPcSQmdnuAP16EZ3bxAEfzhM3a
 w/RnMrA0fVOOo449s51osaV
X-Received: by 2002:a05:6a20:2d2c:b0:3d1:39e9:b261 with SMTP id
 adf61e73a8af0-3d7aacd026bmr13822515637.0.1788271736523; 
 Tue, 01 Sep 2026 07:08:56 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1f36ac729sm6364551a12.17.2026.09.01.07.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:08:55 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  1 Sep 2026 22:08:49 +0800
Message-ID: <20260901140849.3405971-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x1PAc-000225-BU
Subject: [f2fs-dev] [PATCH v2] f2fs: wait for inode record work before
 clearing ino bitmaps
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

APPEND/UPDATE inode state recording was moved to the inode eviction
workqueue. These entries were later converted to bitmap values stored in
XArrays, but the workqueue drain was left behind in the list cleanup loop
where it is now a no-op.

During unmount, inode eviction work can therefore remain queued when
f2fs_release_ino_entry() destroys the bitmap XArrays. A delayed worker can
repopulate them before the workqueue is finally destroyed, leaking newly
allocated XArray nodes when the F2FS superblock is freed.

Wait for APPEND/UPDATE inode record work before destroying each bitmap
XArray, restoring the required ordering.

Fixes: 9a9ee7408a1f ("f2fs: reduce memory footprint of ino management")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v2:
- Remove the no-op wait from the ORPHAN/FLUSH cleanup loop.
- Wait once before bitmap XArray cleanup since APPEND/UPDATE share evict_wq.

 fs/f2fs/checkpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4b59f30ef45d5..642a771e0f63c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -887,8 +887,6 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 	for (i = all ? ORPHAN_INO : FLUSH_INO; i <= FLUSH_INO; i++) {
 		struct inode_management *im = &sbi->im[i];
 
-		f2fs_wait_for_inode_record(sbi, i);
-
 		spin_lock(&im->ino_lock);
 		list_for_each_entry_safe(e, tmp, &im->ino_list, list) {
 			list_del(&e->list);
@@ -899,6 +897,8 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 		spin_unlock(&im->ino_lock);
 	}
 
+	f2fs_wait_for_inode_record(sbi, APPEND_INO);
+
 	for (i = APPEND_INO; i < MAX_INO_ENTRY; i++) {
 		struct inode_management *im = &sbi->im[i];
 
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
