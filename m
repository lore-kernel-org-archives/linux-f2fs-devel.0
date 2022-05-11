Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD0DC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 May 2022 19:32:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nos4O-0006vd-4M; Wed, 11 May 2022 19:32:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nos4N-0006vI-4X
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 May 2022 19:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/oUXjrybZKTCrYL9FuHz1QRYOIdPMUMyKCsGW60fmcU=; b=ZahNneeTwL0nncyFDf4mWUEt7v
 yGVfzvLbmKXWXlQPbIcf3RKAYVoNsDr3tYaDfEh0b1kMpsNsDfKjMBsjLKxqo28IZRqoB86ttVeTV
 QG059uzUt/t4cNI9ziah3I7hnOrWwyhD6Lyl+1ZpZzOB0x3uCC5RVfS8k8wX+FDnqA+E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/oUXjrybZKTCrYL9FuHz1QRYOIdPMUMyKCsGW60fmcU=; b=k/wf06K2LmKcPcKQEE4NPHQ/Vy
 SZy0J9EIEHYPPDKS0cuvc6IrZIhEhC2+XJEzOGRnddMsL9qCb7+FbOW0j+w4ERvZp+3LPgb1S+JxR
 RDQZsbU7HWG4+cPKACmlEIQkJPqk1jB9M6YjJR2aqvjRMOdvRsSSkE7Pm66qmNI5XcLM=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nos4L-0093hO-8n
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 May 2022 19:32:22 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id E7FDB1F42934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652297535;
 bh=c75v2/ZUWH6IoljcFit0bLWBPzrmfaQjfZFWk4rflVg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EBsuGOrJmRxDdIL3UVqqU1yAN4lBgbgq3f8FZQzAAkij6aNfupt4PWtsdjafYk+AL
 UAlPlzykOGpCkQS6d0KXu0g4zVJKXL5QvDli3p68k7QsMe+poeKeDe7fzHLc6VuER/
 fQS0cHMVZRKaIy9d1TCZ2eP/WmNLbWM1jtEWU3U5Q6YnGA46jJqxFwRnWB2FnF0ujv
 VzBvAKosu0i/B2aZY8KjbvKgrLhfRoKv7d2j4auiW6eaO7qySxbzywY3+XpUQBqcEH
 hYVzRf06Fo4NruE2WwNDsV8uFu08G65aiCJ3ikI2bOgLGCPt7le7ACMu6Lk5e2w2wA
 DL82qOXaPSZvA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org
Date: Wed, 11 May 2022 15:31:42 -0400
Message-Id: <20220511193146.27526-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511193146.27526-1-krisman@collabora.com>
References: <20220511193146.27526-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1nos4L-0093hO-8n
Subject: [f2fs-dev] [PATCH v4 06/10] ext4: Log error when lookup of encoded
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
Cc: ebiggers@kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>, kernel@collabora.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---

Changes since v1:
  - reword error message "file in directory" -> "filename" (Eric)
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cebbcabf0ff0..708811525411 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1458,6 +1458,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+						 "Bad encoded filename");
 			return false;
 		}
 		return ret;
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
