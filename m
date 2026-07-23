Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C50AC531CF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YZCR2fUkMBkQ+jqmDP73AEyNv091oBP68i1oOoX9XKM=; b=emKvWpcib2ovdRr4vwhyyGaYn5
	YpnCJEcYC4DnUmJtxRz9rILkM5lUxk83DbpFOsxS2HUDi8suqErUBmry3jP98zx1C7U7/A4PPS/LM
	gio7NYyjRw5buXPjOgmLPXEJvob4M531zUUGmt7M15ChsugDD071g0dV/Vq+Mh5kePys=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmtbU-0000Tf-2m;
	Thu, 23 Jul 2026 13:36:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wmtbJ-0000Ra-5w
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 13:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+R+5qfisK2HWKtqmw6UMptSC81Fa7UbtK9+Pm1I6XIw=; b=czmX6ZQSsqbN/XwmN0osCKhNDj
 ht4mUjN/cSuaSX/WV3ND6Ud9DKUU28TrneThcgL/tfibg6saDzi55ia01Ikf5yqBG5d9NKFQyGIF/
 G1U8769IILvb3tC7pIdbnRqjNMv5k1MtETtmF9lJrhHU3jVAxgCvwQU0zIxcC7AZJS8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+R+5qfisK2HWKtqmw6UMptSC81Fa7UbtK9+Pm1I6XIw=; b=Q
 E4AowVJiFAelShk0KX/0jA1Uaz3kZuS27amF+QE1wPn5ab692aUJT6RGnM9cZUApmZRSOioA4u0Gf
 HIDS2X5g1KODY1vQDZ9zjGJpLPRwIZM6BRcXZJMjQnBzbna8QBTMcbd4JI+OQr7h6NEO20uYdcVAT
 NVeAGAfwT4msoZrE=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmtbH-0004Dl-Fh for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 13:36:34 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38101f85591so411469a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784813786; x=1785418586; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+R+5qfisK2HWKtqmw6UMptSC81Fa7UbtK9+Pm1I6XIw=;
 b=VUWNqK3Sfb9C7H2OG2yUtRx1Efo99AsqCNuEqPO7YC8PSzeHF5JDvb1pRvxSqsxcfU
 gyJNu6HOqeMFHCrke6G/DG3XFjkJRqsoC1Q7eRWEMBLHFqKvk779nQqyMGW1PwPuoSuc
 ExVUjmo4DZWqA7FKQvzLXCqnC1+nfQtKY/3b7sj9BejuTkoLb/gVDIP0jL1HqvARaU/h
 6P8PWVlnlMFENfZfu4IzlCkmodckDN/tSct6rkMLgxBKXyOKPmJwunhxv388gsKMMY0i
 aSwPVDDaYadWwY+oowVs8SwgMrQLP/AwVyrdrEZtKVpATe/KyEDDz8pHtN+3JA08XvUT
 Z0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813786; x=1785418586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+R+5qfisK2HWKtqmw6UMptSC81Fa7UbtK9+Pm1I6XIw=;
 b=REwd2ZZIBaBI9yYMU5+g20rvmzyBJTMa5IztvB+UUXRhmYWONK7RrZBh/h9SyZcUTf
 R3B1K/XwsneIsM0kAVIy32nqqRnxX1SC0kjC2pRVnGBUhyn5+8gsVX3CB00OZQaA+BEI
 JAXpbgqR+qc5jSiq1dldm6z8Y66sXHUjfpk+pC6Cp6mrwTMcsqq/myqkawiFKVnNEtw1
 FWN8Nu3YOGll6wAy9/EyHGMkJwQuvvSLxft0iJi6mdztBKOys/GMNyUS4EixCkTuBYmU
 r1YgdeIdjUShkzsIEDt8Knq2z0CT8Ni/fW0Moo7nBsXtiJLilgjOPLAT6DSFRAadPec6
 6Gfw==
X-Gm-Message-State: AOJu0YyzkSI5Y5trDozsKD4SqKS7nPgMmDliTIm7xkn9GDBXtm/j7oB0
 mkp9XvR94uTEGNLFH5P3NTJuu/opa0bWj7nFLfcROvvzhQShUJToaf5uQM5SiQ==
X-Gm-Gg: AR+sD13GrCGeuHNrnNBWPCrpoa9w7B87baciK9pa1xIl6IK82aIczvqWoS24KfSfBY9
 rxD/VU+g3qjC/PjFM8FQ+6qCqnCYZFRCoVqs4pWAMyidKZ+92u8gmqD3lZDyKNMtYJGWujRInhl
 AFTX3sLci0YlE6R9u8aNLnQypEJ4V1hJiGdF0yv1Fx8xOLt7o+Hz15bKeXb9cQ4Z2QiMPam35ak
 3OKpbrqaaCjTi8RNA4qK3anKMZ3IWPwQCJeORjcXVBRguSseG8+bXSNu6GW4Fd1i3qjk+7uNPmx
 5FXf4rQAr1qMkixJPd1eMRsHJmtsKBiz2PK/n0RCS0oq5BUj7pQORKjnxASyYyBlPpU7t1CwneC
 mXnw01BQBX4xS7ypzD5HgPyYfSycV7ZV7X91n4g9XGQveN1v4dyh9DdfTUF0IZBMYAwiS1LmdiG
 i04q64SuciiZPoYZP/ki5xsq+9JnPyeEt6mv4h4Q==
X-Received: by 2002:a17:90b:2e46:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-38ec841fd7emr2462627a91.9.1784813786002; 
 Thu, 23 Jul 2026 06:36:26 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38ecaf51833sm1035279a91.15.2026.07.23.06.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:36:25 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 23 Jul 2026 21:36:17 +0800
Message-ID: <20260723133617.3841286-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wmtbH-0004Dl-Fh
Subject: [f2fs-dev] [PATCH] f2fs: keep pinned fallocate failures
 section-aligned
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
Cc: qwjhust@gmail.com, stable@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Pinned fallocate allocates one section at a time. If f2fs_map_blocks()
fails after allocating part of the current section, the error path still
adds the partial length to expanded and clears FADVISE_TRUNC_BIT. A failed
fallocate can then leave a pinned file with a non-section-aligned size.

Count only complete sections on failure and keep FADVISE_TRUNC_BIT set
until the failed section preallocation has been removed.

Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/file.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c54897a25981..83af73f3831e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1966,11 +1966,12 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
 		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_DIO);
-		file_dont_truncate(inode);
+		if (!err)
+			file_dont_truncate(inode);
 
 		f2fs_up_write(&sbi->pin_sem);
 
-		expanded += map.m_len;
+		expanded += err ? rounddown(map.m_len, sec_blks) : map.m_len;
 		sec_len -= map.m_len;
 		map.m_lblk += map.m_len;
 		if (!err && sec_len)
@@ -1986,7 +1987,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		pgoff_t last_off;
 
 		if (!expanded)
-			return err;
+			goto out;
 
 		last_off = pg_start + expanded - 1;
 
@@ -2004,6 +2005,16 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 			f2fs_i_size_write(inode, new_size);
 	}
 
+out:
+	if (err && f2fs_is_pinned_file(inode) && file_should_truncate(inode)) {
+		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		filemap_invalidate_lock(inode->i_mapping);
+		if (!f2fs_truncate(inode))
+			file_dont_truncate(inode);
+		filemap_invalidate_unlock(inode->i_mapping);
+		f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	}
+
 	return err;
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
