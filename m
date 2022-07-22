Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1ACC2BBEE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Jul 2022 07:14:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oEmrf-0003fj-8W; Fri, 22 Jul 2022 07:14:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1oEmrb-0003fE-Ua
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 07:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8xyDE+I/nToE5Pxu6c0dfW9XJVaYYhbDsj4ryHoT4Q8=; b=EAatf/9s7dItEqX8yj146aWkCv
 x9jY5nTctYuPM+9x1RO6LZ2juberBVDGRftiPR5AffwgKIjWwJt4OJq5A+5kZs18KkzHyBKmUEpQk
 pd4mB4YfJVpcwlLIFhs6IphcL/Aw7q+J7QyBFMgGLfsYgKvIo8y5PjvdAkF1oAya2flQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8xyDE+I/nToE5Pxu6c0dfW9XJVaYYhbDsj4ryHoT4Q8=; b=kUcSmtbdyWjnZMy3ZA3DoiSnUj
 E80MndKjETMxV0+wUYaTQNy2U+cFUWEehtyaU0YKboWzI1uWDRwfCk5VsWA5wYI1lBhI7MRfF4axu
 mSmAx8JkPfex5pqtWbzyTieAFy/xlF18MOSXUh5EsqbosJXxffjNT0Oi8zozFLwOR77c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oEmrb-0000qt-Kp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 07:14:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BB5526219C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Jul 2022 07:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6A9C341CB;
 Fri, 22 Jul 2022 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658474045;
 bh=yNPRgSeWTnsQodx2HX1gpV+aMEKrajl9C8NqSSYb2uQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HHUHOmotxC+q834q8Lxhf9RUyvTzh8jXRI3uIl5diKurDCYRpkMt+ADLIhoDcbT/Q
 LRigaPp9+S0vQFNSylt1xXtI4iq7f/0LWYA2rN510ZRqrLVQ1lZ4/Xy5XL9GGSkb4s
 FMnaAQYwjSv9rm8kjbDt4f67E86JQs3W6C3yTxqu64u35nWlm+aazzBvpLXSuV6+s4
 wwEJ56CezLq01exxlwB398T1NJCiN1ihPWVbFW5kpdCrXGzMtUTnOOai0o7AVHebmS
 TDyBfSIPvsVWq8BWxGThTMrrIEKr+VY+pZ0904xa1pwj9MLxC8SBE3lt5LMBDzvHwO
 mHtw/hDN52AXw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Fri, 22 Jul 2022 00:12:27 -0700
Message-Id: <20220722071228.146690-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220722071228.146690-1-ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1oEmrb-0000qt-Kp
Subject: [f2fs-dev] [PATCH v4 8/9] f2fs: support STATX_DIOALIGN
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
 fs/f2fs/file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1b452bb75af29e..11d75aa3da185a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -852,6 +852,21 @@ int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
 	}
 
+	/*
+	 * Return the DIO alignment restrictions if requested.  We only return
+	 * this information when requested, since on encrypted files it might
+	 * take a fair bit of work to get if the file wasn't opened recently.
+	 */
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		unsigned int bsize = i_blocksize(inode);
+
+		stat->result_mask |= STATX_DIOALIGN;
+		if (!f2fs_force_buffered_io(inode)) {
+			stat->dio_mem_align = bsize;
+			stat->dio_offset_align = bsize;
+		}
+	}
+
 	flags = fi->i_flags;
 	if (flags & F2FS_COMPR_FL)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
-- 
2.37.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
