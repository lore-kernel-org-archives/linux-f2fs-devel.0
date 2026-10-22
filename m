Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C227606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DfbL4CNj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jduJRFYz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OYMAAKYw;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iVtEkESg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=AQTMe8G1nfzTeaGPBxw4d8OGkcQaFKm7+xjwQBfIM4U=; b=DfbL4CNjXp7lr7gwSYsSenI5JD
	3U1yj+Q+LEgde99CUn5qC4jllWr/Jl3enmUsvETXU5F2E8VtgMwfGvN99Qyh6Rv9fkNOGHLUUeZxo
	oBpP/N/NU/McUqvpAaVqd316Nm/y/bdzYhIvq3lKq6JmSYq01hbpkLMmtAaZgXm4R/u0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndX-0000000078G-1GiO;
	Thu, 22 Oct 2026 07:54:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndV-00000000780-3sTD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VwZz7glalGGPHoe9I+P1yNjh3ZtSHRE0EqtBFVnEPsk=; b=jduJRFYzbm7yaN2MKjgmrknaKi
 H+/ONILq4l8hMAzq8m83WF6rlscaudXH+lFJUArGFgTDM5YLHa/niN+RCnelBjKBmNBYOdvmCa26b
 fGZH+gr+1UDcNiQ3xZkfX2F5EGw7WJRYJEvaeg7cfmcltplKCg+7oBdsNG9FrNIEXt3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VwZz7glalGGPHoe9I+P1yNjh3ZtSHRE0EqtBFVnEPsk=; b=OYMAAKYwIVe7yECZ2Rcxegw7Ms
 xlPdmBpGy9bVOzIiQJeQFukMPOF6T5hGAsOs/nnz4VcsZdLYyYDL5tGCNOmbRy+hHkrJ1300YEm2Q
 zNUX10tlwUE/5wGUVHXkBKqoim7yh32YgwJ6Zf1RZcox+rUqfSL+y4xD/e3qp9RUdXeM=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJndS-000000007pW-3jdi
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:53 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3abe4fb64d2so757486a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655685; x=1793260485; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VwZz7glalGGPHoe9I+P1yNjh3ZtSHRE0EqtBFVnEPsk=;
 b=iVtEkESgxGrFegIzfRZvwz85iR7zukjpFu1UewR2EkLtOvR7Fmn+6ZFYjB5hbkSE7J
 p8LVW0/tkSrEu1sykG2haFNcilVp7ivKuQSKITQPRvkLEm/+iYKd5gOR7cfeO/d7yKxS
 zcYp2Arfnep89zsI1CQ8lWioTidjCp3O8kiee9G7HQyvHowj48Bgx5ggcCFDhvtONA59
 1XXL422t1eZbXqzXEho8aY9xhsYERt9I3xvLCQI8gzIOGeEBYEg7clJClhln3SSJm+/p
 Lh1b/K/SIbEkZD98DQle/0g7hoH/cajTi+iDZNkFcgFqEbTryYSdn1nL6xwerasqM/Vg
 puuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655685; x=1793260485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VwZz7glalGGPHoe9I+P1yNjh3ZtSHRE0EqtBFVnEPsk=;
 b=xICIMSO+jX0Z4K/j2kD5p2sND+1SSi0kVudCLB2mEdGctkMrmROrOdgqDjImpLyx0e
 v80pOdW9IbEeTfTAayuJ3XrCXh6hp2X/Cc+R3tQAlfSDQyxpRraqeA5dSxc29h2brBB7
 9ORdJr919roSztZ2AJ0xltLi70kccTL12qYfkKGvl/Dq2rQ4jvH76fphjJUwSwUwpEkK
 uVkBO2SfvNR6nNOipZAIxDwv5cyYWFCspRdCGLMv6BE2u+RYCL5/GML11DBO9YVurk81
 BXaJy9B/Fq40oIg9tYTkxa6kl8g6F7PJBT5AViFYxR3smm9phOWwoAtM6QAXZbAH1mEy
 f6uQ==
X-Gm-Message-State: AFq9FYLzvUqFyNmD1WewEiKcF/29YOPw+uSr1aX3xR7QMAt0XYDAD/bb
 mkqpsgaTYYM2kIeCgr2HV91gWIA2XGJJuANMwMn/UZpMBW/EH3rlcw8Toq1XDfkw
X-Gm-Gg: AYBFou13T3h5Slo/tuC6iOnOPIKahRvcU1OjhAit+LV0wpAoTg4I8Pg6zXOuVzYmtw+
 RnOqnaxKPszfd50l1t3D+EZh/C2Q2Zo5UWKPclBaAC7FYEjMtce/iNzSlFjAbTzp8n8fvZklJ82
 l3n/NDZ9+KA3plLl2qm0FWKq1qstGKro4vK+zB2PLInda+SI55ElyNkTCIv5NoemZNG3SdDvV7O
 a/X7t9NSoKmlnKRdXdT40H8u2u+0e5Zz1oaI+T/3Ov5cwy1MaydPmlxTCaj9GS66zn49rdLQpww
 BW6JxEkOEybgxhaJ2RfLPuEuPMMaNzUj6drV6dYWuof/MAwqLABdoybJiGYoaYCJ9l+y9PrfDTr
 2YWofBsZnous3bT6NyfTTwiZfZMX62KNSpPhxBkSERGRUE52Ihym4CJSvhhZG1Zfq2fTTGstM2m
 ON1IqizOelqz3Zs9YHTnAvDS590YazNRpfGxamh8EIJ2rfVPxaknerh7wJp+tOWdd38U3tzEuY0
 UVmsfDrp4+G6O0+Knmq6Le/nycwpUGBJ9BvAjXa9L4+pWyxG8NGuVFI92Y4FdK8VAwBAc/AF5w0
 Zg2HAZg7zPc7WdkgT4a73UT/ju/iY3+OyYzqJB0=
X-Received: by 2002:a17:90b:3912:b0:3ac:adce:60b5 with SMTP id
 98e67ed59e1d1-3ad86e97f66mr3592978a91.14.1792655685189; 
 Thu, 22 Oct 2026 00:54:45 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:44 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:40 +0800
Message-ID: <20261022075343.3043003-14-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJndS-000000007pW-3jdi
Subject: [f2fs-dev] [PATCH v6 13/15] f2fs: handle block cloning within the
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
index 439e84a4aec3..f621d5e65023 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1598,25 +1598,70 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
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
