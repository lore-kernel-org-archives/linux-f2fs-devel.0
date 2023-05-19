Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F205C77B75
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 May 2023 09:36:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzwWm-0004xo-Jc;
	Fri, 19 May 2023 09:36:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+aecf67361b95543ec79f+7208+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1pzwWk-0004xa-T9 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 19 May 2023 09:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C58xAMXMWyHPUrJzlledIWUNnBNJDxIHqrA6uNazQYQ=; b=NAjjWLWqpvMF6d9SLC4VHinPGx
 NKfctAF3e/e1xZRaT7aBArn4nLlpfN0IKWLuSkzvC0fzUvspsYV+vWDg69qzMagzdpdP/GelFFGd+
 xaH99wtcXXcnoIdwrwQn02hJirC+QBHeEcTM/jUa+SZQxhWN3igecEFKycXUXkdfQ5hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C58xAMXMWyHPUrJzlledIWUNnBNJDxIHqrA6uNazQYQ=; b=A6S6waKMCUKbxk1VPC3NiYoiBF
 qRdF5ceqWqax71zbHRepfoz0fpu5S9Gaa9qjqnNJT7YBLUP+C5yrCmOAGuPxYA2/g/85tB3URcJKz
 jtTYQb/9p6vgZb8vVAKmTQC0z3m7cjZNqQb9n3z4QlxoEF+rC4mpMep8LN4F4PPzEqz0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzwWd-0007KK-Cq for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 19 May 2023 09:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=C58xAMXMWyHPUrJzlledIWUNnBNJDxIHqrA6uNazQYQ=; b=oyB5ENrtpS3oCMIV1tdQqugXkU
 sJw9tWTnvGCKGzKa9RpoMfHRvUYSVzT0RXiuWCYAumP4uyadSzytLs+6N80qNj9Wx28cGiAr5gPRY
 KzRMEKVFBYf9VfLGcLm7M27cD+XoFkxkgCSSKqQHZ2uH/AqoUIgSHz/wG2IogiCKWS/kp20FiYsw9
 xyQ9CaQyFtSTLVG/mgOLVL5dwvmUwJri/zQlIjlsjwVm/9D6Z4u0xvXzVPX25fHmcOK0AEKAUd6wR
 5Pyq49d9NQSlXRan5UmQ0bHDH+gbH8e7O2mZ27adQFXSM/HW3HE7/4rluA8VRqK7aYy04HDSPH9D2
 6F0846Dw==;
Received: from [2001:4bb8:188:3dd5:e8d0:68bb:e5be:210a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pzwWF-00Fjaj-1T; Fri, 19 May 2023 09:35:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Date: Fri, 19 May 2023 11:35:09 +0200
Message-Id: <20230519093521.133226-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519093521.133226-1-hch@lst.de>
References: <20230519093521.133226-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1pzwWd-0007KK-Cq
Subject: [f2fs-dev] [PATCH 01/13] iomap: update ki_pos a little later in
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
 Theodore Ts'o <tytso@mit.edu>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Move the ki_pos update down a bit to prepare for a better common
helper that invalidates pages based of an iocb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
