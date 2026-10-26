Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942BA606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VoHWipg3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UqQ1uZn+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OSVDUTsX;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YJdXq99q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=AQTMe8G1nfzTeaGPBxw4d8OGkcQaFKm7+xjwQBfIM4U=; b=VoHWipg3d6YEouBjuEUd4wTwQa
	Tx4G9Bc+Ryuz0aio4TpPGVIGQk+HdRm/xy731+xvePgfonhzWJpOiWKzEEf8DK9PQ153/oeIzMdPB
	3dxUG28weVh7Zlq8YcIV8ZJ3CqOPNkcjOWZsyUzDuVWGr40jlnVBVYGzKd+b6/dF7CHE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBYJ-000000007PO-1KzZ;
	Mon, 26 Oct 2026 03:39:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBYH-000000007PE-036C
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:39:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VwZz7glalGGPHoe9I+P1yNjh3ZtSHRE0EqtBFVnEPsk=; b=UqQ1uZn+7KMMtaVMuHExWuLo8A
 0jIOVZa2P8MtITFfGpcdq+xy4uU+BIUzLewE/bT3tHeve5lj8xwXd9IoNVGL8J/W7y9jPcP3KCBQj
 49LksJNiLTSTkIrhHV1g0zw12nwxvRV22hHrCdvwlPduAUTriRYZsZBeLxT+xasZoHSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VwZz7glalGGPHoe9I+P1yNjh3ZtSHRE0EqtBFVnEPsk=; b=OSVDUTsXelf9EuOHtpAJNd0WjI
 nK9kyGb0T1UHfy8QUudR5/lLOWmlAz0nu4qI9ArSok3b0uWHu1Uv9nhz7xr4YAV+0pCNw4p/tKRrS
 r1jYX6XzPCuDpZcEFdkucmj8C3XYubboWhRTD0mFP5a9ghi5jUppFPU6Y+v1vt5f3gVM=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBY2-000000000gp-39oY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:39:12 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3ad41dad3faso1711491a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985933; x=1793590733; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VwZz7glalGGPHoe9I+P1yNjh3ZtSHRE0EqtBFVnEPsk=;
 b=YJdXq99qGbKoTWRsy4agVlyP6hsX8NgLjhgiBq3HoQWmu+D0DwbbrGm5NzU87EDLIP
 cISK2gR5G3L3R/qZthMbSwxxc2NDWPk1O9emPPen5Ccyl6ws4g/s1UJE+AXsKiezwPpa
 xP30mR8rEwboNd9i72+2Bx84jlExYu+iys77POSSmQyuaL9+YoTFcDj+e+ZSzvpNhyCH
 rZHrlUfWggo57DPiI/yaa7QC6le19oLPX35ZLfJ4WiJHocoTOvd+4CrvUG6ubkzafkjG
 UGPzJfYTNcvYSS6TqNCmUcmTsiXwPCDeJwldVgmcI3yvnukhiDrZJ2rfyDZ/YJpsXZYJ
 jnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985933; x=1793590733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VwZz7glalGGPHoe9I+P1yNjh3ZtSHRE0EqtBFVnEPsk=;
 b=BrLh3L39jmE17NWk32vOuqvKe9xwLIeo/pSX4yQzOKpNeekWgDlziEpy+1cvV9l17J
 6kIY75qEwnvIUHlBp1Sq4qbwQuiFstG5meth+SovA5nNd5jwkg+bgVmGx527ceU6r0W8
 T9R+uhov0gPduyPNnYvrnBcZhIaC/OrN3s2P08Np0cgYgNhDiEkyFetUxHGsFXvvtoeX
 APSiT7LoiHmfpgloibadDr+Ki7Kt3mShbjwznBmSvfp4yO0zDdY2DqYS1wj9lPLT4JK8
 s4pMCOaOuT6fdgdQ6U6h3K/oejH1lbKPX63yCf8EopzE533OKB1njqas6nGxhu8o4Sx6
 rJ7w==
X-Gm-Message-State: AFq9FYJP75Tv3uZapjpwhMCqq8Hdgx2JSopxiJa/u/AU4XQbGSGWCSxc
 3o52N+qFWjUi/Ly2MUFAYyhKingPiwLFPecr98yKNG63X5TRPzcL/kIF21+BmQlYZnixVQ==
X-Gm-Gg: AYBFou1NmWQLYaTm2Dl8J+QBPqa1N/uih7Kcj+hvj8O1+3lkecefmlA7hQtPo/BRint
 alknLocNbDftWrzjtoTwA4LTu10dRpdXVFKUlQdz6oYBBoQQ/hhewngr2jZKPFqjAJvh8lQrdGD
 8bhORDMMyFCuTQBkWw4eHZJcV+g/HOGFl7HhWpz0bvPW+PExh6rBz1laukFZB/wj6LiQsIOPu1z
 6CwOZr7NzmeORi0b6u+iJODIdQ9GzxhzOqRkhgmr5NzkDRvvjbSxNATRtEt+vhYYdFIJq1glFde
 HPl8ibaAdb2NNP8HI4kdfg1goczmu8GFSyLrbzTCupo7AtNFR8LbkZ2K8Bkg/CBkYmMwBYqcTqz
 x3g1PCfQGjHuWL12GdzLA9965VcfG2tQPPoFX8zQKbZI8QerW2MFjrep3wdMVy7api/E5rLtKol
 igcsRQV73kaVXguTYg6FxHK2LOba1wJS1bsoqy9Zm3JXn6XnCI6r6b17xbNz61PIt2yX256MKxt
 qOHoLxPEB5Nt67gio1hWoqc2gJbVgqiODwC+oKQanf79GKkpIuRscXjM6bLtRSRT1eSPpBB4OcH
 mNf0TrUMuDzxArJbCA==
X-Received: by 2002:a17:90a:fc48:b0:3ad:50a2:9abf with SMTP id
 98e67ed59e1d1-3adeae88e5bmr4982306a91.38.1792985932904; 
 Sun, 25 Oct 2026 20:38:52 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:52 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:43 +0800
Message-ID: <20261026033745.784107-14-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBY2-000000000gp-39oY
Subject: [f2fs-dev] [PATCH v7 13/15] f2fs: handle block cloning within the
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
