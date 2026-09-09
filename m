Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE1DC79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=86x7CEwAeerIh2eED9xSNko+s5iwF4ifNllO6yNmGZ0=; b=galBegEnf+18YtFlTISF/90cS3
	VASLoDEMqPvYq0plkLNby7jShpIQe7VfcXar+vs11zmA5IidWmx02mwfWX4yz0FBvlyQWD7ynAqxO
	uMTJfjlaYKeHSb22mzpkU+U/p1LwD6TZXK3AsxQmN8AOLzWQhQIIugo5SQYGjrXtNkWc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4NdC-0008Gw-Uz;
	Wed, 09 Sep 2026 19:06:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4NdB-0008Gp-Pt
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 19:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=obPkw9dzUR7EZ4PZqPbu4EwHtQ7nPQqg1CfUc0zXxRo=; b=NToq7x2TUG37g66Y8XhL+xC2/9
 tc6KR0apByxCrgH0mGWmAM9k/Nhy2IGb1eSndiOCCL1+0Ggq/LQinrFDr6VlM485w43fAmmtlLjeS
 1QSrNMYmQ+X7TRBqKfJWcGo78t5OCPJUpbPWyMrhnDaJ4J+f7Cnh746kZCP4kDYDQoyw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=obPkw9dzUR7EZ4PZqPbu4EwHtQ7nPQqg1CfUc0zXxRo=; b=U
 f9NH7bWqGtuyDfglOOC/74cSSwTTeLiRzTjykBo23xKypr+lreZ5M5IriE0PpzdAKmAubnWknRWSU
 h3z6Edazvw9oXouJ53aNSrc1d1M5kGAwsU+PklLm7yyG7qTL/4T65CkZv2vwn7k5XF22AbW46uMZU
 AzbH7Ia4WUMCLskw=;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Nd8-0003pa-OX for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 19:06:47 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso5827960a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788980801; x=1789585601; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=obPkw9dzUR7EZ4PZqPbu4EwHtQ7nPQqg1CfUc0zXxRo=;
 b=CG9GidJVRO3aSoIDBvfdUYosGZx5XRInbk5rF2lB28HjvBJ2jm7mNMtLb2qi5j/Q1B
 8h5zWIh/xIs54mLcF3wAFihUr6G3ZuKXWxIi/LPq9o8b8w9Cklsi8BYWJvZJz+iydIRo
 VdyWrPKnbplaF7j61WlHZ/dOLlorO7O2wuceEIUZ1rxpqyYHV86w9+WRb3/VcqA4Brmc
 SYUg9OxjZTu0rQ8bDp9EE4v6OGB0QBVMwu/VNHJaVtYiRY0hkLdZ4Y1OxQYXFAyibAEg
 DiXqjnScjLMY9BJBJFfkcGKcvwQKPoE6x/CijHMwno/c9nnDXY52qJhkNeyX5zy3iaq/
 hFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788980801; x=1789585601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=obPkw9dzUR7EZ4PZqPbu4EwHtQ7nPQqg1CfUc0zXxRo=;
 b=P0RrXtcmp2EFy3d9TFTJmBq1pZ++xYiDq6WSm/20xFcLRHGJd+Hj/rYo1COkvcWxDV
 P3Y3X0riKRHVxtgf2NtXPM7W8w7Tob5ZpG6R7AWVe5EsYDqgAFLJEyvSDPtRAB4+2wdA
 9LPkLyQtMU+j+qQobf35wCa4W8dZcuC3k9Yug3/Co17R/apaSFl/ypXW2qZmnYnyCTHU
 uttpjKR+hjzteO3j9ETgcbjQoeG85tJf3hwnJ1MYtFKwow+K9Z4NxZHz6IGz6HsInjXG
 KtZ6X8HOkiORZoHfc7jqh3bJlavZre0h+mjlQGZb852JBrmUbliWtnvjGZqcpnEYIRr4
 wtWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0v5rO9EP5/P3J0CAok8gmwaC/3sfOD7PclIMmTaBdZQ2l16PUqTFGSTE237NTAs3bfQNHvDn2q6UpiImWj+cE@lists.sourceforge.net
X-Gm-Message-State: AFuF++mxCXLWukVDXoyx6eRhqPBr1rYJFeLnvjMxIXJIrb1LPHCDUX67
 XniclXNK4WsXpdVtmDziUSlo/0uJQsLFRvGhsY5RoMDV0rpZKzqfpDCdSaj0Yw==
