Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DBCC5AC67
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pLKJsNFlH/WuVmyQaqPDJN3OJBkXr54/lZ5HOroXT0U=; b=KpBUadPYyZgkYqnYePaIT2pY5q
	A9UpqR39gzWtEC6A3KPEy9qquF++cO4XjCYSEP5v0siMLaCsR5DaspDVkAsbyUt1Rps/a4DR7svBt
	o/+T8zDNvdSdM6NzGJwcstngzLeK7gTTkYQozzeRdT//WypjHC7SIdLJo6SL6t6h4Io8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wssJR-0003om-DG;
	Sun, 09 Aug 2026 01:26:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wssJQ-0003og-IB
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 01:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0P3R1S9d9BIx0saTISwv8bViwUT39u5atC0yHBfq0jM=; b=hkgHo5hOQOyeVLCSDJ27Sy2uv5
 ogG3sMobbyI1wN+3cYnBA7v5ZHvQPubsWWmXhjOfOJWOh6QTTNnlLsfUuoCNQCt6JWhvApJJvOFUi
 6nhkPjX0JfvriZ37In+r4hGegakdl176yGEK4MamtQwilSG1kV2Ko43IIy9222BhNt88=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0P3R1S9d9BIx0saTISwv8bViwUT39u5atC0yHBfq0jM=; b=d
 QRGVTureVH6EMVnTgst31lxGV9UcoNndc83Bw1ZFKvwJ1eiAB4NAYHbv/os/LW9tQZoy8HvcXnm9m
 7UhqFrEFb9ciq93ILISQNft2oQ/rulFBsqN1/irXTXGstzpvuFyB82A87qQUOA20EGnaMfi0zt5nh
 APYLfbUiUlMQqbKs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wssJR-00055b-4p for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 01:26:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 509CB439A2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  9 Aug 2026 01:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6A31F000E9;
 Sun,  9 Aug 2026 01:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786238804;
 bh=0P3R1S9d9BIx0saTISwv8bViwUT39u5atC0yHBfq0jM=;
 h=From:To:Cc:Subject:Date;
 b=P6mAYJN5ZhKzWpMwtZC7s37N696SIhcfc9+97clZn6AV7V2OkV6oiG9w8Rc9bOHHP
 6XBGFBptGft5nSbZ5F3U+hJWkxp4I75+klh0/6Tys21vsE1Y3fMbZ21cCo8G1rE8L4
 F4b9303XID8S1K+TDCZtbqgSoQg5FHZzlzC9YdmTqRDnLShZjxWm/Unv4CN8nVmrpu
 8O+UWTFX4NvV1gT4EiDUFByOrhaiEqFbfUASKut2rAT+H7Omkveo2tLjPiHMs/r0Uo
 kOh/jbtmpIkVub8cDRxEkkOrvFI/Px2NyowXIUM7YlmjFIDrqV/xeHjz9hHX8tBLdt
 U+H1eDTPab/SA==
To: jaegeuk@kernel.org
Date: Sun,  9 Aug 2026 09:26:38 +0800
Message-ID: <20260809012639.568485-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1wssJR-00055b-4p
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: unify add/remove ino entry API for
 all ino types
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

- Call f2fs_add_ino_entry() and f2fs_remove_ino_entry() for ORPHAN_INO
- introduce __f2fs_add_ino_entry() to wrap __add_ino_entry(), so that
both f2fs_add_ino_entry() and f2fs_set_dirty_device() will call
__f2fs_add_ino_entry().

So, after this change:

		add			delete			lookup
ORPHAN_INO	f2fs_add_ino_entry	f2fs_remove_ino_entry	N/A
FLUSH_INO	f2fs_set_dirty_device	f2fs_remove_ino_entry	f2fs_is_dirty_device
APPEND_INO	f2fs_add_ino_entry	f2fs_remove_ino_entry	f2fs_exist_written_data
UPDATA_INO	f2fs_add_ino_entry	f2fs_remove_ino_entry	f2fs_exist_written_data
TRANS_DIR_INO	f2fs_add_ino_entry	N/A			f2fs_exist_written_data
XATTR_DIR_INO	f2fs_add_ino_entry	N/A			f2fs_exist_written_data

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4413eccb5ecb..eb2f955b1e2a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -775,10 +775,16 @@ static void f2fs_wait_for_inode_record(struct f2fs_sb_info *sbi, int mode)
 	flush_workqueue(sbi->evict_wq);
 }
 
-void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
+static void __f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
+					unsigned int devidx, int type)
 {
 	/* add new dirty ino entry into list */
-	__add_ino_entry(sbi, ino, 0, type);
+	__add_ino_entry(sbi, ino, devidx, type);
+}
+
+void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
+{
+	__f2fs_add_ino_entry(sbi, ino, 0, type);
 }
 
 void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
@@ -823,7 +829,7 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 void f2fs_set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type)
 {
-	__add_ino_entry(sbi, ino, devidx, type);
+	__f2fs_add_ino_entry(sbi, ino, devidx, type);
 }
 
 bool f2fs_is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
@@ -875,14 +881,14 @@ void f2fs_release_orphan_inode(struct f2fs_sb_info *sbi)
 void f2fs_add_orphan_inode(struct inode *inode)
 {
 	/* add new orphan ino entry into list */
-	__add_ino_entry(F2FS_I_SB(inode), inode->i_ino, 0, ORPHAN_INO);
+	f2fs_add_ino_entry(F2FS_I_SB(inode), inode->i_ino, ORPHAN_INO);
 	f2fs_update_inode_page(inode);
 }
 
 void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	/* remove orphan entry from orphan list */
-	__remove_ino_entry(sbi, ino, ORPHAN_INO);
+	f2fs_remove_ino_entry(sbi, ino, ORPHAN_INO);
 }
 
 static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
