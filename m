Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC59C624DE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+9E0LKzseTlYgSclQHGLfiKcAQsl7etFt0x/0k6fe6g=; b=iBu7ijbT97UxIRnE3kvcgPBgB5
	6ezJihXoA2uhQ6wwDT37tsUmGNGMvyT1Zq+tJQSF7O2nEghPfPFlBvB6mxO0xoIOjyT6/Dhqg1/SM
	IQ2f9ghGW9mHK65GEvpjSh2VN6tbopdVFnzJMU8EeafatVhvfaJ5phRWVlGPibkbZOrI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2VOE-00061F-Ca;
	Fri, 04 Sep 2026 14:59:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x2VOD-000618-0F
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 14:59:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uknERYDMxgUO8g616vV1jOSNsSH1WjlXdGQkk1pq6JA=; b=Z4kqft/UOtQJa/AEN3PIpZJYDx
 qITtlubMzqyTigySRjxWZGC1jSVujxt5O0M9fGybW3MTHxDrIlVmohwl5Sk9Q2w9Eaiur15wE56Py
 C1UtGYEHMx9wvH7Xhe8DfzcIDXpSCGGIeeZjKGQGu9aSiitPJT+XpcEEes3GpTOyxMsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uknERYDMxgUO8g616vV1jOSNsSH1WjlXdGQkk1pq6JA=; b=G
 vwKir8ICVmgA+n0SKs4iVKqTXFSk6pt3RoO9p0LYLFcPxY8YUiDRNLi+1bswSaWrSJt5EAr4T4Rbt
 CQrzO91/8ClJmpqqqwT5biAqXVhrM+kiqMVxDLDj+FXZG3FKXXE7zh147cOyXroN1e62lfoI6OPZf
 xt4slraxWQy87ueI=;
Received: from mail-ot1-f54.google.com ([209.85.210.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2VOB-0001Gd-Jt for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 14:59:36 +0000
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7f69672e369so687605a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788533970; x=1789138770; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uknERYDMxgUO8g616vV1jOSNsSH1WjlXdGQkk1pq6JA=;
 b=c2H2KCA0CaGsM28tt2Cy3tF3ATX5Ht1cBeVb7wpDK2Rt+AVXiwlxyBKm9qFXJKQ8HP
 70mfd2TFjRaEEe3S3R4gf8vm8yZmDUXPf2G0AuJ29/lACBdng/DWEEAk1KnJ1u2DR0xR
 Beoh1ifdZu8o0Jz6hM7X2zi7HjG+Gm7vyZfxUyTbEW5Vj56i3xfNbTbwqRJcWrw8voMt
 6KVc6GgV3QpsbGzjBQPJHtdTdDOIGdrih3RNAubn59GQqjtCLDfDa4OQabdowqajOF3S
 5xLKQra2sW1VfAEHanE068o5c82J6qgx9fJyNJHY4B0I3maOD9PaUGRwYKL5A6i943oX
 Wqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533970; x=1789138770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uknERYDMxgUO8g616vV1jOSNsSH1WjlXdGQkk1pq6JA=;
 b=PF2SCOVJxC54LoAVeRNIEfLttAzJMHLWKtDrICUDR6QCxsHboIdgPa3k2M5yjck3G3
 xGOTkvhosGs1eLTdVkRDsO+pqnnmQ9E7QYuPQOC6RX7/sqpCzlvOynNysfiUGpLrgeCw
 5nGuWTY7cIhYTKmWdW//ghgp0efghGJgd7BbAntLfmjGTa6tu/nZiZ2CyPDkDjKYRxt9
 9zIpzPMsbGjWDcL8xP5u2JLZ4Rweqko4tUppOCY+wEJNGxP7+lSu7iziKWw769HxMNPU
 H7aCzVsoSqkTOKSCfOJ+C/iuha8DaK7SAiHhPMnChl6RrK23Og39fZlN7ddmSPW5+19f
 tOWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd0gVNNnIQPOS3ToH4laFiDmkmWfFhhPBTJwhm6aJUs/1lhfA5ipkPc3pvHJHxakY0wXqAboBr20Mc9Wwc0AQW@lists.sourceforge.net
X-Gm-Message-State: AFuF++mQztExj305VeyQvKdSqUav0JPTbLkW+JLQ4Zfy10nIYQ0qVwsR
 SFTyNrtreHX0kkrvFNTWZonbrRPM9TdhWZ13RtNWMnmZ/J1zmxoKSKry/gmCPnH+
X-Gm-Gg: AYBFou36IQ8qZ2apZqpODsf2g9G4VH+JMtaiI4c4Zg1EVzmfCucjkL3gqoSu/UAB2a9
 AdYFMtbOzBqE1nAJq/NaTNzWq0sEx6bAUU8iWTSCmzXB5WraWCpMYWllXZHhE8t0s1hDwcUY6uG
 jLOY0LMWOXbz6PbmW5WNSi+klsnd9s4W8noyZY1Utp3Gi9HnCs5ITTo91zpQCdHXv99f2Y1i1lO
 a3qjaBW8AnQNdPGaleZLqOGxFfFNY/EAL52IhXt8SBEGXTirGHZNvvmWpLRDhyGnbUjJL0hWbK7
 DuXBcvKWXU8BzOxJ84t5Fl4BDSlhQpZn9Bt+B+jBj7F60gMATb6FwIL9iUcVZj9Tf1XDb8TYX+g
 cICRLxPQJ5dLIdlZ6B2l5XOfaZ4ucr6GEyrw+3jr++Y/FAZhZUcRrwzCVwiegh9xmO5CiAwtCTk
 ZqcdH+qFNpsS7WEYcU3SbGCuUEYeVbNkct2kYL6MCoHOjOWww0asUYjVqHEuXKsY+WwWP3yjm/4
 43Ky/ym/zIZxGQHmnF4MIgnaSSjeNaLZ3vUGggNwcAsa3QBJPdLRlU74C+em+jeqcJXbKoBEaU2
 dUjOtQM+xgA=
X-Received: by 2002:a05:6830:828c:b0:7f4:ea33:8f56 with SMTP id
 46e09a7af769-7fa1e8eafb8mr6618239a34.6.1788533969600; 
 Fri, 04 Sep 2026 07:59:29 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:3bd3:26b1:e8bb:156])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f6793f53sm2999625a34.6.2026.09.04.07.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:59:28 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri,  4 Sep 2026 07:59:23 -0700
