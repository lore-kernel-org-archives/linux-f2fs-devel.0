Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9ED606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  8 Nov 2026 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OmzaFhHj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ef8dRgNj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WhQRrHOa;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3OA3yJ8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=mZetyWhuh2VwCPz/ZMfloNYQxl+Vxq1lT/M6XrPoLuo=; b=OmzaFhHjqJrksvPvrYe2icZ1oS
	960bq2COnDZomP4xZCSkFZDECsRpaSER539o0WRe+F+Eq4uU5g6BXuHyKuZpuSoVHEiYSxRKu7UU4
	VhhFMCdcMTXrQt0weFB2KYB6VlzjqLd7tyIIT/ybXjONNZ9zUWaOKuL+rZIAGrXIvdPY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPuzW-000000005EA-3A5d;
	Sun, 08 Nov 2026 04:58:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xPuzA-000000005Ds-2q2r
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 04:58:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YZMUNPvQ0rtHsvJc4nk6mZ/thcoAv894KnRs3yMAZ8Y=; b=Ef8dRgNjP7NLvLacVRfnSEzshI
 WZAcc4vv6AXb90c70tEDve1QYb6TQD7XZs6Ld23TIgFJRFkM2tavrOh5DC/ErNG8lOoNrfs6MZBJ4
 2JONhUPNQCmGg0Dvks6bnxUedykkaMC6IV2wb53EPu7ufamQ5ExAQsJU7ZrGA1akC5Aw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YZMUNPvQ0rtHsvJc4nk6mZ/thcoAv894KnRs3yMAZ8Y=; b=WhQRrHOaLsCaTLr3RU2tbMFuae
 g01v01ILvlyiOE8dRaudsMdZV9YS/sAl84rg02P7lwTPBdF0JKhkWfjj0e1TaKHr/kfA9RqEM37S9
 fGa+1COL+NEHqs2r45//9Aqtb+AAFp0PJnSYgVJU8YmHCDdSiwNdVO61jgEb0HhIeQMU=;
Received: from mail-dy2-f2.google.com ([74.125.229.2])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPuzA-000000002gw-0jH4
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 04:58:32 +0000
Received: by mail-dy2-f2.google.com with SMTP id
 5a478bee46e88-327b1d5824fso251874eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 20:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794113906; x=1794718706; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YZMUNPvQ0rtHsvJc4nk6mZ/thcoAv894KnRs3yMAZ8Y=;
 b=U3OA3yJ8vxB9HT5bxIrTGd0zDjtE1AVNLpCVFgNGPIVZ+fDKTbZkgwts0IOkeRFlDz
 H95X7uKKRPm0OqT/8/WAqKhap1u0RRLGkRpgaADLQ7CfjGwcdEu7ZZPQn+p5Se6RI6yl
 CghMRfxEPdgILv7rgQzrHsZuSK8EFQPdgT88UNovMPTTSAfRDXyCIuqxk9c0mYaIhjsQ
 1xzf8mS3aNF+swX3Ki3bQZB9qk2VPzn2CqGFJmRj8zarq2ASat0wN45+l0gxgEJY6GmE
 /XwcAMvV9KKL/kOtLTfGWooMzrmGrzvxTD5WMNqYp2wyXuo+1mJlR8EbAu0G+zgw+Ybu
 Gamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794113906; x=1794718706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZMUNPvQ0rtHsvJc4nk6mZ/thcoAv894KnRs3yMAZ8Y=;
 b=uqxF1WB2TuHb2mkq1jfr4hRNemzOK3YrBsua+w3dMTE7o9a2BmneOfAplTiom+ebaB
 uBdcNqGJo7McRuLSx4g6gzhx2dDJhLErB1fcRMG1NGqGzYF3/fI1oAznhC9Mlh3nz8aS
 myzEDHuVhXi7CGMkcUTrMh4qpEjDI3AHdQWRxYHDG4FPli01PM+JE+I2wR5c4qaD2G/W
 8FbejtlXa2YGzIRz16o3g/r+KQUSkmJzBmRnPUTp3VHddJ2p+9rib5DQoL/VBPCyqVIL
 p4DRAlXw+DGOpz/z10P/40NcmKbf9X8xvKgVQbi2kcJxZERT15VYn1ucNr6Zd6cTu6hS
 0M3g==
X-Forwarded-Encrypted: i=1;
 AL+hErE5tCn91sUTP6MoohMBHRIXYAp/DcsGpGUqX1LepTtUolI+H4H4kVX9K466uGv+jZZABVIHR46lesaMg9EHdJqV@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/7q8BsQP7L6CNUmucBMGCPKP85QaB2tpmhqijIr/FWctmguujS
 mMHRSCtzsR88DCqiE59PKo/EzYblYcMMRMlqkgb4wtPagUEKlxuonA18
