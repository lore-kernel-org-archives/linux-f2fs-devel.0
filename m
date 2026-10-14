Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBFBCC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m4ALXN6yUfNzSimprr4njSVxEdRoq+jpSERDSigPuvQ=; b=XwZ9yvToCGRKGqaTA+nEL3ZQiH
	uBAvAev4h1vkLV0W97TE8eG0gv3M2cyg+v/ZK/ejGBwcCD3z6NhiLGHCUfSccIHJEMuEqMCdTSUcX
	39d/WLoM7MtX6AjIE3z5Dn963HV/SDZE4E0mLo58VGU6kKxoEyt8n5DDt2gFYpwLAjN0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH0o7-0003UJ-VA;
	Wed, 14 Oct 2026 15:22:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xH0ng-0003Tl-Nn
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=03Sv77pdv2enIYJcIXZDBzD47e3X9YUsV2CCINJLlls=; b=D8rOrYxq/v0V3P/gBTi8OaLUGm
 n3P6WORtOBID7mErD1zvoBV8soRV+Axg4vOnrDK2/dUPMi/m/luCTWGTNSw6NtGIhDYJRvND9qI81
 xywR3YPFXozLdaHMviRzSLtk6vZoXgub+12idgVYzSLQ/SPOfQFf8ihrYhBmFkIHmaIw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=03Sv77pdv2enIYJcIXZDBzD47e3X9YUsV2CCINJLlls=; b=m
 LhgQXD+C4ZufYzLHQySSD9KopJAZwPxQnexZ4NhaoWu3CobIlxnmS8NBrZBAqpIT1wwnoA3hcaThp
 eppRtDePM/kZv332IkRlPn7nF8TXB8AQbVQ5kgUnLOTVogDZ554lWs3GQFIt9FYS94TKKaoqnn45P
 lgI+a2SjzRr1UStc=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xH0ne-0002E9-3g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:21:52 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc50ad2d650so3281833a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791991304; x=1792596104; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=03Sv77pdv2enIYJcIXZDBzD47e3X9YUsV2CCINJLlls=;
 b=Y7P/AjT9r0A8hq5NZHs2NEuqGUsXyR5/PeTwA6qTg5TITJGDyqQ3W9DuPospydvEiS
 ldCABy0r2YtzqAfwHoFGUNy0AtMXSTTN6h05ohOHfXABjDZyrZAH0rOOPbouoiMp+yjv
 quUaPAYcBb+w+LMIqtacQErkttOyYkpeNXmCJaOOOqF62yLgcSK57bKtXnKKCkgPcpvd
 dMvi0R7fJ5m2euxrxfMDIwKUanHQ8g0xfXpb8sBhY+vcYpjCtNjcDgAI7NQg3hYKWLk8
 1DjjzPqj/65T3Won5ogFrDQIZhaetqZMU33K9GjyCWK5fgz1X7g6XMJU9ulNf2UMD6hn
 h4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791991304; x=1792596104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=03Sv77pdv2enIYJcIXZDBzD47e3X9YUsV2CCINJLlls=;
 b=YBz9rQQlmQzi0JT7nN8AyCcaFvdyIsrupRWaB5ZgHNf75zPbF/nUIv9E9Wqjmqj1pO
 3TdfeE+6VMhx/ip4cgj6J086rMxjojEGPJd2ib4kN1wmXyUv9FUfc8aeszLUQ1VMul9C
 XoQiiqqhtpgRl00E7xsW9yAydQZtF8aoHmpZW/ERJhmtNmfhhgmhDJ+mUEQeOxMiU4jz
 u3fzUMXmVfi6TU7k1D/iEejfNNwYJdf4tiLfK5Z0rTbVIec2UEGRh8uk2v/oF8hT99kb
 4Bwk12MQX5k2j7nqMytSdpflZGwEwl6aU0n649c68S2KMS0wEJvetjoDDxpxiefVpA5r
 jMVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzoU0Vo9XuIQhw8qa53/maDQ4FxbMADN4hVU0f6HGVDzTptqTa/XzpaDQlxmQh6E0/QZfFPJrsIVu4Cv+o+6rq@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL/5kr206Tb1W9caP2Mz3nLnBnhPpskcfZOkcNJpv2nB3thvhW5
 fzJakz+gJnIGAQbJ5I/XTlDYq+JQKpJQ6lkXm1BelDg+WWpMOvxEGm71
