Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E71C3DA6E
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Dec 2023 08:12:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rEmFn-00062c-BR;
	Sun, 17 Dec 2023 08:12:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eadavis@qq.com>) id 1rEmFj-00062J-D7;
 Sun, 17 Dec 2023 08:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0lB3OyYqJUjufHeb9cN7xRSKf7npEOsy2UKslyIKn88=; b=I2yprsWQu3xyFeeYVolipdHamf
 fNNKPiXefDdpPuA63CNW4Qv35PFC0mnDy352fE8bkeh/HLYD1rv2hdq0fsofNoyOZMdIDdRFp+IDo
 NBZoSiMXIHdc5Dsh5qsCPm16pDv0zbJyaF4Vk8FX2zrLeY3ufqex7p+7aUMNtgNmElV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
 Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0lB3OyYqJUjufHeb9cN7xRSKf7npEOsy2UKslyIKn88=; b=F6NFwH4DxQn2BRcuG7okv4z4Pa
 SN1OZlrmTsKBEMZiX9KHR7JmhP+AJce5qZRPk7LoSBK0yc8vZuaHwB/3BGfyXIM7heHJYTkIRVGvC
 2wUFhCoZiuYO2pjIyfC266JOsmY2aurXjK26885aD4P8sXyUg5qP/QIZq8zh0IK3MzGA=;
Received: from out203-205-221-173.mail.qq.com ([203.205.221.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rEmFd-00008W-VJ; Sun, 17 Dec 2023 08:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1702800690; bh=0lB3OyYqJUjufHeb9cN7xRSKf7npEOsy2UKslyIKn88=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=txr8y+QwTQkFBqSm/CMDUKLV4pWVEiePGSlfeRU7pEPuGJPqyrP3KUm1viUJCdy73
 2Z8owJ5vW17xh8K86POQw4Dibc2pDvk8grxccwV8L5vQQ8o9BweiekN4zWI8MiRNhz
 TVsJlVLIK9g7Hy94TzfTETbiuWcnkgkVXwFJzPF4=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
 by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
 id 2DA082F6; Sun, 17 Dec 2023 16:11:26 +0800
X-QQ-mid: xmsmtpt1702800686t9z4b36nq
Message-ID: <tencent_4E2FCFC90D97A5910DFA926DDD945D9B1907@qq.com>
X-QQ-XMAILINFO: NFcI4DQTV9fmkt9lUNi7+Jvn0ZFoqP30SGNnowiDA+zmTz+Hl5PeBJctWLwk4q
 tcupdaW6dKq65J5Ks6Gglo2JKNCYzQZwrRWB+GtECzk64+G/ZJ4Ch2dz4mpLbeKH+OgSrI1sAQEY
 Cf1SiWelvQTp6dzLrYv82lz/kfx5R2+LjdAASeRXVZuZcLzHOKh3jTHe6MzS/06eL/wik+Lz1CnX
 C6WBYLA37g5yo6+K4yrPDYGlGpVna7tmy4yAzKYjJS3OCr3mCbF//Dy8htBFRtJce11C1oJp4tBD
 0NUZDNCqUIcuOHthKKbkX4kf7k4jsq9QeRICVCPqq7m2FR+6MgSJ8jIJEUWclgNLrMTG8K+jQ6d/
 R0j5AuJX3zGwTYBj7VMigzjWIU4XqidkYYUDViPVpVyDnPBCHdaU0SknQij33jrjos8Hs3hVL0KX
 0mzsk6XdTJDKJN9e/ogA6lx7Wt9b9AMAjObNGZN07ajUnP+JYod3QLp+h9QuVqUo4KWbw3B0SkrB
 r0OClW4YTS5mfYAvUYfkoEWbhimuLOsPwEe49SSDed89yORqEcGiDKhIuVLOh2lLaECxAH7uFzqk
 x36G5+clgulmST+sGWuHoHIn2ZoPZLC+CVtRYcVkUdkzo7ml4UmBnFvM7daiTDGqcT8Ay1PYV1am
 BVNX3VqnmQoJoJF4NIPwWOkq1zpl24t7l3yz+uqEtIb8bPP3uL2xSeqBd3P2tlQojigcQZiCpQS8
 PP55aKry719AoI3VECLwe1cxx4mk/2pkncOxJypkw8PWMdPSLnu1cBAp8NXu8hYQJMSOpTwWhT4D
 auLGerAf7mTf1IpWNeyTE7Xqw1kGDMahycg3kSFsFGlVsFKi69wPcf6EOKYSMoJOMcbMVPi1DZKY
 MPnCh0UFZ4UfcC7U581K//XYicuUrH2pK09azcl80H2N5c0nX0L11jtHB5Nq/hPft0VY7tLglw
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
To: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com
Date: Sun, 17 Dec 2023 16:11:26 +0800
X-OQ-MSGID: <20231217081125.4138340-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000003362ba060ca8beac@google.com>
References: <0000000000003362ba060ca8beac@google.com>
MIME-Version: 1.0
X-Headers-End: 1rEmFd-00008W-VJ
Subject: [f2fs-dev] [PATCH] ovl: fix BUG: Dentry still in use in unmount
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
From: Edward Adam Davis via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Edward Adam Davis <eadavis@qq.com>
Cc: squashfs-devel@lists.sourceforge.net, reiserfs-devel@vger.kernel.org,
 amir73il@gmail.com, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 terrelln@fb.com, viro@zeniv.linux.org.uk, phillip@squashfs.org.uk,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

workdir and destdir could be the same when copying up to indexdir.

Fixes: c63e56a4a652 ("ovl: do not open/llseek lower file with upper sb_writers held")
Reported-and-tested-by: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/overlayfs/copy_up.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..ae5eb442025d 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -731,10 +731,14 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		.rdev = c->stat.rdev,
 		.link = c->link
 	};
+	err = -EIO;
+	/* workdir and destdir could be the same when copying up to indexdir */
+	if (lock_rename(c->workdir, c->destdir) != NULL)
+		goto unlock;
 
 	err = ovl_prep_cu_creds(c->dentry, &cc);
 	if (err)
-		return err;
+		goto unlock;
 
 	ovl_start_write(c->dentry);
 	inode_lock(wdir);
@@ -743,8 +747,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_end_write(c->dentry);
 	ovl_revert_cu_creds(&cc);
 
+	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
-		return PTR_ERR(temp);
+		goto unlock;
 
 	/*
 	 * Copy up data first and then xattrs. Writing data after
@@ -760,10 +765,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * If temp was moved, abort without the cleanup.
 	 */
 	ovl_start_write(c->dentry);
-	if (lock_rename(c->workdir, c->destdir) != NULL ||
-	    temp->d_parent != c->workdir) {
+	if (temp->d_parent != c->workdir) {
 		err = -EIO;
-		goto unlock;
+		goto unlockcd;
 	} else if (err) {
 		goto cleanup;
 	}
@@ -801,16 +805,18 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+
+unlockcd:
+	ovl_end_write(c->dentry);
 unlock:
 	unlock_rename(c->workdir, c->destdir);
-	ovl_end_write(c->dentry);
 
 	return err;
 
 cleanup:
 	ovl_cleanup(ofs, wdir, temp);
 	dput(temp);
-	goto unlock;
+	goto unlockcd;
 }
 
 /* Copyup using O_TMPFILE which does not require cross dir locking */
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
