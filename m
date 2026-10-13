Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078EECA9ED2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7NH/m+KsuPivHv35CFxag5iIUcziJiwsfbKzIqVHicU=; b=ajLT663n8ZLgIPpNk3hofKWpkL
	qxVjw8ISzVzPma/HCFYN1N6kToxcFpkPvxijmA98h1qpDdqd5PuOor/j5ZORN0eAduJljUHdaxERN
	kpEd7WT5sH+Wjs3r8ZWWYDNuU+OvJlI6bHD6PvlnlSedPKmK0X1T680TW/5X3cPJ/dI8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8m-0000qM-6f;
	Tue, 13 Oct 2026 11:57:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8k-0000pz-Jh
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VMm5uZ7y0LHSAzCvhw/clyRGWUnnU0F0YFC56Cetspk=; b=fWygPtwZVZed1TV8XixiHM/fKR
 vUWqN7YeL+tCR8Nn0v5JgHCh600ZqxUFrSAdD2qUjthFURqGnWXHbeGagPlh8lrJaIWbXVxtkcNg0
 TEd0PO13U9JcD1I+ZcfjDinJulFZ7i17zMh+bZiJ+K09IZCCd2ttJylqBfvHLd5ukf4A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VMm5uZ7y0LHSAzCvhw/clyRGWUnnU0F0YFC56Cetspk=; b=YnR4OFiNvT6EwGM0e8+bgUAcng
 B0rBUmjTF2svOuRrIXB9Fh6pdGT1hTqB01+8St5u+lgoRM1Radv9WDJv3TpvLIqHjrzuxXGXBrFo6
 v7q7t/7WGcqnOKfGk/6nkeQJl66FMvO5qXf8aUv21ozvLV6W8AsezJb9yK94SYEyGLKM=;
Received: from mail-pj2-f4.google.com ([74.125.227.132])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8k-0001WN-26 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:55 +0000
Received: by mail-pj2-f4.google.com with SMTP id
 98e67ed59e1d1-3a84a12aa97so684193a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892668; x=1792497468; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VMm5uZ7y0LHSAzCvhw/clyRGWUnnU0F0YFC56Cetspk=;
 b=MWWYhHfUG6++CSxmUsi8gcBTok3uJEnKtGBAG+17S2oGDSqItjVgerGyh6Bs9zs5Q0
 PH5cJjuQ+UEfKACWB1Cc1lkmou8Rxsm/rfzP8o/yOGZ1c+M8Tdnq+ogWQ9DPtMBcAbv2
 HsyPciGd1JeVMvdyQSOI+Y6bNbu1X97Y0XMBmYqZ4uEtZV6sb0TVYupy1ppc9M04JdBv
 AVYgJM1cbch6RURgJ1yZlUyp+QdwVKX51xQgMG9hqE2tcQ8IHcktBtGbLJsncr2rXYmY
 DVYpXEUesBLOJGI7n4O7C1cJDs2x6Ln23ZF6qYu4KsG97unHF4VD3SfaQCTHBRpZTSDg
 INQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892668; x=1792497468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VMm5uZ7y0LHSAzCvhw/clyRGWUnnU0F0YFC56Cetspk=;
 b=bzvdHH3ag5F2pyjl8bDM5Y9Yx89q1f9tMr1DB5qRcIQbrxEdI+MUDV8sfonWEBZ0Vm
 mnDYR8d/W7x8GvpI7Pm3v2LFdJaXio0/J6MNK45QlJadFRAr53uAvFgpLjOfVNBAb0hL
 F9PFubdBJK2Auh254Hlx8cgUbryDBQU7cr+CxhmFEju3jREdUc78FJRmGYhP9w3vXlOF
 ZMYReJnt8xIWY2aGYXSEgLy0aY0n6UZ2y0A5XISJ7ZaDBJhdiWlIaV1WNv3nWGNFt1Lz
 eMnbRknJZdy+scgJBWWISJU0+XHjfTtaWGT4hlQCi3gTH0+yWUi7yKKZ0XPQm1x9WEHN
 dtEA==
X-Gm-Message-State: AFq9FYJiOa16OYKToAcLl9IjIi3YmxthWQZRxRM++fIxN0BCPirusvua
 T4x734faSKcq/gfgVWWmnUqst2M+Xd2byNLi7Cw8Ox9/hP4bzUZZHXK3elCmVk48
X-Gm-Gg: AYBFou0F3mSEyMpTslJ2rfjH+BhBWlgED4OaokxMHNfVGt326v3aLbmAcH9zLU9AFPO
 UrJhQ5l3BNN69q3nJjqIZt0l+56oH9Z2cFSv0D80T9MT8P7mN+C/O4YbaaZwFMjrOgc0CGWmKAR
 x8Mea40qxdXHvVP1XWl7nDw0NoVaXHcA3p+KoOnKkYUFtbxWOJ/cDz+a0gg742mV3ghyovZTrMR
 LQ82pYCuz59ZpJzYk7JQRBYTWKsEZY2pTh35UNYoyAmAvKhqc6nadV/yRxK2mYApudOTXtoSQUk
 a0+/iyDBf18I0cmVrFkzZOQkjcJZ5j+Ww2mHYwJuaFk7IvL2FkGY2yBSRozHsnhiIBZRQvvR1Pu
 KMnPyIq+/KlM3WzCifKxZ43LCdFGSNCxgW44MBkM2OdyVkFyQ4OfMBIBF7EXozTiRox5obUOjF4
 COSV7UeSpD1nb2RLOlbQqjV9B3ywyCWleXyH71eDlb5LCkOBuH4/f6YAUSV+nQ0KxZj8Uln8C5a
 zQa97RhJmdPJJxh2Aqqh5o3w/fI85EmTEWg
X-Received: by 2002:a17:90b:3912:b0:3a7:f64f:6473 with SMTP id
 98e67ed59e1d1-3ab3ac6e6camr10026572a91.50.1791892668362; 
 Tue, 13 Oct 2026 04:57:48 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:47 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:19 +0800
Message-ID: <20261013115621.968742-17-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8k-0001WN-26
Subject: [f2fs-dev] [PATCH v4 16/18] f2fs: handle block cloning within the
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
index 69d1344a5..3c90cd365 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1608,25 +1608,70 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
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
