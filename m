Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE27C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jun 2022 18:33:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nzjRX-0004VZ-Uv; Fri, 10 Jun 2022 18:33:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <daeho43@gmail.com>) id 1nzjRX-0004VS-K6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jun 2022 18:33:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wBbbnyxAp776PF/MoHr2OTyzExEVGSOzu1ia9Yc3H1I=; b=ZdYGpEI/I8/PCFpR5ucWdRNCCr
 0FzEgov5TSDNI3HKt9Rxz11nhbO7soy9CxlFHJbWAvjwhOVbSKxH9sUqT4PAJDlCW1Ve6l1PPcdkn
 iKjin43uvHRsusgA6Jkv7bGOqJyyFO5s3ERTOOhDn2Jupiguh7bDy4BvI+yiaCOKK2qQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wBbbnyxAp776PF/MoHr2OTyzExEVGSOzu1ia9Yc3H1I=; b=G
 jm/qGPb0gatnL1sz4t5CwJkjhc79UbMLF5ZJS9SYreXbEgCnbfJ4sIbRSwvDzAbFNKWzzsGruzuu2
 z3RPQKlSkQnUUGCyEfJskFZNQJKI2SwwxViS5fE/u802QlUb0jyx45qBAYuiVOhgMVBDYYM90YAZT
 tlOjjuRE3B7ihQvA=;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nzjRI-00058P-1h
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jun 2022 18:33:11 +0000
Received: by mail-pl1-f174.google.com with SMTP id d13so7775671plh.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Jun 2022 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wBbbnyxAp776PF/MoHr2OTyzExEVGSOzu1ia9Yc3H1I=;
 b=Q5B2LvQMun4KV1/iBHtpnFzF8ZF0cRO+ulZr7uc4CBP6lDhcOHhHZpvnirmdt8SUYQ
 B/n612LXFpiD5oBtzSVEmggJzllxcE4RLtC1+R5BBsOJIimuG+euZamHED1O37WzcUwM
 QxYw2NwMHWuQ6NGVB/Vmnn7xP2uKMLJ1zOLcK/zUBVzUrtcglzny7vBmKS3ainZ1DNNF
 lixEshxk6vsx6SO8N/2aNvpkRbaLmD0GbpJa8Cnd7nnrIOxA2y2tbL9N1p5IGH3YRKPg
 Y3QmytvOStuLhIHv3NT4Cxgc9wFNnIB5XxZv/VRUq5SxbSGeSXpI4eWyjqGvkx17Do6g
 VFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wBbbnyxAp776PF/MoHr2OTyzExEVGSOzu1ia9Yc3H1I=;
 b=rwp0k9pP79TQ7KgoMTYQumWobrFqYWvR85Xqcf7jM4zxq2KW6yK9wv4Tohq1Z8APj4
 vcj1Kwh28IDme4po4sJaG16qI0ZEvycCDEfADHNEvYU8TYEU2yX0feIoWx4sJbHP3lTv
 him6HCRHLIpzMStLf0Pb7Bti1N55MSNkOiRBRsqxJfK9f4QPQVYgrFB0FQJyqrB6zFtu
 q85+Tlp7NfVJnaGmbPel6MrT+vAfYpoPAbAwE9OLB2wVweCKb2QAhDMd1muhKYYyvWds
 N+LMgamuWYMOv7QipDkFklOrV5ebUtJvctJi8+XY4jKrfpEURzzfR7kTb0hHAf6AX0ql
 7oYw==
X-Gm-Message-State: AOAM530gceV7Y3IA6LJTN9JUM1zz2Hq5r3vEXt4qq/rrN+ErVXHFgLCY
 5SxIRChyM4UGMzJY9RWkLgb3/2CzqnI=
X-Google-Smtp-Source: ABdhPJwSAuNuM9jqLVqZXSAsYNlqY0zT0OmxOY2NN+1B/MwSfK6lo2bq+uZCH+VLXZNb6OzPO/5XIA==
X-Received: by 2002:a17:90a:7841:b0:1ea:3f61:7673 with SMTP id
 y1-20020a17090a784100b001ea3f617673mr1041199pjl.110.1654885970124; 
 Fri, 10 Jun 2022 11:32:50 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:9407:3889:1417:db63])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a1709026f0f00b001677d4a9654sm23086plk.265.2022.06.10.11.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jun 2022 11:32:49 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 10 Jun 2022 11:32:40 -0700
