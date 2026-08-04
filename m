Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841B5C55182
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCYIns8VLhNN7nOkFmBgLSaRzl2pIGVy+e4k0LkJBCw=; b=j9h9/p7UXTPbUdq0FCSfAoI3cY
	UAF1ez6RMse476vYoTAov4yMsb6vjl6ijuyU6cnQ90oLaWxDy8icjh7xo2H9y/yZCFBzJHhVDZ4KB
	/qkgF1qsCbGJuYooDbTvhQyHbQBrQ4pVjdSIKo/9RUjEhl9PUlm7rEVNAQkaoSuhKsa0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr4HY-0006Sz-MN;
	Tue, 04 Aug 2026 01:49:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wr4HW-0006Si-OC
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 01:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p9UUZhHzBL0Wbr/6hSQnF2wpuU0KLFFKUXVoMxJYIEo=; b=AiOU6A7g6Bs3Wps8Yu5JduqGkw
 rhUZAlSh2Z4kVNxa5z4Wf/6HDQXuM/KNfWFuqaMm0tqXGLUDmHpUMrH8TV5qfooK5x8yGPzH0T5O3
 eZPfluhQSNJkpTzOmmCLlwramXPMFUCeat8E3RCntZTbMBaYVAuHfiFPJ8hg3kZI+qy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p9UUZhHzBL0Wbr/6hSQnF2wpuU0KLFFKUXVoMxJYIEo=; b=XUnElaqKG5sGZBZqljseIgplUb
 uht8b1Q9afgygRfuWC8FN3cVdicd8dGll40mZ+/zwDB541Vz6Qe+4mLN8wigsuxdrIQPHGP7ApwSN
 Yue2i/0xHFh2jTfOCkiNG/iE7BMqlr9eRSwmJ27SYExlWRTwmeCFMwvrtPUwEDv5EXMI=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wr4HD-0004qw-Iy for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 01:49:07 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8423f236418so3238609b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 18:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785808142; x=1786412942; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p9UUZhHzBL0Wbr/6hSQnF2wpuU0KLFFKUXVoMxJYIEo=;
 b=JV4MaqlB6/OCje/UX94YeYw/ZpAXK6ciaYpiNY0ze6g28LrJNpPE6aMFcGobogc1RN
 BV8v1Mk/TPh2GjVTDBcmpfWcPqRFfofYrEUj5aCDqk3tb2+RWeJDJYBXwllFhuEMJJmO
 vRUSoZ2Q/xK86E4Mjro0x2xxulMaWF5fXMxq7kOWsrI7iZ3YS5VP6mdD+Rm5Z0oPDjP0
 XqOBj8+iZcO+499V9SQxNl8wS3a71VBakpPHrovvyscasMWveSNn0PEbyLT5ml42qD99
 CQZPMhjVavuOBTxCdmPmSsAjwgMxPRbtsbIvhpZWoxpEKpMTVF8iki4gr3TnsPxH8Ni0
 FAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785808142; x=1786412942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p9UUZhHzBL0Wbr/6hSQnF2wpuU0KLFFKUXVoMxJYIEo=;
 b=njjUg3Y2q9AHj34rd7/IODIucM8F7CEjdDWdGVP0XEp8IaAin97/Qu4VApoOZHlT41
 PxaFItqVf7zPZd//dCFgS6rzu4EMOK+e7NCUTWQAt8KIPdrQYsF4w2Xje/Pn2C5e0NoJ
 JqRlgBMVgQnR9DqAGS2rBiGuwIQWu5ZgpO9LcApgaSqD/7w14dsjyRS6J5zSjnaF0oJ2
 rcvivo0SYMnroh31eCZ3XZ8XN12kcgjNmTWq8kbTcxtmN1nAiD6puISgayjC0T4Ug6gQ
 caXyT/dOiumHkYl+Eb3uU+IPxdydDDWdOjR2PVGECuUshWhNqvcNv3yJaRUSjWTSCOr+
 BApA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpj+fItg8NNo63WkmMpbevSZZ7MU1QrrlraEO9Hlb+4o16gfkA1QrvdxxbCQg/zqW8INa2ciPkLJS5i4ZKz7WVt@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwSUCjzzvOz6FHJgbF/edIgaw18+7nCkmraYUK4yGA0I1XqtwU2
 ytaXqdqIasm1RlhqO+nnxtsBPvhiUuHqLnDCRquRL3X2qV83nsQ16bwG
X-Gm-Gg: AR+sD10YwYXHOMq8OHZuaRLIrdB/nfZMOwlq8Z6GQFUV7p8LS1PuTbdzLUF5Lpmy7rS
 NKLCjx/GjU5Q4uT3I3MQTpSYyzIZUOhFFpmm7XwEs3bQASO6ywp/nOg+PREkFZD2dEYc9z+pJom
 gufa2vToh180+A748MFSqDWjfGLDS4qIcKlx6ssg9PSNsi7RKmyX7xyk8AnwIdH5Lb50HLFFpHU
 mtK6pKc2dqZeufQp3VpXMuhhiQuqtCQ4/hYri35m0yWP6iK/UkvZcD1O8a3rX+HwPunyoi6Larl
 Qr5F6zapo0B7zIs1+l1SXOUfn5sUkDNYzO7JctHE3PrgtecFrrSPa5X9ag1cRT2SjD1NUHrRN0I
 /EevNF+5T4nLyrdQrhlkFmtIy9KIv+Q/W+uKipZIm8QcsZEZlyV+we7V5iUVzB2F1b3BKpvUCS7
 CZe1JuZVaEuM7EC/9POMjM5gODMPMI5HG22EMfoge7slqZwJbdEA3dN3X9KY+rRkF9aRMTg8GI0
 AlNThiwYsn8wuGsEuHpoBXj
X-Received: by 2002:a05:6a00:b8c:b0:848:812b:848a with SMTP id
 d2e1a72fcca58-84ee4833136mr10878508b3a.33.1785808141799; 
 Mon, 03 Aug 2026 18:49:01 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edc2d4473sm4315253b3a.40.2026.08.03.18.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 18:49:00 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  4 Aug 2026 09:48:49 +0800
Message-ID: <20260804014849.1942326-2-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804014849.1942326-1-qiwenjie@xiaomi.com>
References: <20260804014849.1942326-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wr4HD-0004qw-Iy
Subject: [f2fs-dev] [PATCH v4 2/2] f2fs: protect critical_task_priority
 updates with s_umount
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com,
 stable@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The sysfs store path already takes s_umount for GC thread control
entries, and ckpt_thread_ioprio is covered as well.

critical_task_priority also updates checkpoint or GC kthread scheduling
state, but it is not covered by that serialization. It can race with
remount or teardown paths that are stopping those threads.

Protect critical_task_priority sysfs writes with s_umount too.

Fixes: 52190933c37a ("f2fs: sysfs: introduce critical_task_priority")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v4:
- add Fixes tag
- add Cc: stable@kernel.org
---
 fs/f2fs/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 0729b3670415..aa1621419932 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1007,7 +1007,8 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ssize_t ret;
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
-	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio");
+	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio") ||
+			!strcmp(a->attr.name, "critical_task_priority");
 
 	if (gc_entry || thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
