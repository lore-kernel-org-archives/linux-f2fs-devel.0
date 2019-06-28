Return-Path: <SRS0=yuZv=U3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7942FC4321A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:36:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DB42083B;
	Fri, 28 Jun 2019 18:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="IauZUB8O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="V3zXS54n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jRRaM6/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DB42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hgvj5-0006f5-39; Fri, 28 Jun 2019 18:35:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1hgvj4-0006eu-Jf
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jun 2019 18:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hDvAuKrMfSUW7AbzqNfZSt/8R1aeCpTe5TGF8T8lRYc=; b=IauZUB8Ox9TehXlxUZif1VCr6i
 QlmmKCaC6YKShqFBoDVM4Fbuwq9Q0eqC3K5ZFAqDQUhpJtJysd0c+Z5RGKgY6rRTvr3bXsnnnRRkX
 pA5h5SZP+abQ3T+G8QX4gHAwWyyrSA+Ryr/ihAmjqn8QBdgLxpZ8ASFwBeo/awuvj2Sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hDvAuKrMfSUW7AbzqNfZSt/8R1aeCpTe5TGF8T8lRYc=; b=V3zXS54no6Mdbp7a3y32qOz6qs
 kIPM6fIlEynywASyeiCD6iy9+7Fg6VGcCXlQ2PaxHh67hbAGGysXai3FiNaDKD+QzExVyp1A58f18
 m10qmiTtQh/d9oxPMrzZKJ9+dfvNepx36I8YwSg/kM2Qh8fRkx4iKSFoMYfnfRnZpe+0=;
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hgvjH-000gir-2j
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jun 2019 18:36:14 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIYQRG108883;
 Fri, 28 Jun 2019 18:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hDvAuKrMfSUW7AbzqNfZSt/8R1aeCpTe5TGF8T8lRYc=;
 b=jRRaM6/cr2s1fN3nJa8yFGdPIm650NetSXoqzer/0L2yCpma7vUORBQ7mNoB6zegt3yV
 2WaPx92M+xx36rc1eyqskvJFn7teZ2EjeHlgbNGpAU6lHKWmerm/E2KLpNPo+wGArDa1
 K8c2RTjP5b+vZvA0NI05COGDHcOesafa6zvfR7n2l6a4vNBTxFEAFBe9kju/lSpjuOFA
 sfZS2IZRGf2rVNN8QJ4XjaPhFu7Dg9WBD5nM9iuWr+1Q8xXsS4BvM2zQ5vYY9tZSIFZD
 S1ts7ni4Y8CuHWQnPN6AP834iFHazwJqlHUIP93kvyf0vy/iHyKGjVX9sQiIRpp9eMnJ xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t9brtq3hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jun 2019 18:34:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIXXPt000897;
 Fri, 28 Jun 2019 18:34:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 2tat7e3gab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2019 18:34:56 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5SIYuM8003117;
 Fri, 28 Jun 2019 18:34:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2tat7e3ga7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jun 2019 18:34:56 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5SIYsCq029052;
 Fri, 28 Jun 2019 18:34:54 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 28 Jun 2019 11:34:54 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
 darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
 josef@toxicpanda.com, hch@infradead.org, clm@fb.com,
 adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
 dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org
Date: Fri, 28 Jun 2019 11:34:51 -0700
Message-ID: <156174689192.1557469.17945809794748607270.stgit@magnolia>
In-Reply-To: <156174687561.1557469.7505651950825460767.stgit@magnolia>
References: <156174687561.1557469.7505651950825460767.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=753 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280210
X-Headers-End: 1hgvjH-000gir-2j
Subject: [f2fs-dev] [PATCH 2/4] vfs: flush and wait for io when setting the
 immutable flag via SETFLAGS
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
Cc: linux-efi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Darrick J. Wong <darrick.wong@oracle.com>

When we're using FS_IOC_SETFLAGS to set the immutable flag on a file, we
need to ensure that userspace can't continue to write the file after the
file becomes immutable.  To make that happen, we have to flush all the
dirty pagecache pages to disk to ensure that we can fail a page fault on
a mmap'd region, wait for pending directio to complete, and hope the
caller locked out any new writes by holding the inode lock.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/inode.c         |   21 +++++++++++++++++++--
 include/linux/fs.h |   11 +++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)


diff --git a/fs/inode.c b/fs/inode.c
index f08711b34341..65a412af3ffb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2193,7 +2193,8 @@ EXPORT_SYMBOL(current_time);
 
 /*
  * Generic function to check FS_IOC_SETFLAGS values and reject any invalid
- * configurations.
+ * configurations.  Once we're done, prepare the inode for whatever changes
+ * are coming down the pipeline.
  *
  * Note: the caller should be holding i_mutex, or else be sure that they have
  * exclusive access to the inode structure.
@@ -2201,6 +2202,8 @@ EXPORT_SYMBOL(current_time);
 int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 			     unsigned int flags)
 {
+	int ret;
+
 	/*
 	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
 	 * the relevant capability.
@@ -2211,7 +2214,21 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
-	return 0;
+	/*
+	 * Now that we're done checking the new flags, flush all pending IO and
+	 * dirty mappings before setting S_IMMUTABLE on an inode via
+	 * FS_IOC_SETFLAGS.  If the flush fails we'll clear the flag before
+	 * returning error.
+	 */
+	if (!S_ISREG(inode->i_mode) || IS_IMMUTABLE(inode) ||
+	    !(flags & FS_IMMUTABLE_FL))
+		return 0;
+
+	inode_set_flags(inode, S_IMMUTABLE, S_IMMUTABLE);
+	ret = inode_drain_writes(inode);
+	if (ret)
+		inode_set_flags(inode, 0, S_IMMUTABLE);
+	return ret;
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 91482ab4556a..0efe749de577 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3567,4 +3567,15 @@ static inline void simple_fill_fsxattr(struct fsxattr *fa, __u32 xflags)
 	fa->fsx_xflags = xflags;
 }
 
+/*
+ * Flush file data before changing attributes.  Caller must hold any locks
+ * required to prevent further writes to this file until we're done setting
+ * flags.
+ */
+static inline int inode_drain_writes(struct inode *inode)
+{
+	inode_dio_wait(inode);
+	return filemap_write_and_wait(inode->i_mapping);
+}
+
 #endif /* _LINUX_FS_H */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
