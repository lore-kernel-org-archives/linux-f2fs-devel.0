Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86ADC55182
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dy4pAMLlu1ft+wd6wReWT62JxOf8/ezct7zVd9G6JMY=; b=YlWj4rVzTOcf9M2rn4F21FE2Vm
	jzy3Ag8+9SG7eZirvzbNqXS48/AbeDLIBBbOtG2nwcomSIKGUB5uBlKsS5fqCYJ4D/JNkXmg0Thaq
	evKrjWJcVT597Eqr1KbuWEYHRt8jVCC57My8h7jkPwVfbapJnDbZgQSKLZ6ou2RRHzWk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqrr2-0006Ps-TG;
	Mon, 03 Aug 2026 12:33:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqrr0-0006Pl-OE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 12:33:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2CFvYT3meSbsR/jZYhVf3gjR6FDBilACHDCBXD2pPKg=; b=PoOA/RnoIAs8Vntv6Px0Agz8/R
 +x8XpJDFSwRZUWk2wH7qnaV+rjJXOaYrOU8h8o+jghjYya+z9qdGhR5CEpUUqMrSmYkDVdiev0rgc
 2Kt53MYhdVBJsuzLJQ6IeevVUW0Tr9LVetp82RIcODN/UXAHmhuV2/8SLb+KX/OBQdOU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2CFvYT3meSbsR/jZYhVf3gjR6FDBilACHDCBXD2pPKg=; b=haX+9nwYoQAsnjhrP5yHsHgLuC
 Jf3FI54Zj6/jOHmgSldqzE2EoXX9lbPUHES/2oQGSm+Et1JgBGKfJZvwQAlj3JUfq7qa6iVACXXVr
 /yE7q6qwvgGNhtWgLh9Bw4oSHaOzLspSmh/PM6PsYKMGKaw15VrgY6/Bv911g7F/gGAE=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqrr4-0001kp-JQ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 12:33:15 +0000
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84864086bfeso3470354b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785760389; x=1786365189; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2CFvYT3meSbsR/jZYhVf3gjR6FDBilACHDCBXD2pPKg=;
 b=AQHcfR6NXzbpTecymoYH0GrDHdiGNEcTgX4/d5oWn1n/mSA0qbKGtL/Mdz5cKILxBm
 206LuI1E4JXTC0AFaT61LI1eKsM13oa5LDazXJ515s2rPyI0MjVDuQHpV4Q/DMJCfzdR
 W3HThv8VCBCTOyaiRG+M67AjGIXMP6EH+XZ/g+IZsAMWJFPVSdmoaqm0BiSovoz83D22
 wpISQymDPWIXx9uo8nVpwQwlGCIp3CtIe9afLwYJ1sBbxE8wgMBGzQfTBiETtqrOMth7
 R9tLfSTRMZIiUluVACl6kQorNur0Mfc/lgFWKtB/UwT5tGCN3ENScYSN9yLuPzRH2KIZ
 0V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760389; x=1786365189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2CFvYT3meSbsR/jZYhVf3gjR6FDBilACHDCBXD2pPKg=;
 b=XCKPRc+Krzu7ENq9x3Zyja/rhGM339tMn4uM36MscK6v1cjC880U3vXRCpEqJcoUqx
 qFJi/Rw25pFDFdMW+Ubu6hNKAXe9lwZA2O1Y/vK6Pa3Ao2pfD8uWu5mrdCix7LX9qhyg
 OFL9MC0f3Nb7XYFH06BFkJXWqwx4m507b2l2NUuqrNsfIiiRmWete0N76U3H5OO6XfC2
 qpFJzoGYSGhFvVu4Sx87PqzkaaXzridrkXLl4JQS3mvQXkcDIqWfXn/CC9xTMbMgrLkt
 8ltvliS/BNwBYK0Lv91cQIpIGmncHVma2nyuUpPwhrtLVCeftUYRNvt2GBAh6O6BuI52
 M4Ig==
X-Gm-Message-State: AOJu0Yx/ruxtMw8U7U+S4eRaKnPcDfJVsZ9soLU7H+VfD+d2VSZMEDHb
 fC6Ba4NsSmKKRgBpzs4bkUZVUCQfjiRLrVu0bY64sM7tijLulYhwgRW8
X-Gm-Gg: AR+sD100sbSjV48ndK8F9tDbhB3FveuYffO7gydkabHeF54RYklQ0Bu58YkNxgGFEUh
 RSADkViO32TVZDTwaUk9er4V8U5D2n8BJ2CMBC4J+HSP2pdHPVB5pRNA20YDe0zrCaqheVBKn2N
 OEKsFZALrK24m/IzAgpWgbMyc2jGq9QSfXLcn/qPLDdYrnIPKysaNZnFoBrN9Xuj1RfsqAoc8py
 D7wAVEzUyI+18rzulMUTA6OqE8/VYWZYsK9qCu+gRB9Ew5Y+flAtvkXMRuBKiK/iqWOHNMnqTWM
 wgCsl9ls5wAuZi3CWiWDvg1iOgpRRCthB775bnxNwkybTgzTdVTIBfe8UnMwxSUhcpDygOkPhW9
 kjNy5msEl8KqsU26w4W9u2OA/56AHd52wKQ4P87vIJ/VF9qPGS3jXsuKfl6s9MoPT6sfLapaLEr
 chPIs2Y87v3kOjbXJtC2z2PaF9KZTS8kqLPD4+ZSLWGycWwVUlaZajQYKQRkpOV3IUaQfL/qIY0
 uobl5mLikex4ibHDv2QJTHs
X-Received: by 2002:a05:6a21:2c11:b0:3c0:9c19:6587 with SMTP id
 adf61e73a8af0-3c92a873a7cmr10733563637.65.1785760389144; 
 Mon, 03 Aug 2026 05:33:09 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe39ea0a73sm3598024a12.23.2026.08.03.05.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 05:33:07 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  3 Aug 2026 20:32:51 +0800
Message-ID: <20260803123251.1522864-2-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803123251.1522864-1-qiwenjie@xiaomi.com>
References: <20260803123251.1522864-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wqrr4-0001kp-JQ
Subject: [f2fs-dev] [PATCH v3 2/2] f2fs: protect critical_task_priority
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The sysfs store path already takes s_umount for GC thread control
entries, and ckpt_thread_ioprio is covered as well.

critical_task_priority also updates checkpoint or GC kthread scheduling
state, but it is not covered by that serialization. It can race with
remount or teardown paths that are stopping those threads.

Protect critical_task_priority sysfs writes with s_umount too.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v3:
- split this change out so patch 1 only fixes ckpt_thread_ioprio
- keep this patch focused on critical_task_priority only

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
