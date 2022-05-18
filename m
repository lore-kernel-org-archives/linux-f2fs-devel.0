Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6CCC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 May 2022 17:24:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrNOz-0006yg-9K; Wed, 18 May 2022 17:24:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nrNOy-0006yT-BE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 17:23:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kDnDKSHhoqmAZH6XINdrv04yusWiyusSb1ohf9ynA1U=; b=TJFYfKNfz1mHiLWcXEA7X6Vtg6
 uv1nobdSGvx/ckYuaRVQtm+Pnm0q8vQKVmlgNM60mrUZSy4JjOzFq7Ht74HY5YnKMwfU+MumPhFEU
 sG8ojxzb5/8Ytk9WG/wLx1g/hOBbBIQQwhpR81+mDRBGPWZNIEBvu/EmwQI8EMPqhl2s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kDnDKSHhoqmAZH6XINdrv04yusWiyusSb1ohf9ynA1U=; b=FnZvNeCwQlARTb7/G3mQC7twSs
 XY36dX7M7c6W/5TITvAig/L7X/chJiBHK3yER2vjIGxR3wpaCuY1nO5JTvdxtSg0HBF2fPVeJqCsr
 h2e68QpCho7y1OmDkjFPeKJaBnGUxKmg264NZfDSy6fVeU/9RMdf6KE3VZO0gZ2LIw34=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrNOw-0007Mi-JR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 17:23:59 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id DE34A1F4549A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652894632;
 bh=wEtELicV/Q3JgBPpviNuE9QAVFCxhQ4MrH/zciZ2jSY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JvDD9PqGqVe9idcKeP/5BPsrOm30CD3qFzcJrCRWAjz6XyTG5aTIpiQXcW0Rtq74H
 aQWcU7xpburVefpdH22KFhdKdYSoWfe97I4Xw37WDbzPRPLFLvTL0c40IIuDepAx1O
 gvIpzJoXEadbJVxKVd4AjPPHxcDG61CU88q+X/61DSEBi70F03KnRMoa5eeZCf3v3T
 Xk96TiP6hulALd447W9eaqF7EStmqe8rX2imRkCM8SP/sRSfTHVZyO9g20vribizso
 Bk5AZJ5vumlWhAHDkVLs5CRi38SxSpm4NvRIcwKDMT3sDXUs1nSQ937J3OGFA9weFG
 F/Lgp3l7t3h3Q==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 ebiggers@kernel.org
Date: Wed, 18 May 2022 13:23:18 -0400
Message-Id: <20220518172320.333617-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518172320.333617-1-krisman@collabora.com>
References: <20220518172320.333617-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1nrNOw-0007Mi-JR
Subject: [f2fs-dev] [PATCH v5 6/8] ext4: Log error when lookup of encoded
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
 kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

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
index 98295b03a57c..8fbb35187f72 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1396,6 +1396,9 @@ static bool ext4_match(struct inode *parent,
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
