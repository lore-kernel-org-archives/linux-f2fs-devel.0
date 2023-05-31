Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E61EC7EE37
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 May 2023 07:20:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4G8M-0004Na-Qv;
	Wed, 31 May 2023 07:20:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+b81a8c9a6d22e8bb2302+7220+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1q4G8I-0004NT-Jy for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 07:20:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1AhsMC0b8Le+Qj8+/F9cJR6e5GLVWYekas+17NCVqqI=; b=agj7M1DJdLqRLEjhd7Z4M+ixhG
 KTUffXTGeYC+zZGyPBxI2G8sguWLFNV5TVqfg1McFG60fIgzLwl9XQOsjCIjSSjrkLrKHtysN6HAl
 XKylukqOZYl4gGrqSOjJZKGFP9UXFsDUZZH+AC0V/qYK8m0GZhEBPJiUDkQWDBIpzC8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1AhsMC0b8Le+Qj8+/F9cJR6e5GLVWYekas+17NCVqqI=; b=byFLmmyHaKvPeCZqrZmLwK0MCO
 fPjM4O1hGv/euiAimknVKWI32RvCtbij2hXtfzl8O8DZDUWuUv+jqcIWiwMXjnQoknJ0Dby1XS8TI
 U1J7KOfZtm7WURTq3bXWQdUlimPEYrNI880Crhbtr+fP9tmf/0KQxVd1+9D1QuFQTsSw=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q4G8F-0004qN-LO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 07:20:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=1AhsMC0b8Le+Qj8+/F9cJR6e5GLVWYekas+17NCVqqI=; b=ngxKf22NWcVmXxqJwcEfwC+j8T
 3PxkmTMDjWxvvbR0duw8sA22hBD8npF8M7zy6uMP4A5nP81zq24egxiseYxIct9QT3BCtbnaev2MP
 wbiG/KzTwrwXiTebokTJ7zF2jRnxdAYau+XBec+F7XpGZX21QBO/OVfktTd4rlLpzooJH46MVsmsK
 +e4Tx0iJl2vZNXf3rTUvEhj2U+bq4yTQ5Rorj9IL8ZzUYJY9U+Zj+4quc3/7Yk+xX4BT5iyozg9is
 oymt/Or6TlEeT9TsG94njHW/hepEKG1n0Fi1TB0ymGUOgiWMRRS2N8SqiUunjzPtuqt/z9Padv5X7
 cRckgdNw==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1q4G7y-00GPht-1z; Wed, 31 May 2023 07:20:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Date: Wed, 31 May 2023 09:20:00 +0200
Message-Id: <20230531072006.476386-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531072006.476386-1-hch@lst.de>
References: <20230531072006.476386-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1q4G8F-0004qN-LO
Subject: [f2fs-dev] [PATCH 2/8] iomap: update ki_pos a little later in
 iomap_dio_complete
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 cluster-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Move the ki_pos update down a bit to prepare for a better common
helper that invalidates pages based of an iocb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/direct-io.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 019cc87d0fb339..6207a59d2162e1 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -94,7 +94,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 		if (offset + ret > dio->i_size &&
 		    !(dio->flags & IOMAP_DIO_WRITE))
 			ret = dio->i_size - offset;
-		iocb->ki_pos += ret;
 	}
 
 	/*
@@ -120,19 +119,21 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	}
 
 	inode_dio_end(file_inode(iocb->ki_filp));
-	/*
-	 * If this is a DSYNC write, make sure we push it to stable storage now
-	 * that we've written data.
-	 */
-	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
-		ret = generic_write_sync(iocb, ret);
 
-	if (ret > 0)
-		ret += dio->done_before;
+	if (ret > 0) {
+		iocb->ki_pos += ret;
 
+		/*
+		 * If this is a DSYNC write, make sure we push it to stable
+		 * storage now that we've written data.
+		 */
+		if (dio->flags & IOMAP_DIO_NEED_SYNC)
+			ret = generic_write_sync(iocb, ret);
+		if (ret > 0)
+			ret += dio->done_before;
+	}
 	trace_iomap_dio_complete(iocb, dio->error, ret);
 	kfree(dio);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_complete);
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