X-Gm-Gg: AYBFou0uh2NGoCjcIQvcf6cXxgTUs0DwgkKNFl9pKdWlNNZgBNAhzFccmeQmt2xbBIp
 MFys6cSywDbAoyazAxOrQcRj7ZV18PvGsTAeyAzuFHyIXRkDJStFqG3XE52CQEsCkdQKlJJrNqf
 DhOrXVKro3ibld7ca/G3vzVkcWH8nK/lmGKH3C/JjtrAPOdUh2aJBSig0TCYVo4M+HXbg8oGtck
 7FN7ypPhsmEHhfcEy+3JFko9P38jCdesX3JaGyoEQmkgQr0eQAdnh/oQGOLzqqPqgbp/gcI7cn5
 lKg7XVdVYP/ROejFWJMJXcuIstlXzx4e7tLOxXEwu0l8qMfxCymiRsc1xzeSycr0oTTT8+Mb8zH
 xWIg2peTSktfwiCMdK1T/8fY79gUebXtTAUJkKGeNeklj92+S/qOTnExC+5LVizAQKwVHVvlqRP
 P5MfNlKdc/fk+A8jx1t/UDCYE+jIjz67oIzXelY8jf+07+fNzKX0JrXpFc3v5lABPj3CJjlM15t
 y5v1yo2G1T5wPmQoJM4VenPzjLXsl2V6GZ2ocqVNPFEToBuSkUybds6Rk+YBINqIYm2EbpG6Wh/
 4Iyg2UQZG2wJYvQ=
X-Received: by 2002:a05:6a20:8f29:b0:3e0:2b03:4008 with SMTP id
 adf61e73a8af0-3e16bd8348cmr13712804637.12.1791991304125; 
 Wed, 14 Oct 2026 08:21:44 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9d49af2sm6732967a12.2.2026.10.14.08.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 08:21:43 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed, 14 Oct 2026 15:21:38 +0000
Message-ID: <20261014152138.138281-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xH0ne-0002E9-3g
Subject: [f2fs-dev] [PATCH] f2fs: expose resizable_tail feature via sysfs
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Userspace has no way to know whether the kernel supports the
resizable_tail_secno mount option before mounting. Passing it to a
kernel without the support fails the mount with -EINVAL, and checking
/sys/fs/f2fs/<disk>/pinned_area_max_secno requires an f2fs instance
to be mounted already.

Export /sys/fs/f2fs/features/resizable_tail so that userspace can check
the support before formatting or mounting a filesystem that relies on
resizable_tail_secno, e.g. a filesystem whose tail is going to be shrunk
online later.

Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 fs/f2fs/sysfs.c                         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index c4746c416ac..8df18b5d479 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -271,7 +271,7 @@ Description:	Shows all enabled kernel features.
 		inode_crtime, lost_found, verity, sb_checksum,
 		casefold, readonly, compression, test_dummy_encryption_v2,
 		atomic_write, pin_file, encrypted_casefold, linear_lookup,
-		fserror.
+		fserror, resizable_tail.
 
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9749da70089..8b844a8b0bf 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1421,6 +1421,7 @@ F2FS_FEATURE_RO_ATTR(linear_lookup);
 #endif
 F2FS_FEATURE_RO_ATTR(packed_ssa);
 F2FS_FEATURE_RO_ATTR(fserror);
+F2FS_FEATURE_RO_ATTR(resizable_tail);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1592,6 +1593,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #endif
 	BASE_ATTR_LIST(packed_ssa),
 	BASE_ATTR_LIST(fserror),
+	BASE_ATTR_LIST(resizable_tail),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
-- 
2.56.0.385.gd3acb90ef8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
