Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFA8C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Oct 2022 00:11:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ofVWh-0003Pe-2S;
	Tue, 04 Oct 2022 00:11:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1ofVWe-0003PY-AZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Oct 2022 00:11:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=16INUo0jrPPKZ9/RSm6pqWnMygsgztFX9XK3QEK3JRI=; b=XPwGlXQ9bSk3ToWvIY0M6FaZHZ
 7V8EpIWvdiJZdOcpHaWwkThKqACUIMBRokUrIEy2DxjJ/yQIALPrfx0oZeZ9XFJbv+8B9R/XtxSxa
 RoWZ+lDaAqVoe2HotXDjSBXRNr/MWzj61AhumC0zJE5OJdBt8Nqp6DK3gTCobHmcqB44=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=16INUo0jrPPKZ9/RSm6pqWnMygsgztFX9XK3QEK3JRI=; b=X
 FWPIFwbM5VH8oh+UJpb2Dv8zcRmpW/QtqjyNygPd5D6RF+nROwF82HN+1/xkPtOpBZzLJUruu1g5T
 5D0V07/n8p7Ldsoh0yUz1s5RsNY4LTYcaZkyqfeCrM+eCjRi5XNwGWDfD18iRLCeLuwLNyyYahgiG
 Pz7/OKzE6l/v7nLU=;
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ofVWZ-0007Iz-TQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Oct 2022 00:11:08 +0000
Received: by mail-pl1-f181.google.com with SMTP id z20so4582176plb.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Oct 2022 17:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=16INUo0jrPPKZ9/RSm6pqWnMygsgztFX9XK3QEK3JRI=;
 b=WfCsLjBbRrGkzH9yp8MyYT0A1FJSvw1JeetXXhKLV9cvZ4iyeynjabjzL58+YK8JGj
 Lr9Bo2q4qgT5JG7CF2B4BzrGO5euGv+mqcZuseNP7XitXDdKfYkuKUwMFXCOh/3rsAB4
 84adNy5VPDOeR8ydG/ekz5/DuljbHyEmelne/lXwswpbu24QljG7Y6hdjzoiMZiPp2Gh
 +eDSvfsfjVgKtnW3V7cBq2EQxsLpSZYYeyQ0TpnzaAXylTjyB1MgSmvoM05MJTxMaB/N
 ChRzN/BZqiIsr/OvEjcUO7yMUKzAxwEiuUMqP4F/nmOd+mGQSqwrJ9oaTvc5BWhZzSe9
 DQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=16INUo0jrPPKZ9/RSm6pqWnMygsgztFX9XK3QEK3JRI=;
 b=pWmPOVR5FXSYk7qLQYaw7vVrSSO880F/jABxoayccX1ZpZ3X1maVXRgcB+Xxx0ypNE
 ApfGH3b8TEzDB0cI/o0gZ33fM4i+7Qtnl78CMIizb5met9xXL5/CfZq77AvFoEZYsVx/
 bB0u0n4DDIxGqgueii4AmLbw7aK/RLPxJXpAdqV9Hgg4r675dHiTF5o+HMubPLf09kVc
 KV2h7bmPCZstnRTMBi4tbtB5KuZZYZRuCqPpGaUxuRpAC5/tDwS090vSQEY3JTQRov2L
 An8m0tq+do2yPjEiwxIzEKb9vZqlMlXgeex7NRqQ6AWB+9/L64Ib6DApP/i6r/Kup7Bi
 M3qA==
X-Gm-Message-State: ACrzQf3mcPzSBicDqZWGoR1xUAWNh9yCSH6y3xP9yoVVWI7u9IhQ/l/U
 NS8XVlQtRuUdKx+n8Q4gixw=
X-Google-Smtp-Source: AMsMyM7P3e+GmxpqrOcvlMQLS2AzrQVlwWBaMYBCNv7Z4v2khW0uJZTDZCc0akeawdINZMDUUWLR6w==
X-Received: by 2002:a17:903:2412:b0:178:796d:c694 with SMTP id
 e18-20020a170903241200b00178796dc694mr24590851plo.42.1664842257453; 
 Mon, 03 Oct 2022 17:10:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:3d16:3dd7:b030:41a5])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a626d03000000b0052dfe83e19csm8266974pfc.16.2022.10.03.17.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Oct 2022 17:10:57 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  3 Oct 2022 17:10:49 -0700
Message-Id: <20221004001050.3269377-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
X-Headers-End: 1ofVWZ-0007Iz-TQ
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: correct i_size change for atomic
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
v3: make sure inode is clean while atomic writing
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    | 18 +++++++++++-------
 fs/f2fs/inode.c   |  3 +++
 fs/f2fs/segment.c |  4 +++-
 4 files changed, 18 insertions(+), 8 deletions(-)

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
index 460048f3c850..143b7ea0fb8e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,8 +193,10 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
-	if (clean)
+	if (clean) {
 		truncate_inode_pages_final(inode->i_mapping);
+		f2fs_i_size_write(inode, fi->original_i_size);
+	}
 	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
 	iput(fi->cow_inode);
 	fi->cow_inode = NULL;
-- 
2.38.0.rc1.362.ged0d419d3c-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
