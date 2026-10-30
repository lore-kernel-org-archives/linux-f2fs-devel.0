Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79C606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KlgKYfXu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GM4A+7A9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K+weDzF5;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CBWEGkP4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=OcKaFVUek7gNPuNBh49uVq9DYWL/aXk7Nrzl1rwUfNo=; b=KlgKYfXuvo5q8U0x4ySwOSv8tn
	j+pGAjhO7/87Dbt31tcEDSPIoPBa6WoGUlR7U31nHjNKM2qN/35PDfUy1W8sGE6ULakc7hCLyo8ak
	hbpUaxsGW6SLQK7u0OlXcCpt9AvdHlGZA9R2/6iw+a1PPieMl0dc1N1ZJcvHYWdhgV0w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMgyj-000000004HK-3RGn;
	Fri, 30 Oct 2026 07:24:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xMgyZ-000000004H8-3Q25
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 07:24:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TC09uNuPonGXjl/unVFttCF+flEGGGYAyLCGtQa6eaw=; b=GM4A+7A9HygTONHaR4chnnhDOA
 6TIiAbM8tt/f5oJS13XZgTxrr0hjY7tTHV13qN4UoheNgajmm6b0XpRq06n9f7bYDxUadiGvLOrNz
 gB/cAhgHlQWcSbhiLq+nwsfW4huosroAQ0ZS/EuLlXnOvFW2jWqbAaUHx5ViOk/qBrhE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TC09uNuPonGXjl/unVFttCF+flEGGGYAyLCGtQa6eaw=; b=K+weDzF5Y9aT0AXDzfE8saayF6
 gSYF2vSn9rQkuldrSBdVh9/qewRm+9OxSD0WMOglCqd4lKSnYRccJxFP+uS4PQoOwLuqek3SyWzFd
 syULzIECUGvlZAAbOtPpFl0DEUmG69FPZg07HckuqDaYYgczrUmlURGvjNQDx7NPxCZU=;
