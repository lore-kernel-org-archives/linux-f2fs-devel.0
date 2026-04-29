Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082B8CCFA13
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XsWRT75owujys9NQS/Zwb+STQ0FewAZvfD81lyqwzB8=; b=PHIZCbiRtFjcrEAjY8r7zxvVlP
	55mf+WYVMIKt/aW1t6Ikr74eeuQ8nZzlxphGFXdlEl1VAXLqLcT6o3gvYX0AHUxhbr2F89HuiGk0f
	5CndwABBeDnPRcHbFotD7bHqfTsuYEWHYX6pFf31dRvOqA7J6KrLRTE1uTN+EMs4a+DM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wI9KJ-0005I0-UC;
	Wed, 29 Apr 2026 18:08:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wI9KJ-0005Hn-4t
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 18:07:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7kMLjVvCrBo82w2GXtMzNzpVBCvFgjFVn8e4IF45Drg=; b=MqkQGHyix0iZq/mdS47B+JYoP2
 Nu8Qggi7XetG36Kp3ScsPDpCnYjJZiqdoPhmzG47oBgkXHUETcWwggDZ4c0h5C4DlRYl1EQC/3Fob
 tM4Ff0BKsfM+L/N9jM9NWJCxhSfhquzjHJVGsjLE3T3gRWK1aZFQXX1Ns9N2MN4Q+Zd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7kMLjVvCrBo82w2GXtMzNzpVBCvFgjFVn8e4IF45Drg=; b=YQQaom7iq2bdBS6IHmCY8tw61g
 GFMjvi6q3kuBw8vhCqrOKN/ItVyEF8RTuc0D7aKRNukIt+Kgw9dyT33w/9CnpxwVUT7PzzKF68w3/
 cwshskac+1HdBCEo0EVUVPz5LawSjP/J09+PtNsQf/G+U1k1NWDcWyAcmJ0zmOFA2Yxk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wI9KI-000162-W4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 18:07:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 692DE6111B;
 Wed, 29 Apr 2026 18:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F309EC2BCC7;
 Wed, 29 Apr 2026 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777486068;
 bh=29KDob7D6wjAqke0cQHbkTiX/VafLuHXAnmywDOdkA0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QwkTphSZuuJKpR7RpMeiB0Di0S7+PZoPDpqd0FtYs5HP+1/knzIVollqTZ8cW55BI
 WuT6KATac7Yx0AZz5YSTqjbZZ9EJYgaj2YLep++OxB5GNcozJ3iY3Jr5uTxFkxIjA2
 EIJT3D4GFwEbCreuwEj/+9jUojxfJi5SAMZG9d9hwFE8ZE6nc0HI3XGwc9Ehn+xZmK
 tkUlIbCLU1PQk+4jK7cbW1kdaBr7oYbEoFigSQZr97cGqrMs0yOuRANxlCyhYGLmTf
 ob2/HyYyCy35KuTrOVYnrg/16f7POTQiQBRJ52irPH6WK/yr/YQPs86RE8Z4uvWVlu
 YQ5P+uc7SsbEQ==
Date: Wed, 29 Apr 2026 14:07:19 -0400
MIME-Version: 1.0
Message-Id: <20260429-case-sensitivity-v12-8-8057123bebe0@oracle.com>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
In-Reply-To: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=5XtPWdQD9rNyvcNieFdC0PM+y6dNjGmJfHpo+ZOq7bw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjdqEdk0DF+qfmnWHi3Vt1gR9qIy7prabuO7
 y3XbV2QW4SJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3QAKCRAzarMzb2Z/
 l4SlD/96LAlavdzmgMVHUOE01QsUJl9DHewg8oTZ6kj7D5SwFJyVufOwx7eMhpu+2WqqW7zOB4G
 Tui0AGnVTOSG1QYr8ICcGePPH3yXcblegpIrxTtnNvrZnbqY3WJOWXBfC81l//kp3wmiCuk9Txf
 y4dHVS3lV4PCpICHSEVgUPVOlr09L7JeZzHg+RkrPbEpKUSISDYP1SpNt4EWT2jcrAdQbGNg2GZ
 ksB/ke9b7Zbz4o9dupEuf+Gy5oKlT6iBQ2+eWPIGOf+MqNh7t2oETxoyf7lDqpA9LNqwgkt7t4r
 KxWln+7KglK5JwsI9s29dy/SbJaDMmdpg+tBDqy+tNNOBBX7icTHKbJ6f6P787oSTOCTz5ob5p/
 CgRvp6rmSD82RxQTzRY6I9ZeNaSA/rk2j6BRIooPFRr5UQ/PSPQtGZyVV7+dEuSbGiB2HPuy/E5
 IfdhsOXlnDPECn5lo7uBwtrtR1+YlJYIbTCZO1VXKr68KBM5j/VP8JS0ks/X6IUnVxT5+CE0GCN
 +WdTlJpNQZXXBHzxZWBlsD6QEmsdOVCo+HpWmZsQCobfyPzngM7zDa5BKVZgFzDy9ZE+CWdPfny
 W3Lv2MGA8y3zBY6rY9toT+Qx7IcEmmvGm2dXYXoJOs5qvqsy6W96pRnTSLJhGohNl65a2FjXM77
 3kGKMtAht4DPLtA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wI9KI-000162-W4
