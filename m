Return-Path: <SRS0=BlV7=EI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F2DC00A89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:37:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E37920870
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MEKeESUa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CypFK+Pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E37920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kZWHV-0001Ox-Ph; Mon, 02 Nov 2020 09:37:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kZWHU-0001Ol-Gi
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Nov 2020 09:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3lM/ZACqOWn22foPZ50T2eFxh6n4sh8EWmhPxsYN588=; b=MEKeESUa+6YYq6PIXhRUPLcEgZ
 hm8Z0DOK5o8I6uAk3d8pHWH5AAgaSjAwrZX0pInRmY54gIAHtpQP11r7VNE/r0+iTFGEtfJHWS+IM
 VByc2uWLleLkFK3lDB7D33drzz0xR/SAosa0+iWJa+TjnSGQr+14RzldDjtayTvc5hkE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3lM/ZACqOWn22foPZ50T2eFxh6n4sh8EWmhPxsYN588=; b=C
 ypFK+Pzt12ae8WGkRFqFd+ECGDWXmUGSrEJXryhHb2KaIJrEHF/+IBMeVpL9GivzDbBYrbM9II2pd
 3WIVNA3oSSOIng6pr5VQ36TZFTsWqJ4d2KR1j+hLQ19BN7LecOavCC4Gvrz2U+emuLKt8qDwEv7uy
 4r2E8AFvIG2lnhGc=;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kZWHI-00GAFp-3n
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Nov 2020 09:37:40 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CPnrG0cfZzhf8M;
 Mon,  2 Nov 2020 17:37:18 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 17:37:07 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 2 Nov 2020 17:36:58 +0800
Message-ID: <20201102093658.37206-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1kZWHI-00GAFp-3n
Subject: [f2fs-dev] [PATCH] f2fs: fix to seek incorrect data offset in
 inline data file
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As kitestramuort reported:

F2FS-fs (nvme0n1p4): access invalid blkaddr:1598541474
[   25.725898] ------------[ cut here ]------------
[   25.725903] WARNING: CPU: 6 PID: 2018 at f2fs_is_valid_blkaddr+0x23a/0x250
[   25.725923] Call Trace:
[   25.725927]  ? f2fs_llseek+0x204/0x620
[   25.725929]  ? ovl_copy_up_data+0x14f/0x200
[   25.725931]  ? ovl_copy_up_inode+0x174/0x1e0
[   25.725933]  ? ovl_copy_up_one+0xa22/0xdf0
[   25.725936]  ? ovl_copy_up_flags+0xa6/0xf0
[   25.725938]  ? ovl_aio_cleanup_handler+0xd0/0xd0
[   25.725939]  ? ovl_maybe_copy_up+0x86/0xa0
[   25.725941]  ? ovl_open+0x22/0x80
[   25.725943]  ? do_dentry_open+0x136/0x350
[   25.725945]  ? path_openat+0xb7e/0xf40
[   25.725947]  ? __check_sticky+0x40/0x40
[   25.725948]  ? do_filp_open+0x70/0x100
[   25.725950]  ? __check_sticky+0x40/0x40
[   25.725951]  ? __check_sticky+0x40/0x40
[   25.725953]  ? __x64_sys_openat+0x1db/0x2c0
[   25.725955]  ? do_syscall_64+0x2d/0x40
[   25.725957]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

llseek() reports invalid block address access, the root cause is if
file has inline data, f2fs_seek_block() will access inline data regard
as block address index in inode block, which should be wrong, fix it.

Reported-by: kitestramuort <kitestramuort@autistici.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d898f1e2764b..89c451f09344 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -413,9 +413,14 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 		goto fail;
 
 	/* handle inline data case */
-	if (f2fs_has_inline_data(inode) && whence == SEEK_HOLE) {
-		data_ofs = isize;
-		goto found;
+	if (f2fs_has_inline_data(inode)) {
+		if (whence == SEEK_HOLE) {
+			data_ofs = isize;
+			goto found;
+		} else if (whence == SEEK_DATA) {
+			data_ofs = offset;
+			goto found;
+		}
 	}
 
 	pgofs = (pgoff_t)(offset >> PAGE_SHIFT);
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
