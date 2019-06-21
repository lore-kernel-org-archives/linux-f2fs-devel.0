Return-Path: <SRS0=Q+BT=UU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B03C43613
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Jun 2019 23:57:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A9E206B6;
	Fri, 21 Jun 2019 23:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PbLFBeuh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Ub6qA+um";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pYqG0Mi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A9E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1heTP8-0006ON-1s; Fri, 21 Jun 2019 23:57:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>)
 id 1heTP6-0006Nx-A8; Fri, 21 Jun 2019 23:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=02MDI4bEY6Xudjs/bUFIsI++NZrIFrdhazUwB84LYEc=; b=PbLFBeuhDyDm3m7C9PuZuDi0dg
 mywQcb+QSNnmRIbvt4UX3aDXSmUFvrHuZtCogn026dJd5zszFttjZvVLzLikCN1UxjFMECXD7fc3O
 pl3HfNn9T1sO+jiBWFAiYF17FSvr8NRx39zTEDwlliBY81GOV/UhK9uiUvc/sVg+T2ko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=02MDI4bEY6Xudjs/bUFIsI++NZrIFrdhazUwB84LYEc=; b=Ub6qA+umwGLKdeBN+5IntIfeQG
 VIyfDm+Q92tH4kdvSreqLEb50Vkaw1KTFsdOuYAk8oUHeE5hv4QIBF1r6PgXY+KWzMWLZgDCtbFoP
 jpb1vYmgOa9dmJOA9Cz8y4vPtakdPaaTbefJF2JXlpXSiC3hwmmZOv3czW83pv6oWuCI=;
Received: from aserp2120.oracle.com ([141.146.126.78])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1heTP6-003Z5x-Cb; Fri, 21 Jun 2019 23:57:13 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LNsLc4156287;
 Fri, 21 Jun 2019 23:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=02MDI4bEY6Xudjs/bUFIsI++NZrIFrdhazUwB84LYEc=;
 b=pYqG0Mi7o3FqP5WDQAGW1+bdZFCQN2IbA+LryAZ6t7wKAJdJHVZhpD+hmxhqaonvlre0
 KO3He69PVMan5UcLnp7nkezjEY70YfaFljicxQMD2tQQD+L+AIa/+KAzQc1gOdDzpnoI
 CSbineIK0yU0VrMQXTTv1LLQYtuunczezPkoW6r4PtfSy09IZ9XcXm4K1xJWoI2tH08M
 X5TF+yoZOcX5ehnV7dmL+w/O7E7RWe3o3aNaMLKcYyJBIlFWAhsSsvcd39VqzE4sqczT
 NZ6wVF6LWjDiyXRUPSH5G942o99v0L5/Xofy5nYTlE/Gr1tDc5AZ73MFUj+BmpPCOuuq YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2t7809rq5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 23:56:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LNtlab041938;
 Fri, 21 Jun 2019 23:56:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 2t77ypesc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Jun 2019 23:56:51 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5LNupTW043915;
 Fri, 21 Jun 2019 23:56:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2t77ypesc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 23:56:51 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LNumKw020438;
 Fri, 21 Jun 2019 23:56:48 GMT
Received: from localhost (/10.159.131.214)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 16:56:48 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
 darrick.wong@oracle.com, shaggy@kernel.org, ard.biesheuvel@linaro.org,
 josef@toxicpanda.com, clm@fb.com, adilger.kernel@dilger.ca,
 jk@ozlabs.org, jack@suse.com, dsterba@suse.com, jaegeuk@kernel.org,
 viro@zeniv.linux.org.uk
Date: Fri, 21 Jun 2019 16:56:45 -0700
Message-ID: <156116140570.1664814.4607468365269898575.stgit@magnolia>
In-Reply-To: <156116136742.1664814.17093419199766834123.stgit@magnolia>
References: <156116136742.1664814.17093419199766834123.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=949 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210182
X-Headers-End: 1heTP6-003Z5x-Cb
Subject: [f2fs-dev] [PATCH 4/4] vfs: teach vfs_ioc_fssetxattr_check to check
 extent size hints
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
Cc: linux-xfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Darrick J. Wong <darrick.wong@oracle.com>

Move the extent size hint checks that aren't xfs-specific to the vfs.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c         |   18 +++++++++++++
 fs/xfs/xfs_ioctl.c |   70 ++++++++++++++++++++++------------------------------
 2 files changed, 47 insertions(+), 41 deletions(-)


