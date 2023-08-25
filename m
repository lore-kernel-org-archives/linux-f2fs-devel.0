Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C00C3DA6F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Aug 2023 14:03:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZXP7-0003io-LC;
	Fri, 25 Aug 2023 14:03:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hao.xu@linux.dev>) id 1qZXP6-0003ih-Kb
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 14:03:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qTb/druvnHmAZS3W1u50TERu+WCPGmDec9gQaqemBTg=; b=FKl5ThvG2Ey5oxslwgPtROr3Sf
 YuNRm7IBm6S3vE1EQUcOFZngOOMq4ScOQQfhWBB6QQTbMzFN/uMx2wlVTC3OtxET110U/OoXjVO9F
 X5gfdgyE4AflOMq/nRafxa+Fh+/7hnHksRgV6k0H0uXMk8WcsE++dwhjSWk4UKU90vu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qTb/druvnHmAZS3W1u50TERu+WCPGmDec9gQaqemBTg=; b=Z9B3K61YgMXfRKWvnOqEpnJ1g/
 hLQFY2m0HchY/spHAh26PPyvb/sM9/NMXrleVA8YHeXCz/QtSI91NxxtqJrMs4SpXtrQtsYwlMtjS
 hxVTDSNjkIMU7tyagp+83dKVhyHpZp/IrIakT62KIxChtv3v6HZYq9sIUV3wfltY5qnE=;
Received: from out-252.mta1.migadu.com ([95.215.58.252])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qZXP5-0007f2-Rw for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 14:03:13 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1692972185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTb/druvnHmAZS3W1u50TERu+WCPGmDec9gQaqemBTg=;
 b=F3s/OJUcPEY5Zlidje3R3yeS51LSjhWu/qJIZQ5RlOJtYZFuPHsEDcjE4qLEmmAUjn6Noq
 1FuuA0oBiaR8ILzLTnrrBydu7XR0r/KR3HJXB7nZmLWLG0jXn8HNnNNNLFYiSbQJ1kLBWH
 sWlvtA/UHWBfhR+BdKG+F5ETxQfMgq0=
From: Hao Xu <hao.xu@linux.dev>
To: io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 25 Aug 2023 21:54:20 +0800
Message-Id: <20230825135431.1317785-19-hao.xu@linux.dev>
In-Reply-To: <20230825135431.1317785-1-hao.xu@linux.dev>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1qZXP5-0007f2-Rw
Subject: [f2fs-dev] [PATCH 18/29] xfs: set XBF_NOWAIT for xfs_buf_read_map
 if necessary
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
Cc: Wanpeng Li <wanpengli@tencent.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-cachefs@redhat.com,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 bpf@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Hao Xu <howeyxu@tencent.com>

Set XBF_NOWAIT for xfs_buf_read_map() if necessary.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/xfs/xfs_trans_buf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_trans_buf.c b/fs/xfs/xfs_trans_buf.c
index 6549e50d852c..016371f58f26 100644
--- a/fs/xfs/xfs_trans_buf.c
+++ b/fs/xfs/xfs_trans_buf.c
@@ -286,6 +286,8 @@ xfs_trans_read_buf_map(
 		return 0;
 	}
 
+	if (tp && (tp->t_flags & XFS_TRANS_NOWAIT))
+		flags |= XBF_NOWAIT;
 	error = xfs_buf_read_map(target, map, nmaps, flags, &bp, ops,
 			__return_address);
 	switch (error) {
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
