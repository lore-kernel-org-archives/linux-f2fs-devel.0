Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF44C6FA81
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 Aug 2022 07:01:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oRppL-0002Oj-DE;
	Sat, 27 Aug 2022 07:01:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oRppH-0002OP-Vh
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Aug 2022 07:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Gx1xaUrJwm8H/CC49OiL1ZiW8MszDmlxaE/tpY1oso=; b=XOBPtBJ/UZJBHOCdKzFzY4kKoi
 CtLIgHC6PJNSnjRnbIilXi0/a+czDmjwGuGxSnIjfLUrPanhxNO7nK9KTUVgbK4tAjJIaHxvwBVdJ
 y+iIWBPhFx/mBQzR5XbocN0/+RQvCi4UJN5+t7Qu9NxDUdHCZQWERZdIppife2ABDyrA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8Gx1xaUrJwm8H/CC49OiL1ZiW8MszDmlxaE/tpY1oso=; b=CtV1ldQY9jDQHGdGw1qnnmI8u5
 fLnjFqTcV3IXGuZCSDuHhBZS94b1wqSuypXl4AnG3cmHTJBzNzUvwafiSdWuQszqbsE5TZdXVqqsW
 /MeF8rC1Juh3UXcDMbr/VFoDgj8ohgtcTihYc93VaTN8wEoBnannE0DP6yjT0SSyR3mo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oRppH-0006p9-E2 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Aug 2022 07:01:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8EF9A61086
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 27 Aug 2022 07:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6EEC43140;
 Sat, 27 Aug 2022 07:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661583693;
 bh=BMT1YARSMuQOgngIP7XzOtYpe7cK7QyPx7BNBC00UCE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c/hsF2y+yUyZZ/M61vU4PGa6++PqDTysR9MzPXrcrcqMv3SKVWO1Z1vWcVxMEzoRf
 ta102F7VQ25WpDfRCW+TK34h2VKCCsJlD9dF9R0UUHkYP8h6pH5ZLQ3qCSpSuETS9E
 0c950qgPd/aWdgWhrMkf9/+Gz4bM/bolKb1k/u6N9bv6UKG2oxRqS0yrNd+lnWDUCu
 r3gmhFZ3jxjpnhuIoMUuCUHX/lUS6gns2tSpY2CHEug8psJGV27pGtOyWCu3TcEa8W
 oRxUH3b+QEtBV7fCUNB5TVsCCE9gQsUeQEGkw2yEAughA4ZtiAHBXlKfEaKQO7is49
 oVld+TcJhn8yA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Fri, 26 Aug 2022 23:58:50 -0700
Message-Id: <20220827065851.135710-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827065851.135710-1-ebiggers@kernel.org>
References: <20220827065851.135710-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1oRppH-0006p9-E2
Subject: [f2fs-dev] [PATCH v5 7/8] f2fs: support STATX_DIOALIGN
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Add support for STATX_DIOALIGN to f2fs, so that direct I/O alignment
restrictions are exposed to userspace in a generic way.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8e11311db21060..79177050732803 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -847,6 +847,24 @@ int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
 	}
 
+	/*
+	 * Return the DIO alignment restrictions if requested.  We only return
+	 * this information when requested, since on encrypted files it might
+	 * take a fair bit of work to get if the file wasn't opened recently.
+	 *
+	 * f2fs sometimes supports DIO reads but not DIO writes.  STATX_DIOALIGN
+	 * cannot represent that, so in that case we report no DIO support.
+	 */
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		unsigned int bsize = i_blocksize(inode);
+
+		stat->result_mask |= STATX_DIOALIGN;
+		if (!f2fs_force_buffered_io(inode, WRITE)) {
+			stat->dio_mem_align = bsize;
+			stat->dio_offset_align = bsize;
+		}
+	}
+
 	flags = fi->i_flags;
 	if (flags & F2FS_COMPR_FL)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
-- 
2.37.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
