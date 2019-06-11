Return-Path: <SRS0=R9hs=UK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C692BC4321B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Jun 2019 04:47:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994C620820;
	Tue, 11 Jun 2019 04:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="i1H3L6Ee";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZPsYfwnl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GE9rwfHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994C620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1haYhQ-00008O-6i; Tue, 11 Jun 2019 04:47:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1haYhP-00008F-F4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Jun 2019 04:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GoNZ4aRxdLiu9VXKzoYqQXkZ8KvvgodmwFDB7EyF+mY=; b=i1H3L6EeOfeVT+92M/XAT3+Txn
 E4j/DQFXIKTC3zTt5ITBiJU7hlDTNio03TLk9/qvbvq1uVQtpZzUXGf0IHmRASPs1OHypPOZ/cpgU
 DHFPo277FH8HdutotfcMVw8Fv3W/NzrHZWS0tD+/Ab+pR83KcS5ZtmehWDriOAVBY8Ns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GoNZ4aRxdLiu9VXKzoYqQXkZ8KvvgodmwFDB7EyF+mY=; b=ZPsYfwnl2fah4D2o+Os5OuBC3c
 iFBOip8hk5Epzs8AK405u2e6CMDk96niYPiFIMz5isoruzDQdTnH8qzib+rOrqsP2WEC4z8aVQaP2
 nDw4MyIn1yC0Jry0+ZUmnqxxBcULSyMKSciGadG7nnQZvxOqw2/Nj+ZzLJJhAZThitlk=;
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1haYhP-006vEl-Hi
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Jun 2019 04:47:56 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4iSvp159663;
 Tue, 11 Jun 2019 04:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=GoNZ4aRxdLiu9VXKzoYqQXkZ8KvvgodmwFDB7EyF+mY=;
 b=GE9rwfHpB156RhzOW3QIE5Ib1NCYfB6ocjrsr9h85Z64UFXD2joZMNqo9BS8hoswAb0h
 eMAxHh82iy8Lv4rluHpal9wg9+RaKQScBCSecygwBgnvkAUZM5sU43iqnz7VygBHop2T
 TINkuaZH8bLj30vUyrvPfBAT8pE1KIIobZBEHu7eel+2Pquec3TPNQb0ILLZLbp+DKHb
 xtA5NBfYliCuVi3kGxugHBhIpxC8E3jeBWUn/osSIotdpHia9oVvnqfNIHWWMVTnVeIO
 +7ivXGGQbsVKWghtSxPgDA6HW2/f8n+wupQ5UMy8PdvoRMhpBs3EirSgchcpVtLqnphd uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t04etjkwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 04:46:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4klnb052783;
 Tue, 11 Jun 2019 04:46:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 2t1jph7x07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Jun 2019 04:46:58 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5B4kwXe053046;
 Tue, 11 Jun 2019 04:46:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t1jph7wyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 04:46:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5B4kuxl015492;
 Tue, 11 Jun 2019 04:46:56 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 10 Jun 2019 21:46:56 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
 darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
 josef@toxicpanda.com, clm@fb.com, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, jack@suse.com, dsterba@suse.com,
 jaegeuk@kernel.org, jk@ozlabs.org
Date: Mon, 10 Jun 2019 21:46:53 -0700
Message-ID: <156022841356.3227213.6932589992914531998.stgit@magnolia>
In-Reply-To: <156022836912.3227213.13598042497272336695.stgit@magnolia>
References: <156022836912.3227213.13598042497272336695.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110033
X-Headers-End: 1haYhP-006vEl-Hi
Subject: [f2fs-dev] [PATCH 5/6] xfs: refactor setflags to use setattr code
 directly
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
Message-ID: <20190611044653.25dot8E7UF1ByqEb0tiIG_aZA7uGdzrtUlNogxKezSM@z>

From: Darrick J. Wong <darrick.wong@oracle.com>

Refactor the SETFLAGS implementation to use the SETXATTR code directly
instead of partially constructing a struct fsxattr and calling bits and
pieces of the setxattr code.  This reduces code size and becomes
necessary in the next patch to maintain the behavior of allowing
userspace to set immutable on an immutable file so long as nothing
/else/ about the attributes change.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_ioctl.c |   40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)


diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 88583b3e1e76..7b19ba2956ad 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1491,11 +1491,8 @@ xfs_ioc_setxflags(
 	struct file		*filp,
 	void			__user *arg)
 {
-	struct xfs_trans	*tp;
 	struct fsxattr		fa;
-	struct fsxattr		old_fa;
 	unsigned int		flags;
-	int			join_flags = 0;
 	int			error;
 
 	if (copy_from_user(&flags, arg, sizeof(flags)))
@@ -1506,44 +1503,13 @@ xfs_ioc_setxflags(
 		      FS_SYNC_FL))
 		return -EOPNOTSUPP;
 
-	fa.fsx_xflags = xfs_merge_ioc_xflags(flags, xfs_ip2xflags(ip));
+	__xfs_ioc_fsgetxattr(ip, false, &fa);
+	fa.fsx_xflags = xfs_merge_ioc_xflags(flags, fa.fsx_xflags);
 
 	error = mnt_want_write_file(filp);
 	if (error)
 		return error;
-
-	/*
-	 * Changing DAX config may require inode locking for mapping
-	 * invalidation. These need to be held all the way to transaction commit
-	 * or cancel time, so need to be passed through to
-	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
-	 * appropriately.
-	 */
-	error = xfs_ioctl_setattr_dax_invalidate(ip, &fa, &join_flags);
-	if (error)
-		goto out_drop_write;
-
-	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
-	if (IS_ERR(tp)) {
-		error = PTR_ERR(tp);
-		goto out_drop_write;
-	}
-
-	__xfs_ioc_fsgetxattr(ip, false, &old_fa);
-	error = vfs_ioc_fssetxattr_check(VFS_I(ip), &old_fa, &fa);
-	if (error) {
-		xfs_trans_cancel(tp);
-		goto out_drop_write;
-	}
-
-	error = xfs_ioctl_setattr_xflags(tp, ip, &fa);
-	if (error) {
-		xfs_trans_cancel(tp);
-		goto out_drop_write;
-	}
-
-	error = xfs_trans_commit(tp);
-out_drop_write:
+	error = xfs_ioctl_setattr(ip, &fa);
 	mnt_drop_write_file(filp);
 	return error;
 }



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
