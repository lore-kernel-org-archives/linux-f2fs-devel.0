Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032B7C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 21:24:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrndN-0006Ss-0s; Thu, 19 May 2022 21:24:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nrndK-0006Sk-MU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 21:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yEfXRjvKZF5+vY+nj/z3X0NmkyCsv3iKazISGd7ozd8=; b=Ya3rk9F5z3C5ybCaxK+OQy7peL
 LpryUm/WKC0depCpmypJdmJesuHZxv0jRv2P9tJAiYCOivAEOg3pHWlTim0XD/ZtGm/zXcpJeryLb
 n11z1c6viUXjmxnJRI4ChezrDcRWl6X8GCIyGb13ZWmTYnxb6hPx00G80GZIFWsi6jec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yEfXRjvKZF5+vY+nj/z3X0NmkyCsv3iKazISGd7ozd8=; b=CM9mVHiJVu1PJ1inmAiutxjkw6
 Al9eX4walD9lN5A64RVVBW6ypkmBVmbQWdCQCMF1G+Vk+0mGXftPYIMdWFQ2AgT9w4jjF1Xml6RKz
 UV4l0ciTPGx5p86x1VhH6fKXyWdMI8eokgf9ieqr2K+QeiTG03SYw/IJfGXfOW/QaV/A=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrndI-00AbT5-8J
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 21:24:33 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id E6A6A1F45F78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652995466;
 bh=4aprNls1SIrgCGEknan+1QCNSFzZMfaiFkY311lbaUE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CdLJ3EH/R8kH5XGpI1nmoLA1vvT4Nnb5wGKg+awNGoFswzJVpWnNnKWaYYxl3N72D
 Xk2hwjVb+mjLFKxqCl7TirLD0AWI+prsAKYxojlOQCmz+E58wTRNVRs8cUaSGUMKKe
 e6yDA2bD2D5nvCCQQsefwILcSvnPdH9w5XhHWoQAtIJPf9zZzs040cx/aF1M9sGf4u
 0MUTVZVQUlpIJ/XZSTEap5dv6OMxMdQ6fzHs7M/Bbew1h11GRsItVKgYvduoPARt2W
 xL1A40DJjEcspoC6+nJhL4YC/RXCvFk0lgBfJSqWaD99S3R1m7V/1zUBCxPZu98T9S
 p07MczN/we8jw==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 ebiggers@kernel.org
Date: Thu, 19 May 2022 17:23:57 -0400
Message-Id: <20220519212359.19442-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519212359.19442-1-krisman@collabora.com>
References: <20220519212359.19442-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1nrndI-00AbT5-8J
Subject: [f2fs-dev] [PATCH v8 6/8] ext4: Log error when lookup of encoded
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
index eaf383740965..708c241b23ec 100644
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