X-Gm-Gg: AYBFou3CrgAFnsEx/YB51Z+X7OmkzcjdFeHud6GOiWhPA7ywKsPqX4lQ2b4KVT8xKqf
 +mMG44IC3o343aN7jkviw24H1E/sC+gvrb7tF7EmK/ADdP5ll4Pu01znnuaWUbzhn/+lxFDDCYR
 lvNr/iuAES5Mg7jptUckp1aIKWrUQYxav6f8M55/eAn5glWW6o5pvz6j1aVyftc9s3vhZ/DWCsG
 0Be7xN8kpl46Tfnsc0mvAu/r5xPjmQle04nx1MAKmzntN0YGjvarC9ZHVhcyaoHd6KiVAynbpdi
 3hqBsKFirlogWOy+6fm134O/s7ttp2fG73kUniLnENUa/AforvZCCjlz4BqQXMZ107XXt9UmHwb
 8Ekl69QxQFaXpDh3SOHyo5YrrJXB1A9Jt8shp0gFixkz0Rj5s2f80VuWe/qXiCItb5iikbKR6Nn
 V2St1AnBK1uGZcNhxB3lA7NddvUobgCkp06FYHYF9sC0Zia/IBkG8lPOkJ1Ku+De591lGpF0xFY
 Ar+2gEHj5NJuu1aXFOe+5aXjYnHwf3kL04hSnSoZeAO2LWP7pI3t8c4wNgekIdHV5MyVkxGpeOP
 EfpuIiwTgqS3/k5rRHy0EWq7mfYa8W5R0BjIE5OX+IxY+Cu5HwtHmWEDycuHKu2b8sZWDSvLWfu
 If0wZw18NEb7fU3eVhtOca049IdnVqtVjxv0U5A==
X-Received: by 2002:a05:7301:182d:b0:351:2958:1740 with SMTP id
 5a478bee46e88-3725ef0fdd0mr1483806eec.37.1794113906404; 
 Sat, 07 Nov 2026 20:58:26 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265618e11sm2471388eec.7.2026.11.07.20.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 20:58:25 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun,  8 Nov 2026 04:57:22 +0000
Message-ID: <20261108045722.12091-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xPuzA-000000002gw-0jH4
Subject: [f2fs-dev] [PATCH] f2fs: require inode ownership for ioctls that
 change per-file state
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, dennylin0707@gmail.com, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

F2FS_IOC_RELEASE_COMPRESS_BLOCKS, F2FS_IOC_RESERVE_COMPRESS_BLOCKS,
F2FS_IOC_SET_PIN_FILE and F2FS_IOC_IO_PRIO change the state of the inode
behind the file descriptor without checking who the caller is. Any user
who can open a file, even read-only, can:

 - release its compressed blocks, after which writes to the file fail
   with -EPERM until the blocks are reserved again or the file is
   truncated to zero;
 - reserve released blocks again, which consumes free space;
 - pin it while it has no data blocks, after which writes that extend
   the file fail with -EIO;
 - unpin it, so that garbage collection may move blocks that a user of
   F2FS_IOC_SET_PIN_FILE expects to stay in place;
 - set its write I/O priority hint.

F2FS_IOC_SET_PIN_FILE checked inode_owner_or_capable() when it was
added. Commit aff7b628ac2d ("f2fs: set pin_file under CAP_SYS_ADMIN")
replaced that with a CAP_SYS_ADMIN check, and commit b13bdf03bb80
("f2fs: allow all the users to pin a file") then removed the
CAP_SYS_ADMIN check, leaving the ioctl without any permission check.

The atomic write ioctls require both FMODE_WRITE and
inode_owner_or_capable(). Requiring FMODE_WRITE here would break
f2fs_io, which releases and reserves compressed blocks through a
read-only file descriptor, and Android, which releases them the same
way. Require only inode_owner_or_capable(), as F2FS_IOC_SET_PIN_FILE
originally did, so that only the owner or a caller with CAP_FOWNER can
change this state. Users can still pin their own files.

Fixes: b13bdf03bb80 ("f2fs: allow all the users to pin a file")
Fixes: ef8d563f184e ("f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS")
Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
Fixes: 5f95c1812a65 ("f2fs: add ioctl to get IO priority hint")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e2c0f5083313..0730de36554a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3664,6 +3664,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	if (!pin && IS_DEVICE_ALIASING(inode))
 		return -EOPNOTSUPP;
 
+	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
+		return -EACCES;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -3982,6 +3985,9 @@ static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
 	if (!S_ISREG(inode->i_mode) || level >= F2FS_IOPRIO_MAX)
 		return -EINVAL;
 
+	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
+		return -EACCES;
+
 	inode_lock(inode);
 	F2FS_I(inode)->ioprio_hint = level;
 	inode_unlock(inode);
@@ -4235,6 +4241,9 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
+		return -EACCES;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -4430,6 +4439,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
+		return -EACCES;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
