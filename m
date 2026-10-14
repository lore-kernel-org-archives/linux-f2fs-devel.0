Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88B2CC6B25
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fcdaad0DV158/OKEghpDJ3pRrWz1/Yv4nuEBIHaSPp8=; b=GedCsFVxqJLaBg0a5uqE4KmhrW
	/R2odgY2qvnSoOfsfRuzEFW6FU4bN7sS9tOII8ZQDaQWZX/5NjC7vmArSKXT/tffV/otf3zkMYzue
	//b4VQYCBVgYSdWJvr9dHoqNmoG1R+qaNFVyh1vZ2kMSRDCpjAyY9puNq2NNVy03FHjs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGsks-0002qZ-2Y;
	Wed, 14 Oct 2026 06:46:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskr-0002qP-5P
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lGjExfS683CVJLhb5GgAjexS33mn62Ms7AjjoWD0t6Q=; b=PXotLjJ1/4LAUIb+Ok50pXnkB9
 W4HuIqcMcHbCMOzCLfGbroSAy1mf240dttZYPmMsijU7nriS+e4R5Iw5OjPkymrJGFOieB5JGeTe1
 A4D/iuo/9grxg4fkMJJfZKUOy3YNey+qPUKbK19MTPtRj8O7EeFiclQT47YoFFmy8lxo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lGjExfS683CVJLhb5GgAjexS33mn62Ms7AjjoWD0t6Q=; b=jDCA9+6bag5VPIsUY7EoErHNRY
 UcpsBnDRWzb4jnyAhGXg8QsotzsFy8DmvPwES+1Zkh7dTTmg5qdPmpOdKDsf6NrZ4fHF2L8UYKQpB
 0H+Hf+HwPljOy+mWbHitRI8phIkneznX+suvOBcEybxuqMv6HioUg1f+BK82r1kalSSQ=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGsko-000105-83 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:22 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3ac144119e4so1005736a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960376; x=1792565176; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lGjExfS683CVJLhb5GgAjexS33mn62Ms7AjjoWD0t6Q=;
 b=eqG1jIKPS/gQgFhkfFRrzQm+prdjHb+vKSf6vpxM2yVEOV/9u76+n4hXYxjsxistgZ
 6o4fHPojLIWBaX9azjwaVDQAq0jCls2guj0d+Ha+p31YloAzgBrmKqDPiwSLEI4pK05h
 tUydt2k2vKGB3JmkCQQmEFKE59GexBaUqf2fgT81wKqO9JzW6Y+BDjy7EYvarcQhHU7a
 zjxrZyWdc1os/gScBW8fcsLddZu5luWQhgQjxO213NIa5s7FHdhoW3Kdhi71gYjb4xZ+
 iURgrNOfNX7//2Sy7E4r3WGICBurg3/55t+6fpy4mBqpdEHjEmC3gulGUeLgGGBhjy+a
 bRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960376; x=1792565176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lGjExfS683CVJLhb5GgAjexS33mn62Ms7AjjoWD0t6Q=;
 b=fYmxhNxgJOQZDb8KLHLCDrMQ6HHwosKDwCAQRkVbe/fXt3sShhBE6hWM/LeD0xkq7K
 Nrip5rdedo/hfc9sclKjcyHrwtEj9UbRqwV9tc6mcpmFSh/4FG58NcPiuAhXK7CGSxKZ
 ofgmKKvbpJ2QR5oRRZvcHNhIxvmnth6rBmX6vTepZaauSefm+TQ/tNe1a12lrH/WEW2P
 VUuaR9zZbamoOfW0QAr1Vl9bgk7HGRpfw1fYCTlKePcbkbxmgRrqxgkt/F8qDuU7IjTu
 jML6wh9ONmSJMKcJyOC0BcmoXEQ24J7fhodRFuF3EK8PA1ORtHXtF3KYxOcQLnT2IlyL
 4aYA==
X-Gm-Message-State: AFq9FYLKlN0I6jSkjOtM9qzOPTYzAlLcgjHaiZUpYad+llaHxV6fAq7a
 V/G5e2UWsc/2/z0CmxhQh/O7yvTYjtpz4m2oPEpt9Y1AZPtVe4pznm5C13lM4SgQ
X-Gm-Gg: AYBFou3J38stI1pHLYppi6FLpINDOHMfD12nyKlQ4ueirfQYHtgpf/1QxAtC5LkmgGe
 SkSXLk1Lxs/OQ/ByEV4rrFKijOBH36e9aGq9r9KP54kT977LtYTA3BWEEEuv8EOvROPivCvB+4n
 J87u4fQ/lfGU6FvHDylYWlBiAQiUbytRLJ2fjUV371Sqh4p3LCe+SWEUAtr71wbUqqwc4vVnpSH
 0hiM/7wzKs29c5fY1fv0GAqyzuRpWcgRBr6t9SC/oyKTKBSNMqc9D4fuS54VktuV58HhDel9DdV
 A85oq9UTwenqH23/n0dUHXmrl81vd1KrLEm+6yas8rWltGuE/5lBH7cBNKGdSpssadXA7h7HteI
 qbW7mIIUeZH1Xf39KS2TP5xD8XGkDw8iLhKUr/87qWahJO4eHqOhA1321Zkxpa1v4uQCUeh/XV7
 FHxA/5K77Wh8+6dl+Yc0RR+FrGBQT7zbzhCInElbjrWpg9kmW011Nq42iifaICq4ZP6gvtBZxtW
 or7F7wZsuwnt+GhC7RHsDipArQRXrCWZdID
X-Received: by 2002:a17:90b:4d88:b0:3a4:a850:6982 with SMTP id
 98e67ed59e1d1-3ab3a7786e4mr13315343a91.26.1791960376536; 
 Tue, 13 Oct 2026 23:46:16 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:46:16 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:43 +0800
Message-ID: <20261014064445.2835813-15-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGsko-000105-83
Subject: [f2fs-dev] [PATCH v5 14/16] f2fs: handle block cloning within the
 same large folio
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

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
index 5a8dbe228fb1..cad5329bbfd6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1602,25 +1602,70 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
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
