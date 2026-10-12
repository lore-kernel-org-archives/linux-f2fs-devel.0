Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A31CA9ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X7Qz2fURCrcRlxwh0+pweOBcQZN629ODT3ystChxGTA=; b=YO+SzvZJOnIONOp9eAZVJ2i1Iq
	xSMxXodCgEwVwmZPTOC2+qz0XH3cIkAWuNjRR7+dQOChPapa7gvL+Vt4cIvL6rL97ua+I1bM4iZnu
	MVO7+dvZxG5geZjRWJhzR9SOYfrYGaoPrhK7BCF3jKt4xVRAMBsYZ0q+JDzZ8BDfaoCk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGDOk-0002cA-Ta;
	Mon, 12 Oct 2026 10:36:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xGDOi-0002c2-SG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 10:36:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TYAbLfcSF4SvwtGMEqZtL/vm+XSKpgh03MXVN46JE/A=; b=UVDDTpLqG6IOmKJIR2o9r5cBxG
 H669CHEQCOlnHMevvwsFUMs9pFBkwTMxqh49S1/NQX6I4RobxvMipHuDWSEozmpfTkUxNlrniRzIQ
 poAv7HIoz5V68yw0TmC3HQIhYCMhiQn85QCmSkOADRz3j2DmGOlujhB47iJVXZEuhY8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TYAbLfcSF4SvwtGMEqZtL/vm+XSKpgh03MXVN46JE/A=; b=G
 Z60PrJsMMpqab5UiA4Ugb8e81orloKZPVn+PrG5DcfCNeIS+pAnKY3gm2X7tJSiDhoQNF2g6dGkIv
 bGl3AC1ETDtFnbWsYOiMMpZRPbLRs6qwDn8jPYXbCSBYBmHdTCQaHWopqoYSLrduWRY44y6zTBisb
 QqYDSO2+tyIlyA60=;
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGDOc-0005Mx-6o for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 10:36:46 +0000
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-88bd2b44f3aso733868b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791801396; x=1792406196; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TYAbLfcSF4SvwtGMEqZtL/vm+XSKpgh03MXVN46JE/A=;
 b=jr+p5libDNVjDeu42L7wuRsZK5pqUneuZSREb20cvn53qbHN1i5j+7ITFCUev6orUX
 OtbkXbVtdzBMIplV9rwCFZ49z4mvF3xvSGKDP3VjEtDkvzvZOSM73xY6svgytjwGNQVY
 MCJsRn1OOs+ovnzeqGaqyIE+3Ez2tfYcSIp6XZoDnPMNaXj9UzLK2QhnAnXGIhDvjZSH
 Ars+iIVmEjEBj6Gfjnv+YW0KV+dfaboiBAHpFo4nA+SHtIEkAA9Kh3JLRlszwqIP+ZNu
 pSLxm39saE/PdbP6mMQQccnh3BcJao2UNurv20nHR+Bldgyr18RIOaIj5JkNWuHUsYbu
 dxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791801396; x=1792406196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TYAbLfcSF4SvwtGMEqZtL/vm+XSKpgh03MXVN46JE/A=;
 b=goDOUYrW4Lr6HhyGIPF+ibjqCI5lUMLahWn/jnn77ukgK3nj6jDA7K7dBJLkydHlg+
 QFYxTEapXNhAyRNsS6Jg9QQjNRkXvKPUi3GZjgURZXpoiEXG1vGV3owqicW5+DxqOxqe
 cLDFepqEN0rn8zY5H50dMN8PmTQxl/7RUVp5iubFquJhjj0mvpaf3OuLXwcopQYhalFw
 liIs3FbZ+ijAxbF9XFaXbnM/XGr5ZYk2CX/h5aJ7KQr4k4XddunJ2tRw5WyPkumVVJ18
 onM/I8ZapIOhXjOnqyKSk/kAQsNIVlnJEPxu5L29ydOV2iIBUa+KrR2kham3pYPQRMLz
 f78g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0Kmzm+2cliDQdQPV5qgZ7ml3TkleWrCHjFQRmeXQsu8b68933/n7fUZqPlTbZXolBHpNw5tlkokOrBhSrEH69@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLAGvZBHowTQZCMY7Qki3BqtMzZSgWt8046icDkPhER6c1OWwLM
 EUqXUzAnuA41vNUJWxgVt1/iYjorSxlbz9tHTm+LgXg06ka6/NorFbOV
