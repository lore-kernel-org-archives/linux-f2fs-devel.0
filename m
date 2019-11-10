Return-Path: <SRS0=wBWF=ZC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB72AC17443
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 Nov 2019 02:48:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8CC2248F;
	Sun, 10 Nov 2019 02:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="gNUdZkqy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SJZtSUoC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsvfKzBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8CC2248F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iTdGr-0006l5-N5; Sun, 10 Nov 2019 02:48:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1iTdGq-0006ky-4G
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 10 Nov 2019 02:48:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pI/xjKgAESe/QeoXOwDrTM8AcydSVw6lBflgw9povUc=; b=gNUdZkqytWNwYo61Tc9cf3TIul
 RVXyB+/FpEy9smi9abuzfCow+P0CcPsjj4WG2i2aIk5xlBDju3Dvnfuv6G2BF53xW7V9/0bHBXZkE
 42IMgjMUDo7bxYJHoHxsBFfK8BKPO/1AFwF1IafUuWzOpOtg5aiAjr4Hu4kfRxu2Mo28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pI/xjKgAESe/QeoXOwDrTM8AcydSVw6lBflgw9povUc=; b=SJZtSUoCRhBCj+h9HcBRGaVO1S
 BWrkolmYW9bj7y8eV5j/pi4zBBS1UwQ8aab9JCrhqwgTWUwvmkUiVIUnE5UfVaZ6pQi30ejswvARS
 ISyZkG9AEythx9bcILK0J0C4DqSb4lOs3uqMqbZZwamR9kYVDtR1DWB9u8eGZ5t9O03k=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iTdGp-00CSwo-24
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 10 Nov 2019 02:48:08 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7D782248B;
 Sun, 10 Nov 2019 02:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573354080;
 bh=bVMv+VSCtv3ibr0RRhSJn4llcPqadPJWMmNcIO/xb9Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EsvfKzBDxQQZrEo2AkP8R+rKObrU2pXqzzj9OPoyhj2SYV2N9i6DaxRhpu7ERsvFR
 TqpgdufAkJfIEWe5VogHErVB3V/0YC299QnKkVzj+k99/O8fCoYhPKjl7M9varKO20
 zbpqGo+0+1a00T7pAGNZO9HGe4gavsvsVyWkXBic=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Sat,  9 Nov 2019 21:45:10 -0500
Message-Id: <20191110024541.31567-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1iTdGp-00CSwo-24
Subject: [f2fs-dev] [PATCH AUTOSEL 4.14 078/109] f2fs: fix to recover
 inode's project id during POR
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit f4474aa6e5e901ee4af21f39f1b9115aaaaec503 ]

Testcase to reproduce this bug:
1. mkfs.f2fs -O extra_attr -O project_quota /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. sync
5. chattr -p 1 /mnt/f2fs/file
6. xfs_io -f /mnt/f2fs/file -c "fsync"
7. godown /mnt/f2fs
8. umount /mnt/f2fs
9. mount -t f2fs /dev/sdd /mnt/f2fs
10. lsattr -p /mnt/f2fs/file

    0 -----------------N- /mnt/f2fs/file

But actually, we expect the correct result is:

    1 -----------------N- /mnt/f2fs/file

The reason is we didn't recover inode.i_projid field during mount,
fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index adbf2600c0908..87942cf2afe1f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -203,6 +203,19 @@ static void recover_inode(struct inode *inode, struct page *page)
 	inode->i_mode = le16_to_cpu(raw->i_mode);
 	i_uid_write(inode, le32_to_cpu(raw->i_uid));
 	i_gid_write(inode, le32_to_cpu(raw->i_gid));
+
+	if (raw->i_inline & F2FS_EXTRA_ATTR) {
+		if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)->sb) &&
+			F2FS_FITS_IN_INODE(raw, le16_to_cpu(raw->i_extra_isize),
+								i_projid)) {
+			projid_t i_projid;
+
+			i_projid = (projid_t)le32_to_cpu(raw->i_projid);
+			F2FS_I(inode)->i_projid =
+				make_kprojid(&init_user_ns, i_projid);
+		}
+	}
+
 	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
 	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
 	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
