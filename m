Return-Path: <SRS0=dov8=K7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A077C4743C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Jun 2021 00:32:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B942561208;
	Sat,  5 Jun 2021 00:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B942561208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lpKEk-0002B8-7z; Sat, 05 Jun 2021 00:32:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lpKEi-0002B0-GI
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 05 Jun 2021 00:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v0SMLYZYZzDWqCXbTH7Ubi9W+VEsvl6oW3XGCVOhLyw=; b=c1Wa/SW/+ZA71S4lHe/iP5hSl7
 KvotJLgORnIeVtJ9ggp7v126FT0iw3Z/AoVAcsNocY1M6OXVgFfvaBRmipYdLXKYE6aXLgUwMzhaT
 wh0+U6OajgssSNlOqHQv2+I6lezlOttQwYtpPICN1MRX8fNc3RRwViYeg4KBMDxOULUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v0SMLYZYZzDWqCXbTH7Ubi9W+VEsvl6oW3XGCVOhLyw=; b=A
 rL8VpuoU9ZNeCKzvFhrpbmWApcdDTCwvu/dB2nBiLG8z+/d6G5MAt1DmqBnWJEuGlvn1m7OJnl2t7
 PNeV/5rFLJB7RbJ4nEquGeT5cK9vHugzgJVzv7Vw8tSia21vy3qrTB3KPjeZs//YGyJBGzjWXYKg3
 Z71c6D8JrdVfHzj0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lpKEg-00B113-1M
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 05 Jun 2021 00:32:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B6A960E0B;
 Sat,  5 Jun 2021 00:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622853136;
 bh=QQjCmgNhjYN8qIse5O8UtgzjzvjCWJU6m8oNOld1b0o=;
 h=From:To:Cc:Subject:Date:From;
 b=ItiBj6oY3FQHUzpt3l47u8FOok3N6dwfaN72iBuFJ7Y7m6ForZPTcG2xiY8YUmfie
 ajqY9PmE7MBKIqs0z9Bli7mpPBSopNsLERbMwMJHywfutgHAGWmAHB3wx+k4wiTReF
 45kTACVs5ahw6I+h3ch04ayCRwS7g9Ij8Iz+spbZ3CFaZKz96EM/a9umz/B/SQXeS2
 WXRMuVQvztZRzKxWkuCQcAyCnYkJmY4ap+xFJeZHqZvZ719PcyqGKISskGpm238z8B
 OIm1U8hz7Ua/aXTHs1d4DI4U4HSsoJ8DG1T9j/8oFZYJFsVIk0y1qZOdMnxU/nv40e
 JZA6IEC80MjaA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri,  4 Jun 2021 17:32:08 -0700
Message-Id: <20210605003210.856458-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
X-Headers-End: 1lpKEg-00B113-1M
Subject: [f2fs-dev] [PATCH 1/3] f2fs: Advertise encrypted casefolding in
 sysfs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org,
 Daniel Rosenberg <drosen@google.com>, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daniel Rosenberg <drosen@google.com>

Older kernels don't support encryption with casefolding. This adds
the sysfs entry encrypted_casefold to show support for those combined
features. Support for this feature was originally added by
commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org # v5.11+
Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 62fbe4f20dd6..4daa6aeb200b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -583,6 +583,7 @@ enum feat_id {
 	FEAT_COMPRESSION,
 	FEAT_RO,
 	FEAT_TEST_DUMMY_ENCRYPTION_V2,
+	FEAT_ENCRYPTED_CASEFOLD,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -605,6 +606,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_COMPRESSION:
 	case FEAT_RO:
 	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
+	case FEAT_ENCRYPTED_CASEFOLD:
 		return sprintf(buf, "supported\n");
 	}
 	return 0;
@@ -709,7 +711,10 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
 F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2, FEAT_TEST_DUMMY_ENCRYPTION_V2);
+#ifdef CONFIG_UNICODE
+F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
 #endif
+#endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
 #endif
@@ -822,7 +827,10 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_FS_ENCRYPTION
 	ATTR_LIST(encryption),
 	ATTR_LIST(test_dummy_encryption_v2),
+#ifdef CONFIG_UNICODE
+	ATTR_LIST(encrypted_casefold),
 #endif
+#endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 	ATTR_LIST(block_zoned),
 #endif
-- 
2.32.0.rc1.229.g3e70b5a671-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
