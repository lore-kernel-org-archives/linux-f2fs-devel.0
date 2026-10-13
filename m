Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5C5CC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9KYUKMubSjp3bonZfZ/tQD/nmQ82ZRYuZXxb8kBiQQg=; b=gVjGxzQ8ser63wfkGvHh6E0dzU
	o5Us2oKiSYmB8YJWi6C2QuOAIKy7P2rCsXKIftA+yGEDcZiC0luPB6EIdmNYpxT8OYUOwNrp9RrKo
	nICZ87aUkh1S10kl1AhCBwEtFvHn89PCGDceYlrGT2DLd5d6q4s7Mwq5vLjCaP42ZkOw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb7b-0000d1-Qp;
	Tue, 13 Oct 2026 11:56:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb7Z-0000cr-2u
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aDr2CmceL3ca2fswvyyunUdCe7sbFULSntXyt994J+0=; b=a9TlEzN7MFPGAfNB/o69tVft1w
 0TO1TLKW3XgYV9VxkNoO2rVKKMSBo+ym5AoaD/XybFV0gd2PdoJJPiv9wkLxOzyMVfRSNLbc29WEj
 f0/WzOd5tDU+74X3Y0WkJjGGXFQG9eOLYjk6MAXZQjl2XD6thU/OB7gpX00p8Y0EWBk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aDr2CmceL3ca2fswvyyunUdCe7sbFULSntXyt994J+0=; b=Sm9qC2WMfdOZMm3yMHtsWZFulJ
 Flkl16r+atfNImuXKtggEU9N4eM8L1TTNByQtGOvyRKJOAthGa5tuIjpc8V0q0gqniCRfBCe3sKQw
 lBe8GiEerpQoDxvaiBtpCFoqfK092J8lVafyw/t3rQSgscB5TIZrwVcFTV0mJ5nrtz/8=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb7Z-0005Q1-7Z for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:56:41 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-398a0a87595so1464734a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892595; x=1792497395; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aDr2CmceL3ca2fswvyyunUdCe7sbFULSntXyt994J+0=;
 b=PspO6qU7SjKEn1fOHgTU5oNuqm5C1yqvswHo8PBG8fNRYM6toaKfWJRY39Mm0ZmdI5
 hevHMfX2aWoflTX/KF5eg5QMK16CnJUi4qmWi8y9cYIAJSpYbmObq8gFebPJPBSwdxaM
 kQ0YM1EW1zIzbtF+ro2dCo8mO0U07y9TMZTwWLfOORNXC/+PRDc7tYlt6IhdIjrqmxtm
 OPyZmlmgdc5yyDTmnNHfD+Owg0jZl70GIKrBrfk31cBtOClKJ+kRm8dyHGj0udl/l0sm
 y3PV8cqbZVS9UhqlVW/Hc6VgaY2G9baznGo9zP9Ef2WwPB1k7ox2t6X3+8hGVqZcCGvJ
 nxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892595; x=1792497395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aDr2CmceL3ca2fswvyyunUdCe7sbFULSntXyt994J+0=;
 b=lGKy1NGgvJtIzV+zOuDcyB/wL/eRPbmhMPtW2A2iEEYAoRQFt9zV18Q0kJQ5KCfYNn
 Xfihd7VXkks81z+TNGBx0GN3uT9UQrXc8g5N4UCbedkkoHOhjIRGIwu33zFOK1ObuhVn
 QgcdqKHt8RuzeKz+jTVSwTaFmlHWGncwyvgyg6PssBSdq78ACygu8D3nHhU1L4yXb+pn
 gqobwEFOizrhoe0q4nCqvgqpR3kB7PpY/A0WgtLyEtnol5nVhf+LNs5Uas+e5umWlhNG
 1pwtzXscvViwQ4M9DV3PuL2ZleOZeJwZbS2gjLlX7DhE79/iOPJs9F3pj+QaQeU3Tybf
 wWgg==
X-Gm-Message-State: AFq9FYLSeAc2nAtmeDhbIoMqb8He/N4Skf/TALSE+FiBM24xgErIYC4/
 DpxX3brgXnSY7N0SHUR7p95JsAi9jNedqgKAG6aMd+cKgJyNgbpbO0xhKSBs8bkqB/DbuQ==
