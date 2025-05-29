Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A24CC5AD49
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 May 2025 22:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xLqbsFnxZSWuHwuAC8y3uERRQCg4ewt+qOQvYoHO35k=; b=fZ28mDe2mnPm72xvzWmyQFttct
	bpM8s7OsRVW8NUK9YlXl1+pKmsOAsRUYiEChs3MG+LodKj2mnXsbmw3gUKtbt/RltKte5bxQJBlIx
	kICQbWQ1IRwxRlyaQc8OR4fbyEizYhaUOiTKqIlolS2Ri+syN5bqaWYoBxtQMcgU+DYE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uKlh9-0005sV-TR;
	Thu, 29 May 2025 22:25:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1uKlh7-0005sO-Tl
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 May 2025 22:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=drHrrRT39Op87szRQpY/iTZqFXixV7SuUvHON4DmPJk=; b=SVsjg3HGbczgmA1inxZyciitv7
 2f6A9rVCVI1trqZKAI7l5WeWZ1r10XEoPoNneOBlfi1/ucAQ/11VZbV12Wnz1Bp75iavH0czlpGXd
 HG+XKVvSGlzY+UNNzmuYMIzcjeojt8YS8PqbSfhXc1xNvjXUNzxyXLZCfMj5udRGzEME=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=drHrrRT39Op87szRQpY/iTZqFXixV7SuUvHON4DmPJk=; b=L
 oUE1+jTWG4XCy9P7M2+IZ4JYlLnPnonhk2e4850GPAK6E7QSHnfF3tPyUuVVstvF0BAjEzV1x6hLo
 DN7rXO45ywR8s8y8MkreRjKw+UfhqWW65jy08ogttIAb+cEOExbcX82GP9WDEPCMyckpO28Tnk/nd
 cNqgn9dagxUwB2P0=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uKlh7-0003He-85 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 May 2025 22:25:49 +0000
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-74267c68c11so1210583b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 May 2025 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748557538; x=1749162338; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=drHrrRT39Op87szRQpY/iTZqFXixV7SuUvHON4DmPJk=;
 b=nqXFdXNukJl0HqcwvmzneQj8DWsdmMFKLnS3oQ8b1GC1Y0/JbPHK9s7EvgXgHqPdNe
 IiG8iX0Bdvy2m6tYKGd2i50rOwFYKNJxnLYl3hy37arV9hQvIshI3dEiq7luUPlRFcEY
 RnsZZ0P82OwIS1N3qQcbM9tGPHe5VE+JfugqxX8r4U/Od6PmUkewxvLAxJg/FCDtgxv7
 cODDPemjae+sNI6CWrFUL+Tn2Nr7aXzcsCysNUFhzDAKPjF5G7qgA3Pz5JURp7b/iA/c
 RxPmH3x8Xc4bsGKVogJBZ1NAKi4SAWj3kogyER2QLhbUJ8uQaIX8MrJ3vWjZHkVGvLAj
 GIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748557538; x=1749162338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=drHrrRT39Op87szRQpY/iTZqFXixV7SuUvHON4DmPJk=;
 b=Kxi+SrhHWVZ3t8zernEdLhLzIEvt+HQAgkKa8UwJoiIIYM/H61bHXdFOjRwYpUcNqJ
 L9jGwLK9lEOWKJIjcbgTkyaHaUXovNP4pJyBl4aOuf0/0SMm0K/WKF7VJTNQYzvcPryl
 ghhyiGpEQIYmjqrKwWMTkWzpNSXPQpt1d2moS1vD5aWP7Z5V9kuQMKJfhhS1IklTEtAj
 0bt4oG9DtwtwIolc9kL/w7J0Pc0Klk/7yrMtgVklo5UMjZTDGU/k1s9lkw9iZBZW1Dzb
 SksOk1q75pBDRGd3jydS8UjZwvyWokK/IERvrjjnu3ar9JFfSjySA45G4D2kCyLe9lj4
 ZWTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaoIFO6K48DLHCDwA7crTMb6wg6NpyBNNiqPWEh7zfjbo70o8eljVJKeFZOWt6WBPeiDmWjSv9o9v8BXQ993Sc@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyJcWPW7Y9vsl6SA/cEeBa1GRQ6mxn6qLbh1N6ctJIL6MoWAlfU
 wQy8ciWqwvSkmtv1cU1G3xSCyfpmRz+NqVv1QQs5Z9dCYk/xe+HIuy3FyCgpXA==
X-Gm-Gg: ASbGncvrF0nAvgT7xPJ32yX8cyNLOWcV1pqLa/j1XD4+j2EC7QtRqZImpaVOcNDtKuG
 8zupk//08eUiL9IFLocbKNKY+j3/5NvU5/PZojixYxrudX5a61dxhSUDbUUex+u+3PLCXKtn7en
 QxU+MwvqiInuquSfQK4ohCAwIU+cTSDyhyHWCAGiSN7dH70DRoKkmHiJifct4ixhOf7vcIlDIhp
 C+2Z0Iec9kDpZRWPWDSs/fF6kLQiFpts2usNiShopeFW2rTmRUnhi/KUrhunfkpqxET1i8iAupK
 /A2WInE4ShZC4ltqO2fTiojpVQdMzh6XUh5QtSuyIFIrRpEF9jAsmkO+9aqC9jjD+x7Y6/Ik1um
 YZxp9V55gDKWJgJm7MupgrRlb9dFr8eVw73a8FkNC4LaF3FqMJ/v2xQ==
X-Google-Smtp-Source: AGHT+IHlBHPluOs//bqnUjchs07T0PB+X5G4b+ihLaWDzs+KYZzqJ2rb5/G1M4hLSxKiNhQG9WzP+A==
X-Received: by 2002:a05:6a00:4f8b:b0:734:b136:9c39 with SMTP id
 d2e1a72fcca58-747bd9f148emr1247882b3a.19.1748557538421; 
 Thu, 29 May 2025 15:25:38 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:a46d:d724:4557:2a3e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affcf25fsm1802750b3a.121.2025.05.29.15.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 15:25:38 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 29 May 2025 15:25:32 -0700
Message-ID: <20250529222532.1088106-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
MIME-Version: 1.0
X-Headers-End: 1uKlh7-0003He-85
Subject: [f2fs-dev] [PATCH] f2fs: make sure zoned device GC to use FG_GC in
 shortage of free section
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

We already use FG_GC when we have free sections under
gc_boost_zoned_gc_percent. So, let's make it consistent.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c      | 2 +-
 fs/f2fs/segment.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f752dec71e45..cd13a642055b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -144,7 +144,7 @@ static int gc_thread_func(void *data)
 				gc_control.one_time;
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
-		if (foreground)
+		if (foreground && !f2fs_sb_has_blkzoned(sbi))
 			sync_mode = false;
 
 		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 396ef71f41e3..030540df3550 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -446,7 +446,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	} else {
 		struct f2fs_gc_control gc_control = {
 			.victim_segno = NULL_SEGNO,
-			.init_gc_type = BG_GC,
+			.init_gc_type = f2fs_sb_has_blkzoned(sbi) ?
+				FG_GC : BG_GC,
 			.no_bg_gc = true,
 			.should_migrate_blocks = false,
 			.err_gc_skipped = false,
-- 
2.49.0.1204.g71687c7c1d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
