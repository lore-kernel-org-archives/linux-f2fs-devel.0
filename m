Return-Path: <SRS0=gIUY=ZG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038BC432C3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Nov 2019 23:20:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4E0206F0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Nov 2019 23:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TBbBKabi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cK9J2rIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4E0206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iVOPA-0006qo-79; Thu, 14 Nov 2019 23:20:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ira.weiny@intel.com>) id 1iVOP8-0006qh-Gm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Nov 2019 23:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M9BV5AOahRsBpG/lR5WR7uD4sSJaB2/5KhmrzcgOZDM=; b=TBbBKabi7dGPKKEaOTA7ZoxTxO
 X1r/yKT/BbKLkK0fCZn7ydy9MOd4zkVtyJi3Dwt2FcP2aVtPDjhevpD9WNUmtkZ2Yi4mt+ItuF+t5
 WKzjdC339Hj6hg76RkkOfmnm5Ez0dJ8hCmjQSiZgOOjmMBnpSmgAftbXwgAUqsWJ7dP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M9BV5AOahRsBpG/lR5WR7uD4sSJaB2/5KhmrzcgOZDM=; b=c
 K9J2rIegbCS2LHzJlcd1xr8PDI0r2+9otwinqkvCVaaahoVgC2pXcl0EZ9u0rRjVidH5dcwipl33M
 SbVe7AAXET9Jw8sDqeISoBOukaao7zEA3eaK9twvePQ4lnqT1Bx2eX5Zc94tfI/2ofYmQn/dyQSZq
 SEUbhiurByYHigR0=;
Received: from mga14.intel.com ([192.55.52.115])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iVOP3-003vju-KS
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Nov 2019 23:19:58 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 15:19:47 -0800
X-IronPort-AV: E=Sophos;i="5.68,306,1569308400"; d="scan'208";a="199003287"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 15:19:46 -0800
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 14 Nov 2019 15:19:43 -0800
Message-Id: <20191114231943.11220-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Headers-End: 1iVOP3-003vju-KS
Subject: [f2fs-dev] [PATCH] Documentation/fs: Move swap_[de]activate() to
 file_operations
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
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Anna Schumaker <anna.schumaker@netapp.com>, linux-xfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ira Weiny <ira.weiny@intel.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Ira Weiny <ira.weiny@intel.com>

Update the documentation for the move of the swap_* functions out of
address_space_operations and into file_operations.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Follow on to the V2 series sent earlier.  If I need to spin a V3 I will squash
this into patch 2/2 "fs: Move swap_[de]activate to file_operations"

 Documentation/filesystems/vfs.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..03a740d7faa4 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -731,8 +731,6 @@ cache in your filesystem.  The following members are defined:
 					      unsigned long);
 		void (*is_dirty_writeback) (struct page *, bool *, bool *);
 		int (*error_remove_page) (struct mapping *mapping, struct page *page);
-		int (*swap_activate)(struct file *);
-		int (*swap_deactivate)(struct file *);
 	};
 
 ``writepage``
@@ -924,16 +922,6 @@ cache in your filesystem.  The following members are defined:
 	Setting this implies you deal with pages going away under you,
 	unless you have them locked or reference counts increased.
 
-``swap_activate``
-	Called when swapon is used on a file to allocate space if
-	necessary and pin the block lookup information in memory.  A
-	return value of zero indicates success, in which case this file
-	can be used to back swapspace.
-
-``swap_deactivate``
-	Called during swapoff on files where swap_activate was
-	successful.
-
 
 The File Object
 ===============
@@ -988,6 +976,8 @@ This describes how the VFS can manipulate an open file.  As of kernel
 					   struct file *file_out, loff_t pos_out,
 					   loff_t len, unsigned int remap_flags);
 		int (*fadvise)(struct file *, loff_t, loff_t, int);
+		int (*swap_activate)(struct file *);
+		int (*swap_deactivate)(struct file *);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -1108,6 +1098,16 @@ otherwise noted.
 ``fadvise``
 	possibly called by the fadvise64() system call.
 
+``swap_activate``
+	Called when swapon is used on a file to allocate space if
+	necessary and pin the block lookup information in memory.  A
+	return value of zero indicates success, in which case this file
+	can be used to back swapspace.
+
+``swap_deactivate``
+	Called during swapoff on files where swap_activate was
+	successful.
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
-- 
2.21.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