Subject: [f2fs-dev] [PATCH v12 08/15] xfs: Report case sensitivity in
 fileattr_get
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem
is case-sensitive. Add FS_XFLAG_CASEFOLD to xfs_ip2xflags()
when the filesystem is formatted with the ASCIICI feature
flag. This serves both FS_IOC_FSGETXATTR (via xfs_fill_fsxattr()
in xfs_fileattr_get()) and XFS_IOC_BULKSTAT (which populates
bs_xflags directly from xfs_ip2xflags()), so bulkstat consumers
and per-inode queries see a consistent view of the filesystem's
case-folding behavior.

FS_XFLAG_CASEFOLD is read-only: FS_XFLAG_RDONLY_MASK ensures
FS_IOC_FSSETXATTR strips it, and xfs_flags2diflags() has no
clause for CASEFOLD so the on-disk diflags are unaffected.
The legacy FS_IOC_SETFLAGS path in xfs_fileattr_set() also
allows FS_CASEFOLD_FL through its allowlist on ASCIICI
filesystems so that a chattr read-modify-write cycle does
not fail with EOPNOTSUPP.

XFS always preserves case. XFS is case-sensitive by default,
but supports ASCII case-insensitive lookups when formatted
with the ASCIICI feature flag.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/libxfs/xfs_inode_util.c |  2 ++
 fs/xfs/xfs_ioctl.c             | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 551fa51befb6..82be54b6f8d3 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -130,6 +130,8 @@ xfs_ip2xflags(
 
 	if (xfs_inode_has_attr_fork(ip))
 		flags |= FS_XFLAG_HASATTR;
+	if (xfs_has_asciici(ip->i_mount))
+		flags |= FS_XFLAG_CASEFOLD;
 	return flags;
 }
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ed9b4846c05f..f8216f74679f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -755,9 +755,23 @@ xfs_fileattr_set(
 	trace_xfs_ioctl_setattr(ip);
 
 	if (!fa->fsx_valid) {
-		if (fa->flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL |
-				  FS_NOATIME_FL | FS_NODUMP_FL |
-				  FS_SYNC_FL | FS_DAX_FL | FS_PROJINHERIT_FL))
+		unsigned int allowed = FS_IMMUTABLE_FL | FS_APPEND_FL |
+				       FS_NOATIME_FL | FS_NODUMP_FL |
+				       FS_SYNC_FL | FS_DAX_FL |
+				       FS_PROJINHERIT_FL;
+
+		/*
+		 * FS_CASEFOLD_FL reflects the ASCIICI superblock feature,
+		 * a read-only property. Accept it as a no-op so chattr's
+		 * RMW round-trip succeeds; reject any attempt to enable
+		 * it on a non-ASCIICI filesystem. xfs_flags2diflags()
+		 * has no clause for CASEFOLD, so the bit is dropped from
+		 * the on-disk diflags regardless.
+		 */
+		if (xfs_has_asciici(mp))
+			allowed |= FS_CASEFOLD_FL;
+
+		if (fa->flags & ~allowed)
 			return -EOPNOTSUPP;
 	}
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