Message-ID: <20260904145923.1936598-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
MIME-Version: 1.0
X-Headers-End: 1x2VOB-0001Gd-Jt
Subject: [f2fs-dev] [PATCH] f2fs: fix livelock in f2fs_sync_inode_meta()
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

During checkpoint, f2fs_sync_inode_meta() iterates over dirty inodes in
the DIRTY_META list. If igrab() fails on an inode (e.g. because it is in
the freeing state), the loop continues without moving the current inode to
the tail of the list. As a result, subsequent iterations pick the same
inode repeatedly, preventing other ready dirty inodes in the list from
making forward progress and leading to a livelock.

Fix this by moving the current inode to the tail of the list
(list_move_tail(&fi->gdirty_list, head)) before attempting igrab().

Additionally, if igrab() fails, the freeing inode may be waiting for its
pending writeback data pages to complete during eviction.
Submit any pending merged data writes and yield the
CPU with cond_resched() to allow the eviction to make progress.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/checkpoint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ef22692cef0a..5597033533b0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1460,6 +1460,7 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 		}
 		fi = list_first_entry(head, struct f2fs_inode_info,
 							gdirty_list);
+		list_move_tail(&fi->gdirty_list, head);
 		inode = igrab(&fi->vfs_inode);
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
 		if (inode) {
@@ -1469,6 +1470,13 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 			if (is_inode_flag_set(inode, FI_DIRTY_INODE))
 				f2fs_update_inode_page(inode);
 			iput(inode);
+		} else {
+			/*
+			 * We should submit bio, since it exists several
+			 * writebacking pages in the freeing inode.
+			 */
+			f2fs_submit_merged_write(sbi, DATA);
+			cond_resched();
 		}
 	}
 	return 0;
-- 
2.55.0.979.g7e5102b832-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