X-Gm-Gg: AYBFou327O2BrUevt+zbir7iVQBLaiA0sHDnriPHK2SiCO77/6PAwRsb5csClwbtqD1
 1Ig+3xfVSnepGDbORPxe49Hlq9XVFT/Nn2oYqr/rh81UvTqOkjz/DWBLK5aeuc67JX7QbIxyJox
 mQEWCuox8wN6WD3dcu7eLsmin3xpaOZXlhpPvoWC+/hadMxVTJs75ARkFL0afXYNW8a2XGMjFZw
 x+V1Tqlo6uD0VJhp08+3Df5Z1N3ITjlJOMmBzv2pjni1NZg6b9WIJqu0wF/bf4FCsFg4zNzuUMe
 OSyXekNRRAB1IcqyB3Ezly3C2pH/Exi8BaNfRsQjf+VOo2MGSzW0whJz0URqawO8/LZl8Wq8hLf
 Y6nou3bxnZnd6EuEwqz+FKUK6JvAOYRT2cgeSirou/aKfSAyYPc+gHkChRB8zku+Fzv0tO6XOV3
 RK7YV4ZTyxbf5BOSchwXrokOgRwGooJ36/oIy11462+GxUALnGh/o/kZX5ThH6MZr5ZN4pjLEqi
 RS7y1JCoiiDVOPRQ4mLZYo+j12F84veBd5p
X-Received: by 2002:a17:90b:3c8c:b0:3aa:6b5d:a018 with SMTP id
 98e67ed59e1d1-3ab3af94c34mr9681745a91.67.1791892595477; 
 Tue, 13 Oct 2026 04:56:35 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:56:35 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:04 +0800
Message-ID: <20261013115621.968742-2-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb7Z-0005Q1-7Z
Subject: [f2fs-dev] [PATCH v4 01/18] f2fs: read i_size once in
 f2fs_vm_page_mkwrite
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
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Sashiko <sashiko-bot@kernel.org>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

f2fs_vm_page_mkwrite() reads i_size twice: once to check whether the
folio is partially beyond EOF, and once to calculate the offset for
folio_zero_segment(). But a concurrent buffered write can extend isize
and cause the following race condition to corrupt data:

buffered write writes [0,3500)

CPU0 (write fault)                        CPU1 (buffered write)
 ----                                     ----
 f2fs_vm_page_mkwrite()
 folio_lock(folio)
 if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
 i_size_read(inode))
 /* i_size_read() = 3500 */
                                           write(fd, buf, 200, 4096)
                                           /* writes into page1, does not
                                              wait for folio lock */
                                           i_size_write(inode, 4296)
 offset = i_size_read(inode) & ~PAGE_MASK
 /* i_size_read() = 4296, offset = 200 */
 folio_zero_segment(folio, offset, folio_size(folio))
 /* valid data [200, 3500) is zeroed */

Fix this by reading i_size once and using the same value for both the
EOF check and the zeroing offset.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261012030315.978375-1-zhaonanzhe%40xiaomi.com
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ed1b944f8..fc959cdb9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -125,6 +125,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	loff_t isize;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -188,8 +189,14 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	folio_lock(folio);
+	/*
+	 * A concurrent buffered write can extend isize, so we store isize in a
+	 * local variable to let the zeroing offset match the EOF check below.
+	 */
+	isize = i_size_read(inode);
+
 	if (unlikely(folio->mapping != inode->i_mapping ||
-			folio_pos(folio) > i_size_read(inode) ||
+			folio_pos(folio) > isize ||
 			!folio_test_uptodate(folio))) {
 		folio_unlock(folio);
 		err = -EFAULT;
@@ -225,11 +232,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 
 	/* page is wholly or partially inside EOF */
-	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
-						i_size_read(inode)) {
+	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
 		loff_t offset;
 
-		offset = i_size_read(inode) & ~PAGE_MASK;
+		offset = isize & ~PAGE_MASK;
 		folio_zero_segment(folio, offset, folio_size(folio));
 	}
 	folio_mark_dirty(folio);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
