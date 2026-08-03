Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18912C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYK6chwsiqtZXKMlgZx0OHkzbntgabF+lXQeA+MfZuc=; b=W6jos3ptFqqbhkF0/HaV3q/hIb
	CMr/E/F+R5sC8IXcU4QyoNh9/W4/u0xIvb7641KH56iWkcCFbehqfoZiB6Q/ZuIVkyxZ6rZt55TVH
	p4jHODHyJEsYwxJzE/+ACzc8ejikrJK/1Fi247IX+ItavUbjZzvt/rdBjeFNv6VMaKsA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqotM-0000G8-VZ;
	Mon, 03 Aug 2026 09:23:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqotK-0000Fr-Sy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:23:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yS1pkDTx/3ENg/QuMvIu+4N1BK5KviHQwq/2zS2EKxo=; b=CIVd44Av2fNXUO4ttevPL6K/RD
 o28oXJ7aUv59Za7glZ+NUgQfUzxBZcsDJnjp6TLKvIxPGNqxDjnrz81CjVvLklv9t1+TpVrUlsccA
 uQWLRG+vVghjQK0zXZn8lGZBPuEXW2MIEc7QV8EnZrWjuC+QlUePeXuf6ZgWWdQNBKtc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yS1pkDTx/3ENg/QuMvIu+4N1BK5KviHQwq/2zS2EKxo=; b=O115vyXb6QzXrv6LJSbjcfXx/6
 6v19nKHyFKhrkTW5eF0Y6Ifk0/JDpKF8ST7xGamsUnEkH7DX7G5pHDOqQUOW/GwPbL2J2Zc+xJeu7
 H49WFZXuNJOTjIeC/5FgAnhfa8bhgxrk0Uw8K3icAP7t1VsxmK3OFiWwikNm4x2UpKko=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqotN-0003jG-SX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:23:27 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so2589792b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785749001; x=1786353801; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yS1pkDTx/3ENg/QuMvIu+4N1BK5KviHQwq/2zS2EKxo=;
 b=MXw2MuEf9eeOs9rusmuTgMgh6jTkAs636LLaNYyuXKXcTS/Uia2Isot7XqcCvdwZLf
 KB0sKZ3g2dTvE8qY+A5JICFnkEojy6fL6AL9GuDAleUh66octp/ahKXnT149VnY+55mf
 +PtP8sydtkwmlEpNsiS9W4lc+Hvwk0WoZp/IQG4BbaTez9FGwmmSyBrZr3MQqpEuXu5y
 BxvfnXPfR/OFR/ejHfHVpqR+6hEedJGTX8iPgPuog3Obvi89P2Fg60pVDFK58YAJldLo
 ySlEJp9SEGrBiUTHZymmTi0T3+9NfAwZXpUpVTdDa0FCskNRTfgddwPqe9Fsz+deCwzu
 JYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785749001; x=1786353801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yS1pkDTx/3ENg/QuMvIu+4N1BK5KviHQwq/2zS2EKxo=;
 b=IWGqCnlSlVnzG/cD0/ybW4gYCXLFGsePbNgX579EWhKc/894hGU96xA9rbC3WG25/O
 MxGtjFXOBtWjuua92mQ3EdvwG2sjH/RCr5XFYpHbqlLeomVmnaePEtzYJPKma63VrdyA
 rMVhKEwj92oxISDhfaAhPyNFLaGPBDUHdz7D4s8KT6PWYtQBuqUmMD2KQH0F/MsOkaft
 LjpgD3D2a246i3Eojat80h7Cgzo6u0vwgCNc70XVrxQ6W3NbtKJqVDMC7fXuOAPhjZgt
 /kIpaX3ICss52EfSrR8mc7Qz6xZNh8JzoNgJ+PjVI095K3wWpEE8mPFyu4ArqvtlpAKZ
 0+oQ==
X-Gm-Message-State: AOJu0YzuP3BU//b4d5NF/O6JYs4nYAjKpDbUnc7XHDIY5VbVqzuJnXw5
 N7f9EjZW110sGBzTOCPmDsrBNE0i4Y0FPnt6lUsWd/Y25mvZDdp0jIb8
X-Gm-Gg: AR+sD12pZFCVg5kboZxKagy4yKidqGFyp3348hcNC5ddUAgJAXBaacqxsTjsl28GMqV
 bcqMBjmKEqSDvxLB5Jh9kzbpjEUP4hm8bgNfHqsb1m4wuMw53dPDXGUvFBFJriHbXpzanK2Eee7
 AtdV7r7g9V8EO2wic6NdDglYqe9+DbnqQY98hHRXkM8qV+Q1MOUTakcPAnYhXKRXrOnCZyNXgnQ
 4Uo0bktQAjJxGRo6L0ojWVk62M2c3an37heyGOWKVDAzIWv0PjpvtITwV+Gj/mtMcCBnZu8n/4Y
 /w4al9vNd3r8an1YVrz+ZssCLTknkRcUH2vkEQODxmp5Qrqy2qCHmzpd/VAaH9IZQR+C5kq0Lqa
 mcyfC6pNDdGYrBkc1GtiYU90u3q6XJYM/BvNnNsVWdx17IyF2hvj6OavTkTvuoxr1liXaD5HKfx
 UUjEX31b2KfxIZo0fh/GNfhznNnjRuS3OSq0zOgO0bIBXKwLj2C9QWR5h5BUdqOY6huzHoH5yON
 9dDMMcT3hG0GhK9MfMxzj50
X-Received: by 2002:a05:6a00:4303:b0:845:d274:c021 with SMTP id
 d2e1a72fcca58-84ee4949ed1mr7678387b3a.58.1785749000660; 
 Mon, 03 Aug 2026 02:23:20 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe396eb4cdsm3354553a12.20.2026.08.03.02.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 02:23:20 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  3 Aug 2026 17:23:07 +0800
Message-ID: <20260803092307.1437283-2-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803092307.1437283-1-qiwenjie@xiaomi.com>
References: <20260803092307.1437283-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wqotN-0003jG-SX
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: protect sysfs thread priority
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
entries, so thread state is not changed while unmount or remount is
tearing the filesystem down.

ckpt_thread_ioprio and critical_task_priority also touch checkpoint or
GC thread scheduling state, but they are not covered by that
serialization. They can race with remount or teardown paths that are
stopping those threads.

Extend the existing s_umount protection to these thread-priority sysfs
entries as well.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 070f9807ae81..aa1621419932 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1007,13 +1007,15 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ssize_t ret;
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
+	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio") ||
+			!strcmp(a->attr.name, "critical_task_priority");
 
-	if (gc_entry) {
+	if (gc_entry || thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
 			return -EAGAIN;
 	}
 	ret = __sbi_store(a, sbi, buf, count);
-	if (gc_entry)
+	if (gc_entry || thread_entry)
 		up_read(&sbi->sb->s_umount);
 
 	return ret;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