X-Gm-Gg: AYBFou2VOX9BlOFKzNUgcZX5dwb2fpLztduJXqlfMklSdrHOHoco6UGwV6vnnFljGDx
 OBcQEf6HHhgWCAua0uq4cCT8PPBh4/lvMaND4q1WdouiVv9GkU6X8NMod3MIjsX4Eubpt7RmVh+
 gs4kW3HBlWpuvuzXtbo4AdQ391b0OuyxpEhLborel2j9rjGft1wO2E01hc4NqjOVwS+C/JnfG+B
 yNryGI6kQuP2ZIRNcZDqcj6jSEhZwpXmygfqANNV7TG3HqBncV+wSOVCdzpfeqSndqsAIsHAyPq
 BhuQLDDzx28HgafWYkDur5RNgn47hRRKWWVAxPw01DuMrA2Q7JZgMJ1EdqHyIQn1Q5obEptbIRD
 WlLy6qD1+tnJhB4UkYJ2X3ZXxvqHjuH+F1f8cUHpJP2cFBzjJTV/u5vg2VXMC01gnJeGkMNa4es
 oka3ruzXHOTb9s/7wXZ8Ap5fW8LbunRPgVbJItHq1snFzzCyHHrI+HfZJ8V+3iEw0r+dVkCt/H8
 lSwzwX+Q+vLBqUlgygv5420fjaRnRpPPT8=
X-Received: by 2002:a05:6a00:856:b0:886:b762:8bfd with SMTP id
 d2e1a72fcca58-897c7cd10efmr7613646b3a.51.1791801396300; 
 Mon, 12 Oct 2026 03:36:36 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c4996be6sm4019639b3a.58.2026.10.12.03.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:36:35 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon, 12 Oct 2026 18:36:29 +0800
Message-ID: <20261012103629.1763003-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xGDOc-0005Mx-6o
Subject: [f2fs-dev] [PATCH] f2fs: wake up foreground GC waiters when the GC
 thread skips a round
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

With GC_MERGE, f2fs_balance_fs() queues a foreground caller on fggc_wq,
wakes the GC thread, and sleeps without a timeout or condition recheck.

The root cause is that a foreground writer, the GC thread, and fsfreeze
can race as follows:

foreground writer                  GC thread                  fsfreeze
- f2fs_create
 - f2fs_balance_fs
  - prepare_to_wait(&fggc_wq)
  - wake_up(&gc_wait_queue_head)
  - io_schedule()
    waits on fggc_wq                                    - freeze_super()
                                                         - frozen =
                                                           SB_FREEZE_WRITE
                                                         - sb_wait_write()
                                                           waits for writer
                                  - gc_thread_func()
                                   - waitqueue_active(fggc_wq)
                                     returns true
                                   - foreground = true
                                   - frozen >= SB_FREEZE_WRITE
                                   - continue
                                     no wake_up_all(&fggc_wq)

The writer keeps its superblock write reference while sleeping. fsfreeze
waits for that writer, while the GC thread loops because the queued waiter
keeps waitqueue_active(fggc_wq) true.

Wake foreground waiters on each early skip. A skipped foreground-GC round
must not leave its caller blocked.

Fixes: 5911d2d1d1a3 ("f2fs: introduce gc_merge mount option")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Reproduced on a 512 MiB F2FS image mounted with gc_merge, filled and
fragmented under concurrent inode creation. The kernel reported:

  INFO: task sh:1381 blocked in I/O wait for more than 20 seconds
  Call Trace:
    io_schedule
    f2fs_balance_fs
    f2fs_create

The SysRq task dump showed fsfreeze in freeze_super.part.0. An NMI
backtrace reported:

  CPU: 2 PID: 229 Comm: f2fs_gc-254:0
  Call Trace:
    gc_thread_func

The f2fs_gc kthread also consumed 301 ticks in three seconds at
USER_HZ=100.
---
 fs/f2fs/gc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 926e6976bc2..086670f9df2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -66,6 +66,8 @@ static int gc_thread_func(void *data)
 
 		if (f2fs_readonly(sbi->sb)) {
 			stat_other_skip_bggc_count(sbi);
+			if (foreground)
+				wake_up_all(&gc_th->fggc_wq);
 			continue;
 		}
 		if (kthread_should_stop())
@@ -74,6 +76,8 @@ static int gc_thread_func(void *data)
 		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
 			increase_sleep_time(gc_th, &wait_ms);
 			stat_other_skip_bggc_count(sbi);
+			if (foreground)
+				wake_up_all(&gc_th->fggc_wq);
 			continue;
 		}
 
@@ -83,6 +87,8 @@ static int gc_thread_func(void *data)
 
 		if (!sb_start_write_trylock(sbi->sb)) {
 			stat_other_skip_bggc_count(sbi);
+			if (foreground)
+				wake_up_all(&gc_th->fggc_wq);
 			continue;
 		}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
