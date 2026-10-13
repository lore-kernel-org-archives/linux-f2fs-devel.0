Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206F1CA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 02:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6/xo8QlBAlcg9wcua1qaQTZVU5pJEp/YqBbreIQw5eo=; b=D+TXFwTJ/BR4GnRDGHRZzQpIKb
	Njknczx3cL2g56E0k5r3p9MMnrUiaFntSAsmE5XkOT+YssDP6DuUwDITk1bjLr8t8331I6GsFvX9h
	gZTCghNgP3feJntk7N1cACBKmXhbVpX9wQ2sY0nAJZ4wcWbh4eR5OlZxcpGYL6bZ5Hmw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGRxl-0007Yd-Bz;
	Tue, 13 Oct 2026 02:09:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xGRxk-0007YW-AK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 02:09:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7yfQb/NIWEqP4dfQyyW1F46esS1vblLkgAQScX3XltE=; b=UZPeUPVRRNx2sL7N9EGJkK64/G
 /os8m903if9YoGZ7dmBFvsSBzVAbhD/7xZOrWHHDJVGb9NIXP8z4OLK15F7TbiNXSDlHLENI39Eh/
 /p0Go8KozDHmMwlux+AyGDeULkAnXDcyqQ+9egbe3bbO+COt57OFVmIU4W5L4Fbqw+XQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7yfQb/NIWEqP4dfQyyW1F46esS1vblLkgAQScX3XltE=; b=V
 Vny3d29g1TSZpNbEB/qYlHnfo5QIjev5mAwOvD6mlMk7FL3AVKv7XvNqEjJN29CqhZ2Ej5WT6LQBi
 S9ngO18tpDSfwxQNxYv7AknmCoNw93k06h79QpHEn5bIPxfNoFuHFPvbK3LLoiWsirxQcMnY/0zWG
 fAxACaxWpzVyBf5A=;
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGRxh-0006pO-B9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 02:09:53 +0000
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e901e114fdso3529625ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 19:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791857388; x=1792462188; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7yfQb/NIWEqP4dfQyyW1F46esS1vblLkgAQScX3XltE=;
 b=FanXnS0lxFA8TwGLbUxo0WNZ7x1p1MoMLViNYPPKCEwBHDniZxPWUdy/te3cYvQ7Uo
 g/7GUaEyMc7l/hncAe+iwFBEp26T6YSa7FajsRVv1VeI0kJd2QLPvJpK9ypizrQW7RbT
 5yNMI/6yvxqtukI6muZK0kt2JU0zUH2myfh46oMtdScByJc/WaJ6qIfeMMbfGvvzijvr
 DEZICMP2wCrZB9iZXSzgtbA4JQxvKAbQGN7iOaKwHsw3Gr5k/zFlr7iml2aHBd+Esy/k
 LEuDU2Vf09OCLz8c8+wU+tNawH9f0sQvWZoSeMnX/r8/2UNb8JlYukDY2nrx5MKnMd1p
 vpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791857388; x=1792462188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7yfQb/NIWEqP4dfQyyW1F46esS1vblLkgAQScX3XltE=;
 b=PLqZ7V1U1QFFNJbLmnCK3W66/KRi4lT4EmujOMTCv1EBqbkNFnPGYznQPCCeNxHMNs
 QgA9ElFJPlGz8DsBahFxADfWXQGx9Vurnso7UuJjROBpgc89vhD0uxerUYepSHQB70PK
 lFB+hxSj1Eo1BuyU0yLYEvXJhVlKeoCV41UV8lkNOHOxbjxSAUB+3cJ4eF3KGU/avcm8
 ovwQf9fd2y69IXaQ82PWbuiHzkwVBwEVZP5Bfw5CfGIkr4uPDc/YUq5bt1jgj1HyltXT
 noTuP3to+iOVvwlbTRZkPJ1Ig2P3tjf06mEzURnujHIERNzxAJfoZ0Tu0DSsKnocSBoU
 RUIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMUF/MEQi3545WHZmhpYNVcm1dgj0IlZaWWT1YEmvpDbdGbJqr6zyRa4arNqn8ZixRapedhmKNhzEOuutlN4Pf@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLSl8F9PEckGu0+Hgkn9KNbfjH8mdwcXQ1oVmKC+xTp1u56Qy09
 dg9XiHMyXCtgL+cqUb36ejiEFvzln8oWFwMKXG3oVpKRWrc+nVauw67w