Message-Id: <20220610183240.2269085-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
X-Headers-End: 1nzjRI-00058P-1h
Subject: [f2fs-dev] [PATCH] f2fs: fix iostat related lock protection
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Made iostat related locks safe to be called from irq context again.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/iostat.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index be599f31d3c4..d84c5f6cc09d 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -91,8 +91,9 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
 	unsigned int cnt;
 	struct f2fs_iostat_latency iostat_lat[MAX_IO_TYPE][NR_PAGE_TYPE];
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
+	unsigned long flags;
 
-	spin_lock_bh(&sbi->iostat_lat_lock);
+	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
 	for (idx = 0; idx < MAX_IO_TYPE; idx++) {
 		for (io = 0; io < NR_PAGE_TYPE; io++) {
 			cnt = io_lat->bio_cnt[idx][io];
@@ -106,7 +107,7 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
 			io_lat->bio_cnt[idx][io] = 0;
 		}
 	}
-	spin_unlock_bh(&sbi->iostat_lat_lock);
+	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 
 	trace_f2fs_iostat_latency(sbi, iostat_lat);
 }
@@ -115,14 +116,15 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
 {
 	unsigned long long iostat_diff[NR_IO_TYPE];
 	int i;
+	unsigned long flags;
 
 	if (time_is_after_jiffies(sbi->iostat_next_period))
 		return;
 
 	/* Need double check under the lock */
-	spin_lock_bh(&sbi->iostat_lock);
+	spin_lock_irqsave(&sbi->iostat_lock, flags);
 	if (time_is_after_jiffies(sbi->iostat_next_period)) {
-		spin_unlock_bh(&sbi->iostat_lock);
+		spin_unlock_irqrestore(&sbi->iostat_lock, flags);
 		return;
 	}
 	sbi->iostat_next_period = jiffies +
@@ -133,7 +135,7 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
 				sbi->prev_rw_iostat[i];
 		sbi->prev_rw_iostat[i] = sbi->rw_iostat[i];
 	}
-	spin_unlock_bh(&sbi->iostat_lock);
+	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
 
 	trace_f2fs_iostat(sbi, iostat_diff);
 
@@ -145,25 +147,27 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
 	int i;
 
-	spin_lock_bh(&sbi->iostat_lock);
+	spin_lock_irq(&sbi->iostat_lock);
 	for (i = 0; i < NR_IO_TYPE; i++) {
 		sbi->rw_iostat[i] = 0;
 		sbi->prev_rw_iostat[i] = 0;
 	}
-	spin_unlock_bh(&sbi->iostat_lock);
+	spin_unlock_irq(&sbi->iostat_lock);
 
-	spin_lock_bh(&sbi->iostat_lat_lock);
+	spin_lock_irq(&sbi->iostat_lat_lock);
 	memset(io_lat, 0, sizeof(struct iostat_lat_info));
-	spin_unlock_bh(&sbi->iostat_lat_lock);
+	spin_unlock_irq(&sbi->iostat_lat_lock);
 }
 
 void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 			enum iostat_type type, unsigned long long io_bytes)
 {
+	unsigned long flags;
+
 	if (!sbi->iostat_enable)
 		return;
 
-	spin_lock_bh(&sbi->iostat_lock);
+	spin_lock_irqsave(&sbi->iostat_lock, flags);
 	sbi->rw_iostat[type] += io_bytes;
 
 	if (type == APP_BUFFERED_IO || type == APP_DIRECT_IO)
@@ -172,7 +176,7 @@ void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	if (type == APP_BUFFERED_READ_IO || type == APP_DIRECT_READ_IO)
 		sbi->rw_iostat[APP_READ_IO] += io_bytes;
 
-	spin_unlock_bh(&sbi->iostat_lock);
+	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
 
 	f2fs_record_iostat(sbi);
 }
@@ -185,6 +189,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
 	int idx;
+	unsigned long flags;
 
 	if (!sbi->iostat_enable)
 		return;
@@ -202,12 +207,12 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 			idx = WRITE_ASYNC_IO;
 	}
 
-	spin_lock_bh(&sbi->iostat_lat_lock);
+	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
 	io_lat->sum_lat[idx][iotype] += ts_diff;
 	io_lat->bio_cnt[idx][iotype]++;
 	if (ts_diff > io_lat->peak_lat[idx][iotype])
 		io_lat->peak_lat[idx][iotype] = ts_diff;
-	spin_unlock_bh(&sbi->iostat_lat_lock);
+	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 }
 
 void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
-- 
2.36.1.476.g0c4daa206d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