diff --git a/fs/inode.c b/fs/inode.c
index f1ffa9605078..6374ad2ef25b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2234,6 +2234,24 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
 			return -EINVAL;
 	}
 
+	/* Check extent size hints. */
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
+			!S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	/* Extent size hints of zero turn off the flags. */
+	if (fa->fsx_extsize == 0)
+		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	if (fa->fsx_cowextsize == 0)
+		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 82961de98900..b494e7e881e3 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1201,39 +1201,31 @@ xfs_ioctl_setattr_check_extsize(
 	struct fsxattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(VFS_I(ip)->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
-	    !S_ISDIR(VFS_I(ip)->i_mode))
-		return -EINVAL;
+	xfs_extlen_t		size;
+	xfs_fsblock_t		extsize_fsb;
 
 	if (S_ISREG(VFS_I(ip)->i_mode) && ip->i_d.di_nextents &&
 	    ((ip->i_d.di_extsize << mp->m_sb.sb_blocklog) != fa->fsx_extsize))
 		return -EINVAL;
 
-	if (fa->fsx_extsize != 0) {
-		xfs_extlen_t    size;
-		xfs_fsblock_t   extsize_fsb;
-
-		extsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_extsize);
-		if (extsize_fsb > MAXEXTLEN)
-			return -EINVAL;
+	if (fa->fsx_extsize == 0)
+		return 0;
 
-		if (XFS_IS_REALTIME_INODE(ip) ||
-		    (fa->fsx_xflags & FS_XFLAG_REALTIME)) {
-			size = mp->m_sb.sb_rextsize << mp->m_sb.sb_blocklog;
-		} else {
-			size = mp->m_sb.sb_blocksize;
-			if (extsize_fsb > mp->m_sb.sb_agblocks / 2)
-				return -EINVAL;
-		}
+	extsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_extsize);
+	if (extsize_fsb > MAXEXTLEN)
+		return -EINVAL;
 
-		if (fa->fsx_extsize % size)
+	if (XFS_IS_REALTIME_INODE(ip) ||
+	    (fa->fsx_xflags & FS_XFLAG_REALTIME)) {
+		size = mp->m_sb.sb_rextsize << mp->m_sb.sb_blocklog;
+	} else {
+		size = mp->m_sb.sb_blocksize;
+		if (extsize_fsb > mp->m_sb.sb_agblocks / 2)
 			return -EINVAL;
-	} else
-		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	}
+
+	if (fa->fsx_extsize % size)
+		return -EINVAL;
 
 	return 0;
 }
@@ -1259,6 +1251,8 @@ xfs_ioctl_setattr_check_cowextsize(
 	struct fsxattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
+	xfs_extlen_t		size;
+	xfs_fsblock_t		cowextsize_fsb;
 
 	if (!(fa->fsx_xflags & FS_XFLAG_COWEXTSIZE))
 		return 0;
@@ -1267,25 +1261,19 @@ xfs_ioctl_setattr_check_cowextsize(
 	    ip->i_d.di_version != 3)
 		return -EINVAL;
 
-	if (!S_ISREG(VFS_I(ip)->i_mode) && !S_ISDIR(VFS_I(ip)->i_mode))
-		return -EINVAL;
-
-	if (fa->fsx_cowextsize != 0) {
-		xfs_extlen_t    size;
-		xfs_fsblock_t   cowextsize_fsb;
+	if (fa->fsx_cowextsize == 0)
+		return 0;
 
-		cowextsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_cowextsize);
-		if (cowextsize_fsb > MAXEXTLEN)
-			return -EINVAL;
+	cowextsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_cowextsize);
+	if (cowextsize_fsb > MAXEXTLEN)
+		return -EINVAL;
 
-		size = mp->m_sb.sb_blocksize;
-		if (cowextsize_fsb > mp->m_sb.sb_agblocks / 2)
-			return -EINVAL;
+	size = mp->m_sb.sb_blocksize;
+	if (cowextsize_fsb > mp->m_sb.sb_agblocks / 2)
+		return -EINVAL;
 
-		if (fa->fsx_cowextsize % size)
-			return -EINVAL;
-	} else
-		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+	if (fa->fsx_cowextsize % size)
+		return -EINVAL;
 
 	return 0;
 }



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
