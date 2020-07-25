Return-Path: <SRS0=ThHd=BE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5C4C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2020 02:23:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A19F206D8;
	Sat, 25 Jul 2020 02:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TBcQ9/yC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CS934olw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A19F206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jz9qc-0007ln-Fw; Sat, 25 Jul 2020 02:23:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack.qiu@huawei.com>) id 1jz9qa-0007lg-Km
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Jul 2020 02:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CukXd3KsjBugXgbDVaZL/IT58FlytFnvFWyMCirDFho=; b=TBcQ9/yC0adRUn4i2k/v7mSo1E
 L21fijLU4dKIAJqy14p7PE0hAo46aq/h2ht12w+HtbnR0bQq2C52bWr5QK15SCR+2nOWsq9drCDmk
 JODHbEyRl2UdZJLidzHeZS7/vOKgDBzdxiMeGr/PJQ7Kp93n9h9jl2R/DLvnODZous1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CukXd3KsjBugXgbDVaZL/IT58FlytFnvFWyMCirDFho=; b=C
 S934olwyFcOQTrGjkYJAQYj0a/A8qKaPfMNq1aMlFjAkE4p+CwEh41IXLWN+fzkqmOCdo2SIuec70
 p+KoDwOGWYWBX/RG2Ezfrzf8PPQ8DSk+k+Sqg2Cf3W2VL/rIGMG9Q5QNkfPKeeqxbwXJ5hl+Vg8sr
 B3WJdrXDH7TGy/d0=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jz9qY-00GVZm-FQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Jul 2020 02:23:36 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 016DB340FEBC5CD34DBA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2020 10:23:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:23:16 +0800
From: Jack Qiu <jack.qiu@huawei.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
Date: Sat, 25 Jul 2020 11:13:40 +0800
Message-ID: <20200725031340.21934-1-jack.qiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
X-Headers-End: 1jz9qY-00GVZm-FQ
Subject: [f2fs-dev] [PATCH] f2fs: use macro instead of f2fs verity version
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Because fsverity_descriptor_location.version is constant,
so use macro for better reading.

Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
---
 fs/f2fs/verity.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 865c9fb774fb..5be8a5790907 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -29,6 +29,8 @@
 #include "f2fs.h"
 #include "xattr.h"

+#define F2FS_VERIFY_VER	cpu_to_le32(1)
+
 static inline loff_t f2fs_verity_metadata_pos(const struct inode *inode)
 {
 	return round_up(inode->i_size, 65536);
@@ -152,7 +154,7 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
 	struct inode *inode = file_inode(filp);
 	u64 desc_pos = f2fs_verity_metadata_pos(inode) + merkle_tree_size;
 	struct fsverity_descriptor_location dloc = {
-		.version = cpu_to_le32(1),
+		.version = F2FS_VERIFY_VER,
 		.size = cpu_to_le32(desc_size),
 		.pos = cpu_to_le64(desc_pos),
 	};
@@ -199,7 +201,7 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 			    F2FS_XATTR_NAME_VERITY, &dloc, sizeof(dloc), NULL);
 	if (res < 0 && res != -ERANGE)
 		return res;
-	if (res != sizeof(dloc) || dloc.version != cpu_to_le32(1)) {
+	if (res != sizeof(dloc) || dloc.version != F2FS_VERIFY_VER) {
 		f2fs_warn(F2FS_I_SB(inode), "unknown verity xattr format");
 		return -EINVAL;
 	}
--
2.17.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