X-Gm-Gg: AYBFou2YHXB4kOd4vJvXlmSt7PB3p68wOcGcILPcR1WukHpqrK69ANI5/qgHWCveEVd
 t5Ka0023y9lFIeEcm/s1MHQf0IanPAyeaXQ9kb4tyfk85ksmiR490dfuUIAu91pByURD+GiqH6D
 QZTXfdNU9VMi7XoRMiwBOKSKDfMiwKOv/b4ejjWG4UFALQj+9xmy1K8+bxcwi86aX2JTYNz6l1m
 O0Gay8IJHviJl0FAxTCAlbkfdyW0f6wI/7+8WNQszuOCIOWz/uTJIlBFBvCYuDavs5eTXFY7wy7
 f/f3HramoU/61FZkcC/sTSKgPpPOcMGb6oYJ/F5NgkaDygvhXmqHcBQLDFM0BJFkVe1wZJmCNuq
 I12BcASp4T+VhT0qRvZqGRzZLgGy32mx5wCarfWo8hWpyNcTHF/wOc7ztFPLGWu3jmfDIzjbhG8
 LoIespbltSQ/VRki+jXSEhekgVqpXtOrFQ0pNPfE/aRDTHE1lK8bWBZZBfghDQWbw3XYim86sAp
 JlKdbhbeegTSB2/KVkoYJeAESeaAo5nW7aNETGXu8zppgkEFwQM1KsS+gjiaG1U1g53Sqbl9wv9
 CoTSHE6QrxcCYGRDl+Ry97w=
X-Received: by 2002:a17:90b:3d48:b0:396:5f7f:52f5 with SMTP id
 98e67ed59e1d1-39b260e13e0mr55280731a91.3.1788980800923; 
 Wed, 09 Sep 2026 12:06:40 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:406a:f8f3:9059:8330])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b314cfcsm45915355eec.19.2026.09.09.12.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 12:06:39 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed,  9 Sep 2026 12:06:36 -0700
Message-ID: <20260909190636.3151580-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
MIME-Version: 1.0
X-Headers-End: 1x4Nd8-0003pa-OX
Subject: [f2fs-dev] [PATCH v2] f2fs: fix livelock in syncing dirty inodes
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

During checkpoint, f2fs_sync_dirty_inodes() and f2fs_sync_inode_meta()
iterate over dirty inodes in their respective lists. If igrab() fails on
an inode (e.g. because it is in the freeing state), the loop continues
without moving the current inode to the tail of the list. As a result,
subsequent iterations pick the same inode repeatedly, preventing other
ready dirty inodes in the list from making forward progress and leading
to a livelock.

Fix this by moving the current inode to the tail of the list
(list_move_tail(&fi->{dirty_list,gdirty_list}, head)) before attempting
igrab() in both f2fs_sync_dirty_inodes() and f2fs_sync_inode_meta().

Additionally, if igrab() fails, yield the CPU with cond_resched() to
allow the evicting thread to finish eviction. Remove the redundant
f2fs_submit_merged_write() call, since .writepages already submits cached
bios via f2fs_submit_merged_write_cond().

v2:
- Also apply list_move_tail() to f2fs_sync_dirty_inodes().
- Remove redundant f2fs_submit_merged_write() calls from both functions,
  keeping only cond_resched().
- Update commit title and description.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/checkpoint.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ef22692cef0a..d16988150a8c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1410,6 +1410,7 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 		return 0;
 	}
 	fi = list_first_entry(head, struct f2fs_inode_info, dirty_list);
+	list_move_tail(&fi->dirty_list, head);
 	inode = igrab(&fi->vfs_inode);
 	spin_unlock(&sbi->inode_lock[type]);
 	if (inode) {
@@ -1432,11 +1433,6 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 		else
 			ino = cur_ino;
 	} else {
-		/*
-		 * We should submit bio, since it exists several
-		 * writebacking dentry pages in the freeing inode.
-		 */
-		f2fs_submit_merged_write(sbi, DATA);
 		cond_resched();
 	}
 	goto retry;
@@ -1460,6 +1456,7 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 		}
 		fi = list_first_entry(head, struct f2fs_inode_info,
 							gdirty_list);
+		list_move_tail(&fi->gdirty_list, head);
 		inode = igrab(&fi->vfs_inode);
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
 		if (inode) {
@@ -1469,6 +1466,8 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 			if (is_inode_flag_set(inode, FI_DIRTY_INODE))
 				f2fs_update_inode_page(inode);
 			iput(inode);
+		} else {
+			cond_resched();
 		}
 	}
 	return 0;
-- 
2.55.0.1003.g10538fe699-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
