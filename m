Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06EFC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Oct 2022 17:14:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oflUe-0005EK-Ew;
	Tue, 04 Oct 2022 17:14:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1oflUc-0005ED-V9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Oct 2022 17:14:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PYCyywZT6ftdRPOM7ZXXbKbjWKsJ8VloyXxLwNUq5G0=; b=LMk50kmFHWxChPnmEMeB0efozI
 8B5KeOXksaNkXIKhVs+TVGH8m5jLA0X8h7afgEfxf95pLIPKSlu0GQIiiqcdsMnDYfUtlm/ZfRI/1
 QTe5e99ziMEab/e8XQrQSJJk2HgLv4ruMm8IAMbiOn7rQePn5CRHjPbwkC2/Y5Eklotk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PYCyywZT6ftdRPOM7ZXXbKbjWKsJ8VloyXxLwNUq5G0=; b=S
 TrSyqA2085Ou7RYgzb9rMkiDeGFVhgjGtdMwwGi7VkroQFx1s/whkhNDRcRXoxEnPdaag38GWDuDf
 OXxEqSvBsxDs5jJmH75APdN7D5cO7QWJ3CupnQoKsd5IyAflrSHP1nz3+uqw0Av7lOj9l98UzToPi
 gfcU6oDbUMQEhi48=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oflUb-0007Yv-63 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Oct 2022 17:14:06 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 h8-20020a17090a054800b00205ccbae31eso19183853pjf.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Oct 2022 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=PYCyywZT6ftdRPOM7ZXXbKbjWKsJ8VloyXxLwNUq5G0=;
 b=ghPLYi/JsyDHmKRCK5x6OHyRibakp6F4bYSDW7w5ljt6u1j79hU/9t48HM2ufKeHDH
 unAQ6Xr54uKxL3yYGVcMpr0EX5PY+uH1l2sZRACGbDj1wHPAXFoLxVSq2doRqkRTasdy
 Aa5gR+AslNi7Fw8g6K7WVXj4l+nBOQEptKWNjtEHDXJqEaUbuttHPnPTyLP758dUWxYh
 SGIGIXkvBimZ9+zUFUu2stgSD7cqiyaAqh2AhBBA79kn2iUk0M1eWgIpvbbSxQ9GfAvS
 cipOje372J0xC1AYIA5soIu5aMub/UvGvxPIzrpIhyA4RY53fJVs9AGJDFw3foDIODSJ
 BqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=PYCyywZT6ftdRPOM7ZXXbKbjWKsJ8VloyXxLwNUq5G0=;
 b=FcMYW2nPkqXLZRlL0GVqfPOCeotqJWapcakNqqA/kWvtMMRoFj6IEM7YteSXArW/B2
 oXv/Jkgmb2gDXbmiUg5p+uI/0je2Yn1nh7hV5feaKtaC6KDdLsE83qH9ZEzg9unpQfsc
 2YGHK4hFrtcTQNCnxBseR8Bhn/XASSIlma2BaPma8F9VncDkQV+WzSQNDDKqggjFYEI/
 i1NHrAcY1lJb7gj0JUygVw+vnbCHCZxfhYMYJRZtqk6M2WRE85yb4pQElvU+Ruqk40h5
 iZ+QcPWWBgJu6+A3Imzp+Is8KgrP2oWYw4MXQp1ZYqp6smkjd5gZJrv6gNZaPfwhCqrs
 sOpw==
X-Gm-Message-State: ACrzQf2WCh2YPz64m1pdmJ1NNLVM+L+5jwWBuH3N3H0D1DMaIW4FOKIA
 58+bn/IOGUAwCq9N2shGZHD+D63crvw=
X-Google-Smtp-Source: AMsMyM7RD04daD0gBltLyYgFEJhdeWY6S5ZMC5vSK+qCZHjtkD5USX1xtkjiM3Ayq0iJTK+0SX1CHQ==
X-Received: by 2002:a17:903:41cc:b0:176:d89d:63e3 with SMTP id
 u12-20020a17090341cc00b00176d89d63e3mr28098401ple.31.1664903639539; 
 Tue, 04 Oct 2022 10:13:59 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:9291:ff24:9df5:5be7])
 by smtp.gmail.com with ESMTPSA id
 p63-20020a622942000000b00561c55c56a7sm1683693pfp.94.2022.10.04.10.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Oct 2022 10:13:57 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  4 Oct 2022 10:13:50 -0700
Message-Id: <20221004171351.3678194-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
X-Headers-End: 1oflUb-0007Yv-63
Subject: [f2fs-dev] [PATCH v4 1/2] f2fs: correct i_size change for atomic
 writes
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

We need to make sure i_size doesn't change until atomic write commit is
successful and restore it when commit is failed.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v4: move i_size update after clearing atomic file flag in
    f2fs_abort_atomic_write()
v3: make sure inode is clean while atomic writing
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    | 18 +++++++++++-------
 fs/f2fs/inode.c   |  3 +++
 fs/f2fs/segment.c |  7 +++++--
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dee7b67a17a6..539da7f12cfc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -821,6 +821,7 @@ struct f2fs_inode_info {
 	unsigned int i_cluster_size;		/* cluster size */
 
 	unsigned int atomic_write_cnt;
+	loff_t original_i_size;		/* original i_size before atomic write */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5efe0e4a725a..ce2336d2f688 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1989,6 +1989,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
+	loff_t isize;
 	int ret;
 
 	if (!inode_owner_or_capable(mnt_userns, inode))
@@ -2047,7 +2048,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 		goto out;
 	}
-	f2fs_i_size_write(fi->cow_inode, i_size_read(inode));
+
+	f2fs_write_inode(inode, NULL);
+
+	isize = i_size_read(inode);
+	fi->original_i_size = isize;
+	f2fs_i_size_write(fi->cow_inode, isize);
 
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	sbi->atomic_files++;
@@ -2087,16 +2093,14 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	if (f2fs_is_atomic_file(inode)) {
 		ret = f2fs_commit_atomic_write(inode);
-		if (ret)
-			goto unlock_out;
-
-		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 		if (!ret)
-			f2fs_abort_atomic_write(inode, false);
+			ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
+
+		f2fs_abort_atomic_write(inode, ret);
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
-unlock_out:
+
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cde0a3dc80c3..64d7772b4cd9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -30,6 +30,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
+	if (f2fs_is_atomic_file(inode))
+		return;
+
 	mark_inode_dirty_sync(inode);
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 460048f3c850..abb55cd418c1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,14 +193,17 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
-	if (clean)
-		truncate_inode_pages_final(inode->i_mapping);
 	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
 	iput(fi->cow_inode);
 	fi->cow_inode = NULL;
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
 
+	if (clean) {
+		truncate_inode_pages_final(inode->i_mapping);
+		f2fs_i_size_write(inode, fi->original_i_size);
+	}
+
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	sbi->atomic_files--;
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
-- 
2.38.0.rc1.362.ged0d419d3c-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