X-Gm-Gg: AYBFou3KXxTp2HO0lu8042CGIa4PzLjg1VmTOU5tkdQXUzc1EluzW7NgVW/AjqoQsCK
 3ZmzZRt2zLEK0yg+IlKii5TsJtgwh9KX0p8s9fjGfCAtHHIDs5/7igTNV5wjYjim9ZL4IcGSNsD
 WtzLIqTudMQS3ejwv7OXRronrmbS0YhkvJkqG85djzB6ECYIds+p4fnPIQkwZ7rAhZbEZGkn3ls
 +F1O1gGx7gMEpdGKw29u/GYtmxcjTOH4shaMjq0bljUFGoRxduOxM2qc3utK0G5QGSiryeuqLaj
 iVC6Iog5DVILgbbQnItQQIv+eKnwPyWPtvYaDP+6LhSZd2eh9k43mvweA/bJHB3PkfhDEgTv/OK
 f+Y/E5Gf2BhlggQbmwwrpVCpCHAvVtUxwfz1XUK/+IWO8N/mv3nvhxFB8Ur+o8/f0WzsHXReNhm
 JrVnqn3KEsOwtTUFc3a9O63CbaYEjHOG/u32y9Xx+gWOXawpqOuuCGOl8vAFn3vzfBU63u9Wwjj
 9D2UaCGrfmY/ugj0gNsXw4PS/wnuva9jiCAIYsZdLJxOPP5qG68qW3uWnVNVfZZyqy90uxvWdmc
 TR1kMuTJUVLm3Bo=
X-Received: by 2002:a17:903:2a87:b0:2dd:c100:b2c5 with SMTP id
 d9443c01a7336-2e842ce4e2fmr99096335ad.48.1791857387543; 
 Mon, 12 Oct 2026 19:09:47 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e90977deafsm4319505ad.68.2026.10.12.19.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 19:09:46 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 13 Oct 2026 02:09:41 +0000
Message-ID: <20261013020941.4025355-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xGRxh-0006pO-B9
Subject: [f2fs-dev] [PATCH] f2fs: release a removed xattr node in
 roll-forward recovery
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

When xattrs shrink enough to fit in the inline xattr area,
write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
the file is then fsynced without a checkpoint, only the inode block is
written, with i_xattr_nid of 0.

Roll-forward recovery starts from the checkpointed inode, whose
i_xattr_nid still points to the old xattr node.
f2fs_recover_inline_xattr() copies only the inline xattr area, and
f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
the stale xattr node:

 - The node block is never released, and fsck reports "nonzero bytes in
   xattr space after end of list".
 - If the inline xattr list ends exactly at the end of the inline area,
   its terminator is read from the stale node, and the removed xattrs
   come back after recovery.

When the fsynced inode has no xattr node but the checkpointed one has,
release the old xattr node in the same way as f2fs_recover_xattr_data().

Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/node.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 55008f18afd..590fdedf9c2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2831,6 +2831,29 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
 	f2fs_cache_wait_writeback(ientry);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
+	/*
+	 * The xattr node of the checkpoint was removed before fsync, e.g. the
+	 * xattrs became small enough to fit inline. Release it as well, or
+	 * the inode keeps pointing to the stale xattrs.
+	 */
+	if (!ri->i_xattr_nid && F2FS_I(inode)->i_xattr_nid) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		struct node_info ni;
+		int err;
+
+		err = f2fs_get_node_info(sbi, F2FS_I(inode)->i_xattr_nid,
+								&ni, false);
+		if (err) {
+			f2fs_put_cache(ientry, true);
+			return err;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ientry);
 	f2fs_put_cache(ientry, true);
 	return 0;
-- 
2.56.0.385.gd3acb90ef8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