Received: from mail-dy1-f177.google.com ([74.125.82.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMgyY-000000007Nf-1XY7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 07:24:35 +0000
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36a17a332ecso778618eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 00:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345069; x=1793949869; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TC09uNuPonGXjl/unVFttCF+flEGGGYAyLCGtQa6eaw=;
 b=CBWEGkP40ihgI3tRqShnjOoOVi9mpCKsqTUsHf3Rpr9LDxHFXUKKd+QkADPgFy2RHe
 HnLngdTKBBGFeVPEDuz1xp2Hv/y2bkpEUtWmtp+hkz0zD0oiiv9iI2n2D8SFWFXHVl1u
 6PZ0xSDV6S2/IBOzSlsKPGKXblKlWbHRqevii4GWQpRtGS/lMEVHiAeVgQ3NTUYGjxal
 Nfxp9jJjTDR1kt+IXZEAreT72bNCAwrWpth2bEG4Z8smimGoeplJpSV7iYQP40aE8zki
 N4wV8y2VTig0nbuyc6ZvVFvj5Syz7lN2TjUCMc0maDtr29lRZgUeaANN0Ab6gr1Y+mud
 I7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345069; x=1793949869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TC09uNuPonGXjl/unVFttCF+flEGGGYAyLCGtQa6eaw=;
 b=yIHjvkAYBNHV4hJSJCyzx6VJD9PvxDQ+luF9ob7edIVAJCmV+KzJNKR1MKOSTocPQ3
 JVzA3hLfXn0HVXXeU/RFiN0pD57eb3M4IhPAKslOVLn9654a6XfWKPI/MVRwehK9EJ2x
 FvTgfuEOnG5zFCmOjjLEAGu25nda6+OmRYY2iSJ+2dWCOgSvc3e11gMReL+5NoetQDRq
 NCPsUYu6Y3Dfm0ghcXZzvY6z773AV2O0k3p85h3ae5PsY5m+MpXBiMkYCxVyuYkYqi1R
 8doQ37uw8BZNomtk6SUnlrGYNmEGvoZ6nHae/9Uu0bpJJPa8oqFL4lqMlYr9QYwmfhAs
 g5NA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNN+7bL0hbSLr84sOCISr94wcpTGMP2yV/QJd2Tt/i/0Yyp6hcCGSdPhwMrDRGukq5qsTPqRyU9UwRl60Kr4+E@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLJAk2ekllufpjzlqBEdUEI6zzRMvuRA5qwcYe31HaVukOUBGmx
 GXZ4wPo9ws9XAeOtq0kQjQciZt+BefMQwxpSUsJYKGvZKjp6DgNJxpnO
X-Gm-Gg: AYBFou1mITqpFkvv5pB95HzWftDs7swuWZtrYr1vI2Dchx/KLo6Ehvk+5vdr9QVA6T/
 tALXT9U4SajFDqF3lH7up6bBpb+Gm6UNye39X7osvotw0KXg7Hi+dbDvuTqTvFilp/K20/hNNZA
 SGBNh00r53zs+l7egIIvhgyxy12PcRKvIjWDVxd8TWaIw0QSGpcvJ11xK+KJKVofp3Lo+D4EUKf
 /2efJvWZlXQyNbxLhV/JDDijfLOyNiP9LMBoCTnvNdh1H4gTqAWnxIRymO5JcuuODCYMqwTY+be
 E2WCk0juiBwOqBZYkiM3H9dkbuQ8XJEjyjfsyZMXubYNrUmky6g3JA8bkH9JzOrLuVjVL03F6CM
 xe19KGEyZ1RgVE0A6xEVaMJ/tqijzcxRqu5HWBeLNNE0Xwxai920CHPBDj3z8iFq3A++uvcJodv
 0Aa7gqXZ0w+XNCqv4vzT0XrGYqsm20SnjYM215riLeAFnOTkG7o13jVq8G0M3rPg7b94XIGYOfr
 TB4YAfKX2x04aM6AxtxUr0kHHKSdS2UMK7CeV7mWlG03zOZEAkGGnCDeyiEDfnYe9qtvfJrrjmw
 TDEBK2m0RJ0EPecjW/iNjXwmNXixx2poPqjCkUsuuthsIw==
X-Received: by 2002:a05:701b:428b:20b0:1a3:dfb6:e593 with SMTP id
 a92af1059eb24-1ac5eea3690mr2126468c88.27.1793345068566; 
 Fri, 30 Oct 2026 00:24:28 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac18458e07sm4462883c88.8.2026.10.30.00.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:24:28 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 30 Oct 2026 15:24:22 +0800
Message-ID: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xMgyY-000000007Nf-1XY7
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix use-after-free of quota file names
 on failed remount
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: sandeen@redhat.com, zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 lihongbo22@huawei.com, syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

f2fs_show_options() prints the journalled quota file names without any
lock that excludes remount, and a failed remount frees the current names
before restoring the old ones.  Reading /proc/mounts at that moment is a
use-after-free.

Read the names under rcu_read_lock() and free them only after a grace
period.

Fixes: 4b2414d04e99 ("f2fs: support journalled quota")
Reported-by: syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e818dd42ada3b583bed1
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
The names are not marked __rcu: every other access holds s_umount,
except is_journalled_quota(), which only tests them for NULL.

 fs/f2fs/super.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1071059f2cc2..510df7998c18 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2325,6 +2325,7 @@ static inline void f2fs_show_quota_options(struct seq_file *seq,
 {
 #ifdef CONFIG_QUOTA
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	char *qf_name;
 
 	if (F2FS_OPTION(sbi).s_jquota_fmt) {
 		char *fmtname = "";
@@ -2343,17 +2344,20 @@ static inline void f2fs_show_quota_options(struct seq_file *seq,
 		seq_printf(seq, ",jqfmt=%s", fmtname);
 	}
 
-	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA])
-		seq_show_option(seq, "usrjquota",
-			F2FS_OPTION(sbi).s_qf_names[USRQUOTA]);
+	/* Remount frees replaced names only after a grace period */
+	rcu_read_lock();
+	qf_name = READ_ONCE(F2FS_OPTION(sbi).s_qf_names[USRQUOTA]);
+	if (qf_name)
+		seq_show_option(seq, "usrjquota", qf_name);
 
-	if (F2FS_OPTION(sbi).s_qf_names[GRPQUOTA])
-		seq_show_option(seq, "grpjquota",
-			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA]);
+	qf_name = READ_ONCE(F2FS_OPTION(sbi).s_qf_names[GRPQUOTA]);
+	if (qf_name)
+		seq_show_option(seq, "grpjquota", qf_name);
 
-	if (F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
-		seq_show_option(seq, "prjjquota",
-			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]);
+	qf_name = READ_ONCE(F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]);
+	if (qf_name)
+		seq_show_option(seq, "prjjquota", qf_name);
+	rcu_read_unlock();
 #endif
 }
 
@@ -3151,8 +3155,12 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 #ifdef CONFIG_QUOTA
 	F2FS_OPTION(sbi).s_jquota_fmt = org_mount_opt.s_jquota_fmt;
 	for (i = 0; i < MAXQUOTAS; i++) {
-		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
-		F2FS_OPTION(sbi).s_qf_names[i] = org_mount_opt.s_qf_names[i];
+		char *qf_name = F2FS_OPTION(sbi).s_qf_names[i];
+
+		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
+		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i],
+				  org_mount_opt.s_qf_names[i]);
+		kfree_rcu_mightsleep(qf_name);
 	}
 #endif
 	sbi->mount_opt = org_mount_opt;

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
