Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A291CA0EC0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Aug 2024 21:53:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sjn4h-0004CR-SC;
	Thu, 29 Aug 2024 21:53:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1sjn4g-0004CF-M7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Aug 2024 21:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u2yDERBuwFp8nVKBjkDWK81Owor96SC7L8sKWZWfv3Q=; b=ZXLRP6Eq7UVqynrMU0kibIT81K
 4ipHjIwNH5yrX5xxsZk6+YbaBpjBfrA1GiP25BgCL2ScXTT66Vx4QJt7Bsl18/RtxYxbEPNzkYu9e
 4YTV382kZyQlhTHafxI7BwmffuuAj0VzyDvugT+fWN9K7UYFjRapONavEpAWuDjqE5RQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u2yDERBuwFp8nVKBjkDWK81Owor96SC7L8sKWZWfv3Q=; b=BFeYpoPe/bbaQJyU+RCNSyzyLo
 P+Z/mO4cvh3QnhiOZSxDtJDQyYS8Ac7fzlasnSzKWFuLmrQXju94OSOCik3mlT9blj9xfJSJ9hT3f
 lRytk+5Etjel7TnaWG3yzlGmkLCyG5Iw5kbh7PJok1RHha+XRth0jNmmjQm0zCfW+gGQ=;
Received: from mail-il1-f177.google.com ([209.85.166.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sjn4f-0007bU-Tq for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Aug 2024 21:53:02 +0000
Received: by mail-il1-f177.google.com with SMTP id
 e9e14a558f8ab-39d3b31e577so4975185ab.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 Aug 2024 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724968376; x=1725573176; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2yDERBuwFp8nVKBjkDWK81Owor96SC7L8sKWZWfv3Q=;
 b=lbYhe70Se1sFEgRJO1HV4hmOGI2UrlxcDay47t3sjD1jbocly+y1sx4VkSj6+Iskk4
 zdOOpPql527P5yXrIZs9sXUKK8HkA68WnmjBGAeUDHS9a6nupE930vBcXgRa7S/3fjDN
 Cqw2QhMKlZuoG7TaSDba9cecq6HROXSFNrqXO5a2R5fjHGM3iUN6x04KTO/FHf703pMJ
 Ub8iUmCW5oTxgVElg26+/wM6gYS1i+QgltEz6rAPNY21Umz1oX6vK6deW0nbHh8lCuZ5
 P/4Az3WvVEhwif0GQN0MCmDX8V+9oKuqvg5bFB/R8L5uHie66FnfiKE3q4cRHdp2gnS1
 X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724968376; x=1725573176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2yDERBuwFp8nVKBjkDWK81Owor96SC7L8sKWZWfv3Q=;
 b=cEf7SYD97pBnV12DjXRCMHcHt7bfAtvC8ymqstCGozUaWqllmBHgtqLU/CmDsNMEct
 VRww4OACwNoZn2slz2t6xP7iDz+EjWV4OckkYjW3k1U50//wfoQJN74P/02bzN21FkVE
 LxZHIUdZe733UQ4NmfDB3Oxx2+3UNR5YpO2S48Mc+o4T9ENlky4sFeYLdzNJrDZdj2ts
 MEffaLwm0EVMdbDmT4rU1Hmqdfmb936+BTbsUyXSx8APXJnaPqUcaKDhpS7JkNby6MXZ
 2SXAoKUoG/RZYdKNatcMieWpNPO5tEYVqJSgBb7R/bgx/BAgq4nKQdgV+2KgG26Qx8vB
 rD4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/4Z9lO0Nq/fEJuTVi83CBj2xhDyKHn1jbzwuOyuI1UCczy/g3qttW8d2OWbm2+GvSPYz4IHMyvcMTc3YZcmBI@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx9O/oMFvPDLhEYegEZwV2JkbuKJYjVeBjPIWrH5EYNPyfnATxC
 uspwWfHPu61u6bj7kyY5qI70gkjSXk2XIRd8RWo0yeWHoE/nnvcu
X-Google-Smtp-Source: AGHT+IFtyUivTo4A1L+LEOlzGSFxyyn44PCEBcc9Wz4G26Eb8oCHWiMMdRZYIcxxv0rHM+CjSXGQRg==
X-Received: by 2002:a05:6e02:219c:b0:39a:14f7:1c1c with SMTP id
 e9e14a558f8ab-39f37866c50mr54459475ab.25.1724968376015; 
 Thu, 29 Aug 2024 14:52:56 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 14:52:55 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 29 Aug 2024 14:52:40 -0700
Message-ID: <20240829215242.3641502-5-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240829215242.3641502-1-daeho43@gmail.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1sjn4f-0007bU-Tq
Subject: [f2fs-dev] [PATCH 5/7] f2fs: do FG_GC when GC boosting is required
 for zoned devices
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

Under low free section count, we need to use FG_GC instead of BG_GC to
recover free sections.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/gc.c   | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5e4db3ba534a..ee1fafc65e95 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1294,6 +1294,7 @@ struct f2fs_gc_control {
 	bool should_migrate_blocks;	/* should migrate blocks */
 	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
 	unsigned int nr_free_secs;	/* # of free sections to do GC */
+	bool one_time;			/* require one time GC in one migration unit */
 };
 
 /*
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d6d71aab94f3..37b47a8d95f1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -81,6 +81,8 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
+		gc_control.one_time = false;
+
 		/*
 		 * [GC triggering condition]
 		 * 0. GC is not conducted currently.
@@ -126,15 +128,19 @@ static int gc_thread_func(void *data)
 				wait_ms = gc_th->max_sleep_time;
 		}
 
-		if (need_to_boost_gc(sbi))
+		if (need_to_boost_gc(sbi)) {
 			decrease_sleep_time(gc_th, &wait_ms);
-		else
+			if (f2fs_sb_has_blkzoned(sbi))
+				gc_control.one_time = true;
+		} else {
 			increase_sleep_time(gc_th, &wait_ms);
+		}
 do_gc:
 		stat_inc_gc_call_count(sbi, foreground ?
 					FOREGROUND : BACKGROUND);
 
-		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
+		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
+				gc_control.one_time;
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground)
@@ -1701,7 +1707,7 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				unsigned int start_segno,
 				struct gc_inode_list *gc_list, int gc_type,
-				bool force_migrate)
+				bool force_migrate, bool one_time)
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
@@ -1728,7 +1734,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
-		if (gc_type == BG_GC) {
+		if (gc_type == BG_GC || one_time) {
 			unsigned int migration_granularity =
 				sbi->migration_granularity;
 
@@ -1908,7 +1914,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	}
 
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type,
-				gc_control->should_migrate_blocks);
+				gc_control->should_migrate_blocks,
+				gc_control->one_time);
 	if (seg_freed < 0)
 		goto stop;
 
@@ -1919,6 +1926,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		total_sec_freed++;
 	}
 
+	if (gc_control->one_time)
+		goto stop;
+
 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
 
@@ -2044,7 +2054,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		};
 
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
-						dry_run_sections == 0);
+						dry_run_sections == 0, false);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
-- 
2.46.0.469.g59c65b2a67-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
