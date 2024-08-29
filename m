Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF221CA0EC0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Aug 2024 21:53:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sjn4l-0004DF-F2;
	Thu, 29 Aug 2024 21:53:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1sjn4k-0004Cx-5K
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Aug 2024 21:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5di2cQVabKUZYkrdLXdRKWcnXs84Me/LJIQm48KHUJY=; b=hmJfI79t2Wk66herthwM8RzbLu
 UOW37ZbBzfVvWb1Xi+ljiz9BGwu5/UmgL3xEeLRzjG+eb+q080Xppm03ZNxnflBcyRtFnVv85vO4N
 9FYybtF8o6aX1t5LFI4SJZAiwAWI6uc6tfcpjAT6ztgSjL6WWEYPMyxjeQpOvwygVtXs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5di2cQVabKUZYkrdLXdRKWcnXs84Me/LJIQm48KHUJY=; b=gIUYNK2U3PcdPbnM9S4VovB5Pw
 ll6tNBe09ry1hnebDz5ROlLVKBU4Ang/QmML6Ajwa0CmL7/bVeRbGK+7NFGL8PO5vjEJMsQyzf0Jv
 IA1OfqmkHo9xsr6SBfJbCWbQ+RzOB+kmz14yZcNPY0p4ZZdzL3uiE7BVnoq8deWsJvbw=;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sjn4j-0007bc-Gb for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Aug 2024 21:53:06 +0000
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7143165f23fso943157b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 Aug 2024 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724968375; x=1725573175; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5di2cQVabKUZYkrdLXdRKWcnXs84Me/LJIQm48KHUJY=;
 b=Kib4roJEllWlKI8fhVcbM5PmsyUYaEIL2oCnEfySe7Le2X7QIezwOjDwGltpmZItql
 pQkXarFJ01lvHJ3nuxf8hQ+lDVcnG5R6pTgLMRrN02M1rMYnQotLf5xQIEVvOTr6x0pD
 PN0pTWx+ykIN5J+nomzBO1hS2UJiAADZGH97g6JjP1ttdtxnuwy+Nc+ubGEWfWs1l95p
 pt6gEcCr2nQjhqiYMrp1Y3B5OjDFzSXGOpX9oUWgeBqp1CVXR3WGVZlKomOrhF0NExPy
 fcYAf3IHgxkSGzmQw3arnVOGKg3Ma+t7mNiKj487XEfhFjgq75lxRM5kCbGy+BKTZqL5
 COqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724968375; x=1725573175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5di2cQVabKUZYkrdLXdRKWcnXs84Me/LJIQm48KHUJY=;
 b=nf3P17yYYrF7Q8PQYpgA0p1LlpcMSVxyfcdgiIOcWpwdK9euKHLN15niJkItCx5PT9
 BPveEtqSBaOqW3rjtlrPGLf+ylOHidIQe7xRYPj7Zrop8V39bCfuOF59kiNTPV6UJzOs
 k1hIaR8LXUbsiHBC6xlJ6WYRDrxULl1ffp1o0iAqZk29ky0m6fweL+LB1I5YA6mBJQoi
 n7ZjBuPXf61SR2/5dFkhDE2/Nqf//Uu5IGpBkX4y4mEhboPLfW7NcBHjB3SlDY3+EKYQ
 2f8fZWuVOFHVQAdZIBJoLDb++oEdp/hyoteL0HaHuc+9V4I5NSvfBVuALc/zs5myuK1J
 j/uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURaeXm+gox2WqrXWrIYM76hXIwlX+hryhs/dGBn6daL8j7sknxtrLKmEjsBsCJphoriLRTr6yLfsry/kNpr0hV@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzHmmXG0aYtD4IBWItuCi1/v3f3kAkUyN4ZnHLZrwJvRJqhx2yW
 9V8hQ2o2XDHXmV1hfZDU/u+8SA38SncEQqOn13kYAFUTohn0w1T2
X-Google-Smtp-Source: AGHT+IGxnhE16JGql/YBxmn1MFalr9m8fkVidqAE2UlxFSw6h7S0cI4sb4YdnE5ovusiqZW5QWtknQ==
X-Received: by 2002:a05:6a21:4a4a:b0:1c4:f366:381b with SMTP id
 adf61e73a8af0-1cce10b09a6mr3425760637.33.1724968374536; 
 Thu, 29 Aug 2024 14:52:54 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 14:52:54 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 29 Aug 2024 14:52:39 -0700
Message-ID: <20240829215242.3641502-4-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240829215242.3641502-1-daeho43@gmail.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1sjn4j-0007bc-Gb
Subject: [f2fs-dev] [PATCH 4/7] f2fs: increase BG GC migration granularity
 when boosted for zoned devices
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

Need bigger BG GC migration granularity when free section is running
low.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c | 13 +++++++++++--
 fs/f2fs/gc.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b5d3fd40b17a..d6d71aab94f3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1728,8 +1728,17 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
-		if (gc_type == BG_GC)
-			end_segno = start_segno + sbi->migration_granularity;
+		if (gc_type == BG_GC) {
+			unsigned int migration_granularity =
+				sbi->migration_granularity;
+
+			if (f2fs_sb_has_blkzoned(sbi) &&
+					!has_enough_free_blocks(sbi,
+					LIMIT_BOOST_ZONED_GC))
+				migration_granularity *= BOOST_GC_MULTIPLE;
+
+			end_segno = start_segno + migration_granularity;
+		}
 
 		if (end_segno > sec_end_segno)
 			end_segno = sec_end_segno;
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 14ae85f33235..33848d550153 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -33,6 +33,7 @@
 #define LIMIT_NO_ZONED_GC	60 /* percentage over total user space of no gc for zoned devices */
 #define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
 #define DEF_MIGRATION_GRANULARITY_ZONED	3
+#define BOOST_GC_MULTIPLE	5
 
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
-- 
2.46.0.469.g59c65b2a67-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
