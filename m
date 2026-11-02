Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166A606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AveO45Fq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IYHxSO2R;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bjbM71ro;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DqliH2G0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=aKx5GIVbhz623lxOBlM4hQBfkv78lVDYaPn82qp0p84=; b=AveO45Fq0gey+M2EuSzPI1Ij6b
	7h+pXvv0Te+LKt8i3p/6PGY3fWWJLRQ2JCeDz2mH+/QLjx+ak0uIjNS7Qd7FDZPBKyF1HAEMvWw9Z
	FIGD+cQ+FrUDv9DiEPQ8+FOZlqXG2BcHOpcHAawSPSNAumY1ZJ0Ayj/ZP+eWv9ZoiqJA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNhvH-000000000be-0cb7;
	Mon, 02 Nov 2026 02:37:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xNhuu-000000000bE-0KiZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HEEAk/Q46YxnwTmxNKxdH+qih83wDE1j0UFvCl3PWms=; b=IYHxSO2Rmn5nBgDdkU3dfpQve4
 fkDMl6VvjtqJ+EKkii3G7mpqkAEi8XHvwjNETFb5AbP/j+XhtwbmUnjFUa1sDo3SH68iTSCHwH3yZ
 dw7iP2uGchPI8sj1cF0295TGfk2r6MyJc0TInzui+afsSzL3ru//dJaByTrCxg/HQymk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HEEAk/Q46YxnwTmxNKxdH+qih83wDE1j0UFvCl3PWms=; b=bjbM71ropFOOqHOOmJYTiuoEhP
 8CA54imhOJsPOVccB1YVTrx3uihmqieBzwfFY0UBChemx8n0OqJSMd94B4tLewsAaEj95OZJpIhA2
 wO9VNRG+jj99AGq5ivSzV5azIX6hf+r3scacb/vH166qwZX7ZEF150pBr3lyGZ/k9YYk=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNhut-000000000BF-1MZK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:37:00 +0000
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8a05da1cc1fso911926b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 18:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793587014; x=1794191814; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HEEAk/Q46YxnwTmxNKxdH+qih83wDE1j0UFvCl3PWms=;
 b=DqliH2G0acb4y+AuCknkss0ur5UzisoluawjDi3MxLcWJCX7pG0GAzpWo90G3XqclL
 2DJrpTV2put6OzbtV4vtU9HfQq1WdfgxWE4ap1d2jCUfF/SdMHHBvcsc4t3Ndf1ZCrIH
 +B+Sa8ulCNyNaRKSHBWqA0gnEV/4JlLzVfsA8ap6RIwDa8l9rEZhYxMoDfHgIi9kMGro
 Toab7/ZFh/DFL4LCivFqldCeBsdWoMDY7hFMEPN4DaGUgKDf0kp2md0cILaa94bSYpHm
 nAY/S+Y0RJPB3m4GXHGEWTHff5kbFAmV7PaI2XqfKUezgYkzEYeCLGFbipouMKAFKv5i
 60Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793587014; x=1794191814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HEEAk/Q46YxnwTmxNKxdH+qih83wDE1j0UFvCl3PWms=;
 b=t8/MNjekBcb73O7DOJGHrnzZZREaGeJkaTQ0SvUkgbI1sAUR8gUiZGn/sEmTZQTvbQ
 nOenA2Yq5VuOBTmwn9DobpPOkcsp7efX/R4v0HkKwHvLdzcmPWiqlvaYWl+Q/2bWKf6Z
 8IIXZ7VmIlMOLQFL016luhevLE2HhSuScX2k4ohz4IPSEFOO4bXR6zfOIfns7WZKn4Ek
 Rmm8ggdlukOiJdM5/3ZuFuJDireJxK/nmQ0ipHdZb1NMrC2ccu2ZXweQPgGrD/4qm0ys
 uwyiE6Be7qLWX/JffOPqeGnHstt1kjF+bj7M1OHoloJzZqD3EBmFbn4XpmHJXJV96N0u
 OxAg==
X-Forwarded-Encrypted: i=1;
 AKwUvByoBnbGQADJ7wEknRlwwYKoxhgxRlKVDHY4ofP4pQdUfSB1uFj2V1+ctiWviOK+Q/8gc8Bwazf9AFWZJ6vO83zv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Ku+mPn/7FRFYsi/TEUGkRp6ZqT5J7LR3v9fdjPTzRFngm3g6a
 JXMiwDqRG/fUp9Rt0qD8lYDyx2L9fzAdIrwCPbB8XJi4KhbE3YKX0q60
X-Gm-Gg: AYBFou2kf5CAX6aEK3+zOestQNXF97bo7V6JmddTog7Y5cB4tM0kCZ1H96bRk6U0xLd
 gXPKbJAFgwQflb7i7SyJmWwoyCq3HIKgpnVsVWE0Bpot4jl2zK+21d4sPRFInWQm9Uubf6zj1+u
 i0C6cWZjIy9eOU8KkmjfLJJE0uQAkkMoZl429xswpS/mfaiKgzisANQtBcC7I1yyq4918z1seFP
 UvHGWw81gw/rh8nXzy+8q+rAroaAPUv81GnW6H5CSPbdGbAPEPTMnnIsvdghuB1uAZwD9RqY3s9
 swLu94mr/zQ0QBqvx6k7MIrZLQaG9daq6yBfqYkjfy/BOiCP/D7ZwIVNYK+d9vw42kn3Hc8Tl1V
 IiWeFpiQiBFRhvwdm/jhBqQRhJ0u+oRzn8nzsKMYPnCD91rET74ORUzviVXgjl6vI7qBB4hUeTO
 BfATNQS4nxToewS6kajZXXDd/bM9Pepge1NO5LvCTstW/6mVgafSE4uGljWbig4A6bqFWCoyfTX
 1SmkEd3RC/NgC/vQ8UQPDtFlJj+xEZLQk09QFyBemtPTeSXyap5gzAeNjVYC8ath97cTAI4xy4u
 yLr8kgiKvE/ioOcxz1VkDWViWVwyTFqV5ZO9jfBQrDXr7w==
X-Received: by 2002:a05:6a00:2389:b0:880:74b9:dcfc with SMTP id
 d2e1a72fcca58-8a9bddc4237mr7323388b3a.16.1793587013513; 
 Sun, 01 Nov 2026 18:36:53 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8addc705868sm167812b3a.35.2026.11.01.18.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 18:36:53 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  2 Nov 2026 10:36:46 +0800
Message-ID: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNhut-000000000BF-1MZK
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: fix use-after-free of quota file
 names on failed remount
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
Reviewed-by: Chao Yu <chao@kernel.org>
---
v2: Added Chao's Reviewed-by.

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
