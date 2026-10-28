Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553F60A5BE0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aghzYObs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ebr8+hLH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WDZz0WeB;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q4eCtmRM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=iv9Uf8Al8hUUrAq/v7AJa073S7fVcrlI0IUsOEUmH7A=; b=aghzYObstac/4CYxr9wMb9UNFx
	1NrCxWWFQIjQHsVaeF/JOEIV4QXB5K2o5wkwNf3WypgvnGc1RUwTSltoyXoVy3uGUo/QNvdjo1MyA
	s35+D6FmgSE7r0IHjWQ8UIpc1i3xUxmlDIQnZ81vqJlp0KV5TSXGHw8WF13W2WrGUtPY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5qI-000000006sz-3pOp;
	Wed, 28 Oct 2026 15:45:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5qI-000000006st-1j1M
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f2OVkf7r4Gjj14HyDJ+Wb2+gjwnUw4k6yJIrssGj6sM=; b=Ebr8+hLHFmMp1WBdmPSlycc1mr
 7mCf54srvb30cAoD/xWP2RuBHdcjmanmoIuGcjZotKaF4Bq3EB6yHqYXM2qIGMCtrZURZ3shwi2Md
 VxPCvINKP0cRajVFVcBf1Hjc0QE+B5LM0O8nvDkfS7Od5WnVHN5PKNo0dHCVXz2AraR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f2OVkf7r4Gjj14HyDJ+Wb2+gjwnUw4k6yJIrssGj6sM=; b=WDZz0WeByviMK/XmF4hzjjGUcZ
 ycA3PPLIPjn50fsqDDz4ajQ9pPg+wuVUaZzUDOdYdeT3eCy4KbWmqVXbjYx1xjJLXpsWMAxLhRcRW
 iakKjGaPR8gMhE7XAImVZbTLrJsSwXCjms3sF0D2B9LeNQg2iCrDTZDwwgnGUSjT7p/Q=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5qC-000000002OL-1Gtg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:34 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 d9443c01a7336-2e96be2196bso3398705ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202322; x=1793807122; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f2OVkf7r4Gjj14HyDJ+Wb2+gjwnUw4k6yJIrssGj6sM=;
 b=Q4eCtmRMPCA5YM99lFVT+EUKPALD+KrF4K3qmxOYsITDmSIEDsODV7n55pw9+18Vcm
 Jao2QJybzcarIRiiYS7VBApZFjHs2rfjPVYhKgjlNuM+Bx1FxCs2wObMRPkH15J8QZjD
 7T+ITG0oUw8178iRLxXhllgtsMUP4Nojl8/m+ErTMYzKF5/q3frrvqaNDS8HmdWkFQd4
 GjCd4pzrg8WFA5IdBAh0T3LlUPHe26cs+vVPtdYYlqLhTd8MrwDDZZFyRWTcA9bMOlT3
 RGIAScue/UXzcrkItXkjcwVjPVDa5h0ahwJoOLvk1Ykwq/qjWpRwz/sVW4oTWaz5Gyem
 LxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202322; x=1793807122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f2OVkf7r4Gjj14HyDJ+Wb2+gjwnUw4k6yJIrssGj6sM=;
 b=ygiNrEI68xm4c/J13fnrRW4Bp3QblDFUeqGWym87GujMIpACaJocSVHZGiOj4/0kUq
 r4VYon8c+z0xO86K0n2JYSddZ6Se+D4H9hue7w9Bgk8+xHfnETQNkOFrUEqEeWHquqPO
 G5YoRIvjat9+/jBv7aTFO6L8G2QPQNM9GOvlyjoHtq0PRV32uGf29Ulw59CVgD3oW3Kr
 KDMGh1TAQFeZs7POYkJRngtw06nZjTME3FP4sB+a2qFrEIU63Wt6bAX3oVUs+r8mhKfk
 5uoAJaV9CmNTd/EkhsHPf2pH9QdPZwjC6LQrRLd9SiPLBqhbiLmSStNTGfboRtuRFRpf
 TADQ==
X-Gm-Message-State: AFq9FYL0OpORnjBBvKxpO5zZw8TZisCcIyHmBdCfz/+cCq1RqyiaixB7
 9TsX2HYV/LuatA82pxx9swilD3oikQJhwCwuZvft4PwzpIxGjeusrtTIHqum+9OLGNo=
