Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA80FD4F0F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W66G0lB+rOCOIbs9PvziZ/VJD2U1XzXDp39PrmKgn4Q=; b=AlroGx8XcBaJn+l/Kcw3i+CNXe
	SAJ1VEGZYv3bLfsolkNJYgWiey+eEqg7qjcR6rNUrQJAxGnl1thIXnBMMYdVvCdf8xssqBglJvQof
	DWO2+pdp58TwvQiWYS+7rrPSarCAVSQktrRHRtyiRi1x73MxYGoqpBwuxIJWMXgrQL/w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w01ID-0004Op-6D;
	Tue, 10 Mar 2026 17:54:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1w01I4-0004Od-5v
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 17:54:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XbzTvS3EAv++rNl9al/HljoKtTK5FcMi/cSpL9WxQWc=; b=GE8QmNiQG8W3ucRL6Sy48XFbl0
 wowZXXK8W0p5fm1RaplGlC5WXPDZ2c6+kXzX2cWwCySZDBuQ7pMjsMhKo8z7MkK7smGbNBlgc85rq
 KgqmEooPqcUveYlqEnSb+1o4R2KCAvfRAPfuwDQkr3pK/R1TwHZzbjPybLsvZxVkObC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XbzTvS3EAv++rNl9al/HljoKtTK5FcMi/cSpL9WxQWc=; b=j
 DunNQ1NIggDqu1RwbY7kn8zR8Cf1PYvwcdG3mm0NkadMK/3VmD/y1fn3xe/t3sWUGEWb9OEawJdpC
 sSR1hiKK49oosaZTganlRKhzLM21eqDo4ST+FjiDqLlCspuHXgch/iX7gTSWSPFBsQgaEcJ6shqqu
 LRwkdaqIK5xKVmUQ=;
