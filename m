Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A48C3DA64
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:14:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sbKxY-0005Xp-Cz;
	Tue, 06 Aug 2024 14:14:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jannh@google.com>) id 1sbKxX-0005XG-F6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Aug 2024 14:14:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mNJXmqdg/wrODcSMNLZaLEyt49+/cc65vl/68WJpwIU=; b=ENavTWWfwOLdGfn41xx/qr4Wqx
 TyCS2FAUv238/oS0aN1alE6yAXq2C/dslO+nEg48w/dBdbgqiiCAEfq0wlpmac798KhCGjccZ9YK0
 QWsj1hrXRpytXrcfpQinj6hW3/jZls1WZllDlKCjhaYdsHNm/BcZlHMcOo2Wo+PNc91s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mNJXmqdg/wrODcSMNLZaLEyt49+/cc65vl/68WJpwIU=; b=J
 4VOyg2v3FGpde8sOmi/3TPDHdVmsGjZxPh/nbwaFBcCfddeyVRjWuH+2cCbG6U5ZGtSKoU4ZUDo5L
 3uO62GUFZq1v0kzcE/hc29VSRIbWgjGJi2Q3zURHNQazriTCUc6qU7kP7GdmV8S5z0H81dXu/aAFL
 +oJruYScgbv/RROM=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sbKxX-0006jU-Ch for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Aug 2024 14:14:44 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-5b9fe5ea355so15142a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 06 Aug 2024 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722953677; x=1723558477;
 darn=lists.sourceforge.net; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mNJXmqdg/wrODcSMNLZaLEyt49+/cc65vl/68WJpwIU=;
 b=EfRiOyyVAuYGo+ZIeWsE1ET4AmiDCbQvTcKMBN32BGHhaZgWak2GMTkstImauwaNB2
 7HvdQ3oqWSBDI90PNjR8dEhATSR/Ke/lUZWiLntq9C2I2IjUIHW2ZNeOU9D8AdX0GaLu
 EU1Qmy1QQYC0QilYRoDG+ga+1xxLd1Zz2ukS8kDBYAvp3C7ZXNbbdfE6hN50WehHEM2v
 eA3IuQ0t9VgSCM/T5ZDjbLMOicb2765qEh2iAWoRwebJC596AlLGoCwZ0xhyc6ADiMfo
 d9ho/mF295NSce8rknX/DfpWRAFAVDcswjMDgi74tcnJYlS0/pxIqTSs+g8/KKOp4Qcq
 XVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722953677; x=1723558477;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNJXmqdg/wrODcSMNLZaLEyt49+/cc65vl/68WJpwIU=;
 b=UbFUH4rDxG3ZuvixEd5mi7urOoK6m1Gbx3M3U1KPfZyB4MIyN1wchaKeVrMSfs7yav
 oQScygLW3lO+FTPT/RBXWqBNe40tZD9kXJT8M3cAKNwMUs9IXixDAM8ttAF0Z9cbUQvl
 Gd+tyuk8qXDWGk6eRhmgutPNlQwG0gWBB/YnBqXn+/3sQ39l60iUTv0VtHFoVFXEfG3e
 eu4nv5PAfDtzkMuYz1SLQY+ogXSIjzm5+WrgH4xY+2htWI2jJI03RLntfFJEFYLjwK1a
 R6bpHG9x1bkWS22KGMKE2n6uXeigtT9yKM5Ea78Hd5OdMB+KQkNg6cJ9dtLqMWVF6iFs
 TAKg==
X-Gm-Message-State: AOJu0YylyTUoBMeSmDsmXEENthamq68Z+7UHCw/U2aQo54JAa3d1ZHez
 6r4//RcQzSeckB7Qzy2cV2BhtSgNUyNGOJal0Et+v2Xr2z99eSnC3JH91ATltbO7pw6ElfT/EI7
 qULHZ
X-Google-Smtp-Source: AGHT+IEjnmj/9A++4g9dfV6Pp5GNvDhemkB90CQw2gg7OgKrBntYsLFfW3sjJJPh92DYzEUk/xDxtQ==
X-Received: by 2002:a05:600c:34cc:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-429008aeed2mr671265e9.1.1722953247161; 
 Tue, 06 Aug 2024 07:07:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:5649:bc4b:84ff:8e24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a862sm245809365e9.4.2024.08.06.07.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 07:07:25 -0700 (PDT)
Date: Tue, 06 Aug 2024 16:07:16 +0200
MIME-Version: 1.0
Message-Id: <20240806-f2fs-atomic-write-v1-1-8a586e194fd7@google.com>
X-B4-Tracking: v=1; b=H4sIABMusmYC/x3MTQqAIBBA4avErBtQk/6uEi3ExppFGRoViHdPW
 n6L9xJECkwRxipBoJsj+6NA1hXYzRwrIS/FoITSohctOuUimsvvbPEJfBGSkIPRXa+ahaB0ZyD
 H7/+c5pw/6hSYXWMAAAA=
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722953241; l=2816;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=ZXE8YRwRjRlnWnbKZwcnN363Dx2ojCKLeGL5iZ9KS0A=;
 b=SxfzSCKBN2CpOmUQWWZjQ5m95ZMD/8Nc/Bg14dR57k3AQ9SY3Tax9bjw9lERq5jyGZ+VNKsFd
 ifymP+MITBHAOG7F4Nz5fmKNmyoz1AZJSdbipNYf16uAOKdf1JpdDtw
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Headers-End: 1sbKxX-0006jU-Ch
Subject: [f2fs-dev] [PATCH] f2fs: Require FMODE_WRITE for atomic write ioctls
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
From: Jann Horn via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jann Horn <jannh@google.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The F2FS ioctls for starting and committing atomic writes check for
inode_owner_or_capable(), but this does not give LSMs like SELinux or
Landlock an opportunity to deny the write access - if the caller's FSUID
matches the inode's UID, inode_owner_or_capable() immediately returns true.

There are scenarios where LSMs want to deny a process the ability to write
particular files, even files that the FSUID of the process owns; but this
can currently partially be bypassed using atomic write ioctls in two ways:

 - F2FS_IOC_START_ATOMIC_REPLACE + F2FS_IOC_COMMIT_ATOMIC_WRITE can
   truncate an inode to size 0
 - F2FS_IOC_START_ATOMIC_WRITE + F2FS_IOC_ABORT_ATOMIC_WRITE can revert
   changes another process concurrently made to a file

Fix it by requiring FMODE_WRITE for these operations, just like for
F2FS_IOC_MOVE_RANGE. Since any legitimate caller should only be using these
ioctls when intending to write into the file, that seems unlikely to break
anything.

Fixes: 88b88a667971 ("f2fs: support atomic writes")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 168f08507004..a662392c5d8b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2117,12 +2117,15 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
 	loff_t isize;
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
@@ -2225,12 +2228,15 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 static int f2fs_ioc_commit_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2257,12 +2263,15 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 static int f2fs_ioc_abort_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;

---
base-commit: b446a2dae984fa5bd56dd7c3a02a426f87e05813
change-id: 20240806-f2fs-atomic-write-e019a47823de
-- 
Jann Horn <jannh@google.com>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
