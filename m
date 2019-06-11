Return-Path: <SRS0=R9hs=UK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE87C43218
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Jun 2019 04:50:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B5720820;
	Tue, 11 Jun 2019 04:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="BxYk61P6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PIIzQAVl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xr/OkVp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B5720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1haYjY-0008I2-Jy; Tue, 11 Jun 2019 04:50:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1haYjW-0008Ht-9g
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Jun 2019 04:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w6B62XWgEySnIWZsve79cF+lTRasJpmyyQueK4g93UE=; b=BxYk61P6CAVm93fwWO52m6phsa
 mzG6lXsg/0YYVx4z8XNpYKmh4Al07Jv4X+E8CHPUEIGX6SrtxWuPCXnf4tRw4FjZ114azDHASxhYf
 kljYcx5QOLWRJQ+WU9oTMkZG7U/qJr4mUxlCD9E5eg9tGb/ts+i/Q/u/gMjBatvVpfBM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w6B62XWgEySnIWZsve79cF+lTRasJpmyyQueK4g93UE=; b=PIIzQAVl/acoPP4GLfb2UQL+38
 JYDLQYfRzQ2vnexI9XxIU/SPMw/kTyjAOH5RqJgI9YhkTHwQBNhogRWtX5jD0s8jnv+4/QR9uqeac
 YbRqPQxmgg/+0JFerSBCNnK3BNaeiLW0e2RrFGe/9fy0hzN2jN5qKjT5OdE5zHUrPFQw=;
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1haYjV-007JUK-3m
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Jun 2019 04:50:06 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4hbtt159138;
 Tue, 11 Jun 2019 04:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=w6B62XWgEySnIWZsve79cF+lTRasJpmyyQueK4g93UE=;
 b=xr/OkVp95W9CZa1qjVKbtngLN9J+a0uZavn2r3ArsGbLa3Idt+XiHAevESEnFd2Muawd
 IDeKByu9gQWLom5QvFu9SB6aGdiFJoCp0tz7vKlzNewkahhwnjXvO0YFc7SwTBUu/TXr
 1JAzKRa/DZxlP4ZZpnIqV/L0X1JujwSoecEOGG343C3b9FaK4zuy1R0cRIGXh59pnwVC
 rgO1+qT0i60g5fCtoX0xlqOK/qTFrDgQsRkvoiZce/aNAuX3Lrp5ll2wDFoSsEQSMY+0
 xO05b6rP2HVkV4MLCu2gbQsaloZCyjVElf52i0un57IO4AUWcCHG2FJLiCzCFi61Ne0u iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t04etjm38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 04:49:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4jGrX167613;
 Tue, 11 Jun 2019 04:47:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 2t024u6kpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Jun 2019 04:47:06 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5B4l5Gj171026;
 Tue, 11 Jun 2019 04:47:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2t024u6kpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 04:47:05 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5B4l4Q5023284;
 Tue, 11 Jun 2019 04:47:04 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 10 Jun 2019 21:47:04 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
 darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
 josef@toxicpanda.com, clm@fb.com, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, jack@suse.com, dsterba@suse.com,
 jaegeuk@kernel.org, jk@ozlabs.org
Date: Mon, 10 Jun 2019 21:47:01 -0700
Message-ID: <156022842153.3227213.3285668171167534801.stgit@magnolia>
In-Reply-To: <156022836912.3227213.13598042497272336695.stgit@magnolia>
References: <156022836912.3227213.13598042497272336695.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=605 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110033
X-Headers-End: 1haYjV-007JUK-3m
Subject: [f2fs-dev] [PATCH 6/6] xfs: clean up xfs_merge_ioc_xflags
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
Message-ID: <20190611044701.Klv0VJsGPclR4xuR9VM0ErQxv_gSkbEb4r3gRJ0HZmU@z>

From: Darrick J. Wong <darrick.wong@oracle.com>

Clean up the calling convention since we're editing the fsxattr struct
anyway.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_ioctl.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)


diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 7b19ba2956ad..a67bc9afdd0b 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -829,35 +829,31 @@ xfs_ioc_ag_geometry(
  * Linux extended inode flags interface.
  */
 
-STATIC unsigned int
+static inline void
 xfs_merge_ioc_xflags(
-	unsigned int	flags,
-	unsigned int	start)
+	struct fsxattr	*fa,
+	unsigned int	flags)
 {
-	unsigned int	xflags = start;
-
 	if (flags & FS_IMMUTABLE_FL)
-		xflags |= FS_XFLAG_IMMUTABLE;
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
 	else
-		xflags &= ~FS_XFLAG_IMMUTABLE;
+		fa->fsx_xflags &= ~FS_XFLAG_IMMUTABLE;
 	if (flags & FS_APPEND_FL)
-		xflags |= FS_XFLAG_APPEND;
+		fa->fsx_xflags |= FS_XFLAG_APPEND;
 	else
-		xflags &= ~FS_XFLAG_APPEND;
+		fa->fsx_xflags &= ~FS_XFLAG_APPEND;
 	if (flags & FS_SYNC_FL)
-		xflags |= FS_XFLAG_SYNC;
+		fa->fsx_xflags |= FS_XFLAG_SYNC;
 	else
-		xflags &= ~FS_XFLAG_SYNC;
+		fa->fsx_xflags &= ~FS_XFLAG_SYNC;
 	if (flags & FS_NOATIME_FL)
-		xflags |= FS_XFLAG_NOATIME;
+		fa->fsx_xflags |= FS_XFLAG_NOATIME;
 	else
-		xflags &= ~FS_XFLAG_NOATIME;
+		fa->fsx_xflags &= ~FS_XFLAG_NOATIME;
 	if (flags & FS_NODUMP_FL)
-		xflags |= FS_XFLAG_NODUMP;
+		fa->fsx_xflags |= FS_XFLAG_NODUMP;
 	else
-		xflags &= ~FS_XFLAG_NODUMP;
-
-	return xflags;
+		fa->fsx_xflags &= ~FS_XFLAG_NODUMP;
 }
 
 STATIC unsigned int
@@ -1504,7 +1500,7 @@ xfs_ioc_setxflags(
 		return -EOPNOTSUPP;
 
 	__xfs_ioc_fsgetxattr(ip, false, &fa);
-	fa.fsx_xflags = xfs_merge_ioc_xflags(flags, fa.fsx_xflags);
+	xfs_merge_ioc_xflags(&fa, flags);
 
 	error = mnt_want_write_file(filp);
 	if (error)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