Received: from mail-dy1-f175.google.com ([74.125.82.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w01I3-0002mq-Os for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 17:54:44 +0000
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2be19f05d7dso2350668eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Mar 2026 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773165273; x=1773770073; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XbzTvS3EAv++rNl9al/HljoKtTK5FcMi/cSpL9WxQWc=;
 b=WF9MF8MrG/Ve9NJBaZHF6EHRLBlFm48I6OQLiob/1N4CGbE4My6Rpj7pbLe83p7MGc
 PyRyCyzLbAkYDE3u6fVjp3UmWOd7hyN6eD+byO0h9BKfL6jYQYHxHYwKI6EClocXG5kY
 LY91QTFSC1hmAU9Bzy8aRQVhDEEEEMmLYwxRGYwrwwFH1KD1buewo3fzDszPNrkEytJP
 8Q6GQtEmpaFjuY65WBGpMlaTLmP2yy4jqCxbNOwzlzkORsiJG8iiGwdnGFuXfN5OfJ6+
 c2/jcoLwuBKTDfZEKpoWToC60UcjSHUPUMjtVKDkUrcGYjXeoKiMImc0+KNKCYO/QWyb
 cMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773165273; x=1773770073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbzTvS3EAv++rNl9al/HljoKtTK5FcMi/cSpL9WxQWc=;
 b=dqwzlrJ70nQnJ+w80cCUV/5Ia7wVzSYIBc/XHPxOYs8hV1mTIpytWnzPsICqoilYAO
 /ZdEfE/qiTTP3UAbJXUsQerZKYqbhZKZthQzWajUwfhPgZUE3MYjw9dV+LVAxD6SnMem
 GPCHA48APw5LsSpgv+PpxDXrbkdr53fXZoPtxoks/n2Rvl7gbWFdixo0Oh0/6FIUSF/7
 7r1xEtHaliAw5iyFdNtohMlNROaBjGlRfPOmAJyxWzTIRdCkB7SoX++DzsFcn7Rrp20K
 e3dyipyYEKhgZLT7vZkQf5LIy9QW2yTGlKW55OqqW2lfR0gvcCyjYo28LWCyZSDxKchN
 Kllg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2fQY0PtDulP857hv+jkiyMfxFIyUbGi3YZEO/52zf2qiBY1nZ7oaMdoeA1v0QZn/T2xnEk+9nXrz7dC6d5d6K@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxySx3lDsKto2vWVr4h1vOeZHY4A8oEJeKp9Ur+w2w00FBREf+u
 4NT6SZJdaSYhE3b66WyJ2eimuuolfzjFe8YrUKoZ1YzL59yXH9t2rwQu/2kN+w==
X-Gm-Gg: ATEYQzw7sPXHL261T0GRQhBEa+yYtykM4+TmRiMEOXfnYkX+EnGObJ9BDC+wmdwIizD
 EUSPKzYZLhMZCy2GpYeTZ8P5fN4VV3M3TXSPP6WSRNnTeOi8W+lNHr6XlMU6qOLjgFo7l02gsZL
 R1PXU45GCbJTQji4yQgYL88vx9WZnNY0bgoVhkrJ3SvQfDxDeZyJgKcJ4BHGKn9BrtCHGIfGpVx
 YLJQP23h9FQeSfEyVONK0cF4Rgrxmr+IwjGYhBo0xMxz/iEEo/qmwXwLPNnZDdHHWrXxkOcnHJI
 WRxb99dvq60UjJB1cI+ztmArWhmG8uRw+aGum5qX/6V1+dpNWMGgZ1m/0/otLzT/ZLc/YfZY/0j
 vojZtYQcpZWMCswABFGWNyacgrJd65pgkURGlJ7D9ygbPgb0VQNN0PNvt0eSbohc31DPlHkyMHy
 xNDudF4jFJptCqq80+xOrTUK2S0rl2j4yr3rflufopMnu7oerdUqUG2riiw2c7G1NzUzBLifW4M
 Ku0NDDN6XhUgg4mg1V0O8PwsIkdW2XKSNnazKqnNRma6BQdLoOo1osj2e+Vuw==
X-Received: by 2002:a05:7301:1015:b0:2be:2409:6c6a with SMTP id
 5a478bee46e88-2be4de76400mr6649719eec.3.1773165273087; 
 Tue, 10 Mar 2026 10:54:33 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:493f:f39e:ec36:a0a3])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f948390sm13951265eec.22.2026.03.10.10.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 10:54:32 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 10 Mar 2026 10:54:28 -0700
Message-ID: <20260310175428.1156719-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
MIME-Version: 1.0
X-Headers-End: 1w01I3-0002mq-Os
Subject: [f2fs-dev] [PATCH] f2fs: fix to skip empty sections in
 f2fs_get_victim
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

In age-based victim selection (ATGC, AT_SSR, or GC_CB), f2fs_get_victim
can encounter sections with zero valid blocks. This situation often
arises when checkpoint is disabled or due to race conditions between
SIT updates and dirty list management.

In such cases, f2fs_get_section_mtime() returns INVALID_MTIME, which
subsequently triggers a fatal f2fs_bug_on(sbi, mtime == INVALID_MTIME)
in add_victim_entry() or get_cb_cost().

This patch adds a check in f2fs_get_victim's selection loop to skip
sections with no valid blocks. This prevents unnecessary age
calculations for empty sections and avoids the associated kernel panic.
This change also allows removing redundant checks in add_victim_entry().

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2e0f67946914..981eac629fe9 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -521,12 +521,6 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned long long mtime = 0;
 
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-		if (p->gc_mode == GC_AT &&
-			get_valid_blocks(sbi, segno, true) == 0)
-			return;
-	}
-
 	mtime = f2fs_get_section_mtime(sbi, segno);
 	f2fs_bug_on(sbi, mtime == INVALID_MTIME);
 
@@ -889,6 +883,9 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 		if (sec_usage_check(sbi, secno))
 			goto next;
 
+		if (!get_valid_blocks(sbi, segno, true))
+			goto next;
+
 		/* Don't touch checkpointed data */
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 			if (p.alloc_mode == LFS) {
-- 
2.53.0.473.g4a7958ca14-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