X-Gm-Gg: AYBFou2/Dof29Aq+9dGHaaH9Dovo1AYmnSmMWnHUIe0+zsM3a9+h9CQVQyXmbGt+eAX
 FFMP7vqxGoc3E3SGUyRB5k7bQkb+EkgJQ+EAfh/PtVtDdxbRJm+93ZUU5kwbITRENWQJJiCZPCw
 EWjXwK4FNX/xReb/aKoZ8+XQxlbbNaYYuVUsWe8F3yiy+ZA8mntjtXjcn8gVINIm6fl2hUJyVTF
 by4kbm4pN9BWbuKx5Nr/JqMV7FfUVEJMM6Nzpx4LuqpQ768dICHeuMf93ReoCLjQqTHzX33Wtn5
 0Pi9daf6kkOHC8o+gNRmfw2v/R0ouo86YuvUUyUxC3WfiyPrfGbbP8s+os8pvtgti8YiZWseZPY
 Qh1ClFoFmwq6CJBRABgkfPvcCn6OzXzScUqkkPLOvm06jbSzwia/1jN8JlX0ysyM6PC1Y/lk/rH
 tk9JjV1/7ci6Wwg3NMrTRQvtKrk26ndHJnVWOpNj+ODA8vFyLoyHgMjQhXmL8lu5R376vh9D6fD
 Og1xKPEbiLp/5QBi1h/RIH3Z26bkqITZFQIDvvfL/vLroV8I3Ub5Tqa51lWZa1vbE7wIz7zXyYQ
 1oIndvouaTYGRPnbQuhv0c9qZhqKV8apH6TJx947FlbfwVmiEqhakSBiGy9b9GQwXfs=
X-Received: by 2002:a17:903:22d1:b0:2e2:d989:c273 with SMTP id
 d9443c01a7336-2eb005375fcmr23232635ad.53.1793202322376; 
 Wed, 28 Oct 2026 08:45:22 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:45:21 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:44:04 +0800
Message-ID: <20261028154407.1601430-14-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5qC-000000002OL-1Gtg
Subject: [f2fs-dev] [PATCH v8 13/15] f2fs: handle block cloning within the
 same large folio
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

With large folios, the source and destination block in __clone_blkaddrs()
can belong to the same folio during same-inode operations such as
collapse range and insert range.

In that case, locking the source folio and then looking up the
destination folio can try to lock the same folio again.  It also copies
from and to offset 0, which is only correct for order-0 folios.

Detect the same-inode, same-folio case before looking up the destination
folio.  Then in this case,we reserve the destination block explicitly.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/file.c | 61 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 36258d401818..8360ac4317f3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1611,25 +1611,70 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			f2fs_put_dnode(&dn);
 		} else {
 			struct folio *fsrc, *fdst;
+			size_t src_off, dst_off;
+			bool same_folio;
 
 			fsrc = f2fs_get_lock_data_folio(src_inode,
 							src + i, true);
 			if (IS_ERR(fsrc))
 				return PTR_ERR(fsrc);
-			fdst = f2fs_get_new_data_folio(dst_inode, NULL, dst + i,
-								true);
-			if (IS_ERR(fdst)) {
-				f2fs_folio_put(fsrc, true);
-				return PTR_ERR(fdst);
+
+			src_off = offset_in_folio(fsrc,
+						(loff_t)(src + i) << PAGE_SHIFT);
+
+			/*
+			 * For same-inode operations (collapse/insert), src and
+			 * dst may fall within the same large folio. Detect this
+			 * to avoid self-deadlock on folio lock.
+			 */
+			same_folio = src_inode == dst_inode &&
+				     folio_contains(fsrc, dst + i);
+			if (same_folio) {
+				struct dnode_of_data dn;
+
+				/* Reserve block for dst before copying */
+				set_new_dnode(&dn, dst_inode, NULL, NULL, 0);
+				ret = f2fs_reserve_block(&dn, dst + i);
+				if (ret) {
+					f2fs_folio_put(fsrc, true);
+					return ret;
+				}
+				fdst = fsrc;
+			} else {
+				fdst = f2fs_get_new_data_folio(dst_inode, NULL,
+							      dst + i, true);
+				if (IS_ERR(fdst)) {
+					f2fs_folio_put(fsrc, true);
+					return PTR_ERR(fdst);
+				}
 			}
 
+			dst_off = offset_in_folio(fdst,
+					(loff_t)(dst + i) << PAGE_SHIFT);
 			f2fs_folio_wait_writeback(fdst, true, true);
-
-			memcpy_folio(fdst, 0, fsrc, 0, PAGE_SIZE);
+			memcpy_folio(fdst, dst_off, fsrc, src_off,
+				    PAGE_SIZE);
+			if (folio_test_large(fdst)) {
+				if (!f2fs_ffs_find_or_alloc(fdst)) {
+					f2fs_folio_put(fdst, true);
+					if (!same_folio)
+						f2fs_folio_put(fsrc, true);
+					return -ENOMEM;
+				}
+				f2fs_ffs_mark_subrange_uptodate(fdst,
+							dst_off, PAGE_SIZE);
+				f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
+							    PAGE_SIZE);
+			}
 			folio_mark_dirty(fdst);
+			if (same_folio && i_size_read(dst_inode) <
+			    ((loff_t)(dst + i + 1) << PAGE_SHIFT))
+				f2fs_i_size_write(dst_inode,
+					((loff_t)(dst + i + 1) << PAGE_SHIFT));
 			folio_set_f2fs_gcing(fdst);
 			f2fs_folio_put(fdst, true);
-			f2fs_folio_put(fsrc, true);
+			if (!same_folio)
+				f2fs_folio_put(fsrc, true);
 
 			ret = f2fs_truncate_hole(src_inode,
 						src + i, src + i + 1);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
