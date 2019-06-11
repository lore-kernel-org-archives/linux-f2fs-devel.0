Return-Path: <SRS0=R9hs=UK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB9C4321A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Jun 2019 04:47:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2753F20820;
	Tue, 11 Jun 2019 04:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ebaMnsUd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JidIMvvj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a65p1F4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2753F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1haYhO-00020n-8o; Tue, 11 Jun 2019 04:47:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1haYhM-00020T-K8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Jun 2019 04:47:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9SKtfVa/Ru/24wF00+1XpgCjgE3DaoVXLTp8OBycX6Q=; b=ebaMnsUdFKtoLE1nHUX3dnvvwW
 zobQ+OvQZbCRkoli/Q8igsfK8g6H2PK6dDk/JdKVn/6nNt/2xttIjN72LZcH+KnODvDn3KpL+rYEx
 3qaCWyzuE1ec9ZpjdINFiat0zitqcbzAdR5fxnCvRScVBPIsEL1/+OCC8wJDyM0ZWtA4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9SKtfVa/Ru/24wF00+1XpgCjgE3DaoVXLTp8OBycX6Q=; b=JidIMvvjVVBA9HB51HaucX/uzp
 HaJjPF9Sknp61nYXPfXeqOxgx2UJIniu8NZpxR20b7PcNzHre8ooh93xKNOoKEcnEk8NTlCuvvPEa
 0dvs9DGGDCYTR5y5STPRyUIIqX6WZIUpTU0KGeBn+ikBgCS/0fRj3w29eD9vhidgDeEU=;
Received: from aserp2130.oracle.com ([141.146.126.79])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1haYhL-007JLN-3H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Jun 2019 04:47:52 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4ieXX180356;
 Tue, 11 Jun 2019 04:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9SKtfVa/Ru/24wF00+1XpgCjgE3DaoVXLTp8OBycX6Q=;
 b=a65p1F4GNMOD7ZhfQQ0Aee5lYxxpF5bEu3ejKPQ2FI7leIuD3L5Od98XxlBZBiULo+I0
 PiLxwPa4TP11fmkzFx2hTEBttQ70Asjs3pVhj0xnUyuA4TDA1PdZ8+K3B6AKTniIH0Wt
 PmgpOJ8FLa5n7B5QaOsMaglRlEL7Jg9amXjrWd4aSz73BNDqzucGWJCWPu30LR2AHZmZ
 Vp4STkJq+EZPOJb8jfflSMgEzgDqHawNUz8Vj1787pJfdkW2tYHVSsDffdIcIn3YNzqe
 XNFe4G9eEolFtUBijCmtu6ZVbwPdu+R01OhSK+PU52cI/5p/ugsYJGx0SL2G2TuMpOje ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 2t02hejrh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 04:46:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4klpd052677;
 Tue, 11 Jun 2019 04:46:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 2t1jph7wy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Jun 2019 04:46:50 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5B4koOo052887;
 Tue, 11 Jun 2019 04:46:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t1jph7wxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 04:46:50 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5B4kmA1002826;
 Tue, 11 Jun 2019 04:46:48 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 10 Jun 2019 21:46:48 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
 darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
 josef@toxicpanda.com, clm@fb.com, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, jack@suse.com, dsterba@suse.com,
 jaegeuk@kernel.org, jk@ozlabs.org
Date: Mon, 10 Jun 2019 21:46:45 -0700
Message-ID: <156022840560.3227213.4776913678782966728.stgit@magnolia>
In-Reply-To: <156022836912.3227213.13598042497272336695.stgit@magnolia>
References: <156022836912.3227213.13598042497272336695.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=893 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110033
X-Headers-End: 1haYhL-007JLN-3H
Subject: [f2fs-dev] [PATCH 4/6] vfs: don't allow most setxattr to immutable
 files
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190611044645.VAsxhu2Dpl0sR4HE8gLSFiSoKd0F5_dYHjPZ-xa32r4@z>

From: Darrick J. Wong <darrick.wong@oracle.com>

The chattr manpage has this to say about immutable files:

"A file with the 'i' attribute cannot be modified: it cannot be deleted
or renamed, no link can be created to this file, most of the file's
metadata can not be modified, and the file can not be opened in write
mode."

However, we don't actually check the immutable flag in the setattr code,
which means that we can update inode flags and project ids and extent
size hints on supposedly immutable files.  Therefore, reject setflags
and fssetxattr calls on an immutable file if the file is immutable and
will remain that way.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/inode.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)


diff --git a/fs/inode.c b/fs/inode.c
index a3757051fd55..adfb458bf533 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2184,6 +2184,17 @@ int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags)
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
+	/*
+	 * We aren't allowed to change any other flags if the immutable flag is
+	 * already set and is not being unset.
+	 */
+	if ((oldflags & FS_IMMUTABLE_FL) &&
+	    (flags & FS_IMMUTABLE_FL)) {
+		if ((oldflags & ~FS_IMMUTABLE_FL) !=
+		    (flags & ~FS_IMMUTABLE_FL))
+			return -EPERM;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_check);
@@ -2226,6 +2237,26 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
 	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
+	/*
+	 * We aren't allowed to change any fields if the immutable flag is
+	 * already set and is not being unset.
+	 */
+	if ((old_fa->fsx_xflags & FS_XFLAG_IMMUTABLE) &&
+	    (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)) {
+		if ((old_fa->fsx_xflags & ~FS_XFLAG_IMMUTABLE) !=
+		    (fa->fsx_xflags & ~FS_XFLAG_IMMUTABLE))
+			return -EPERM;
+		if (old_fa->fsx_projid != fa->fsx_projid)
+			return -EPERM;
+		if ((fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
+				       FS_XFLAG_EXTSZINHERIT)) &&
+		    old_fa->fsx_extsize != fa->fsx_extsize)
+			return -EPERM;
+		if ((old_fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+		    old_fa->fsx_cowextsize != fa->fsx_cowextsize)
+			return -EPERM;
+	}
+
 	/* Extent size hints of zero turn off the flags. */
 	if (fa->fsx_extsize == 0)
 		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
