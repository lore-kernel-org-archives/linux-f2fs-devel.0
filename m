Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2C3C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 20:47:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrn3I-0004z3-OX; Thu, 19 May 2022 20:47:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nrn3H-0004yj-A1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 20:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h2xhxQiI8y+UVuJOrRpmlGqnyOFyMyi9KoVuIJm2Y9E=; b=KBWQtkGqOMMjX6xsh40dit2cUA
 5db7YB1Ge2WMQaXxRJvFtSq8RfmoWHNFzQ8W3RyJPiPWeiOjs9DuuqhrWnl46qWmnSCTkoAnbjBOr
 sjHLvVdK+YzaxsOOv198LJF6ebKXLTewSDSF6ZGK5dG81G+r+XAGhkfeoPNWlQ3fENpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h2xhxQiI8y+UVuJOrRpmlGqnyOFyMyi9KoVuIJm2Y9E=; b=MqCCRsiZqlQTQ8q2MetwTdvcAP
 Sc6WNL2mNnnha6OUiXVfz2SLsQQt3dPQn3tOhDUbnFK2tdhmfv36mx8t6iDa5yuzCxLL2+xg1V0b9
 wuonYYHz1WNuzD+gVA/VRupK+88pO2Bk+P7+Ml95eRuhUZ6Ao5+Q9Ueu1OwW4+afV3gg=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrn3F-00AU41-2d
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 20:47:17 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id BA7EF1F4541F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652993231;
 bh=M0TLs16gnY6Il6I/gjDxltCLo80eOfsQXUv+A05frpQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OKmOKKuBiKoZUWrPq5KGfLwDltQMzOtgH7697UjH8TlhKWXb2ZyBiHoObI3NbS9iN
 58fV6Woayp8DGzdMl9r6Wp+E+gwMdf9kDe1Y23w3XkH9zlSA2sRtB1yd4VQVyZj4fF
 wyZqRdkvyz25s+WwMWTwIjCbxdiPjoO76V+LekH0Xy4yVdCE/VnD1FUpk4lkenGGJf
 PiUR/4V5WQ3b+J46f2wfrZVuK/tofuUdW77NURr8GmT4zy0W5eixq9ksVqlcAKjJu3
 JLTFg8oKvs4BzDLczc4Fd6xV1yPt1jN2980GmMBO6MG7JDs35nzoZEE87gpS54MmWh
 1DFFwS5xgSO+g==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 ebiggers@kernel.org
Date: Thu, 19 May 2022 16:46:43 -0400
Message-Id: <20220519204645.16528-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519204645.16528-1-krisman@collabora.com>
References: <20220519204645.16528-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1nrn3F-00AU41-2d
Subject: [f2fs-dev] [PATCH v7 6/8] ext4: Log error when lookup of encoded
 dentry fails
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
Cc: linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
 kernel@collabora.com, Eric Biggers <ebiggers@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---

changes since v4:
  - Reword error message (Eric)

Changes since v1:
  - reword error message "file in directory" -> "filename" (Eric)
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5e68dd6ad9b8..f4593dc3e593 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1406,6 +1406,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+					"Directory contains filename that is invalid UTF-8");
 			return false;
 		}
 		return ret;
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
