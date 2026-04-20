Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2868FF5581E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Apr 2026 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eeGfGiy7iWNXrYjCUh0L7B7KgEjpmZ3S1YbUeKPD3oY=; b=moQTjRfkshUa6/ZGKAUXsFFkcC
	C9TUrmKEgt2alInzq3sDBxv1ZV+ELyKsyjBNMMypJNagW6070n1xavergsvQ4fOeXZV1b9m6T5t9+
	eny0Szc9sYG2y1SJox3RNe7xL5tNOdmPUdi8KyPOnHIOITO4rV8d6i6bCBW3B9LAkQug=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wEn6c-0006RU-73;
	Mon, 20 Apr 2026 11:47:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wEn6a-0006RN-IZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Apr 2026 11:47:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=93DLvc90uzweudKPJBRLxyYewSJl7KjFZPXI6YRrSlM=; b=M0F151wCEEaWstlfgjIlPy8kht
 LI0leUm5umZAoSrm8UmYG5f7/VOc1nAWSA01bhqREv9knTADWfIHxvlUPadFDT0fihhsz6YBnJV+q
 WnbIoPaGvcydeXBX7Od7UWX9ue/CQ3DXh/w4m2HmO7vTmMZFvKi7Y3IakanmzQ4JcKlE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=93DLvc90uzweudKPJBRLxyYewSJl7KjFZPXI6YRrSlM=; b=D9FuRia1ptKx88s8ASg8qmbFH9
 QhKVCcddHibp6Ev4tyfc/s4m9AkI3GehvX4ErstXyDZq1ckrvink0mv2W2rNkum+HNaM2AU46HX4h
 2mHoOu2NSnUtVa9lSDojmq+2TOzRiUHTDUlsNd3LCzvAYWWoY8HfOx5X+fEeyNYAY8qg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wEn6a-0007Dk-0j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Apr 2026 11:47:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7287460055;
 Mon, 20 Apr 2026 11:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08DBC4AF0B;
 Mon, 20 Apr 2026 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776685670;
 bh=ObHO7TkH81lQ/7riwrZcCIrbr/LS6erJut4SJ367X5k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t6eojIFpk8ENmqkRGJUda7laENRx0QKPRYOls9apV80heXU9V1Y6XLNjBO6Jl0kXc
 gYUcMdvZB/Cb+xlzstqMLx7KSNJGFrUzYI5szIH06FAiEwc0/cfYWrAT4GJva9+gMj
 QAU5fD05LexgNx8ljdNs6hqzLhUI6NmXaBNVK7v7k60b7F0LHLFAPKLkh0kHgutWjU
 TOA2BAr9PWIraWlIFiMkaj8TOYJ40GfifwLYMZ7UoGhuamuS/xtYHqM3V4Jm2rsfWP
 4gza4PWCSY5N+djxxOsb8Yh5v9aW9LIavgFlVdovGQM2SnLtpCzHpMpfUEhzHDRXU0
 i4WOmc5VyAMew==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Apr 2026 13:46:52 +0200
Message-ID: <20260420114714.1621982-6-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260420114714.1621982-1-aalbersh@kernel.org>
References: <20260420114714.1621982-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wEn6a-0007Dk-0j
Subject: [f2fs-dev] [PATCH v8 05/22] fsverity: pass digest size and hash of
 the all-zeroes block to ->write
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let filesystem iterate over hashes in the block and check if these are
hashes of zeroed data blocks. XFS will use this to decide if it want to
store tree block full of these hashes.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Acked-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/btrfs/verity.c        | 6 +++++-
 fs/ext4/verity.c         | 4 +++-
 fs/f2fs/verity.c         | 4 +++-
 fs/verity/enable.c       | 4 +++-
 include/linux/fsverity.h | 6 +++++-
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 0062b3a55781..fd3696d3f4ce 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -773,11 +773,15 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
  * @buf:	Merkle tree block to write
  * @pos:	the position of the block in the Merkle tree (in bytes)
  * @size:	the Merkle tree block size (in bytes)
+ * @zero_digest:	the hash of the all-zeroes block
+ * @digest_size:	size of zero_digest, in bytes
  *
  * Returns 0 on success or negative error code on failure
  */
 static int btrfs_write_merkle_tree_block(struct file *file, const void *buf,
-					 u64 pos, unsigned int size)
+					 u64 pos, unsigned int size,
+					 const u8 *zero_digest,
+					 unsigned int digest_size)
 {
 	struct inode *inode = file_inode(file);
 	loff_t merkle_pos = merkle_file_pos(inode);
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index ca61da53f313..347945ac23a4 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -374,7 +374,9 @@ static void ext4_readahead_merkle_tree(struct inode *inode, pgoff_t index,
 }
 
 static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
-					u64 pos, unsigned int size)
+					u64 pos, unsigned int size,
+					const u8 *zero_digest,
+					unsigned int digest_size)
 {
 	pos += ext4_verity_metadata_pos(file_inode(file));
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 92ebcc19cab0..b3b3e71604ac 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -270,7 +270,9 @@ static void f2fs_readahead_merkle_tree(struct inode *inode, pgoff_t index,
 }
 
 static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
-					u64 pos, unsigned int size)
+					u64 pos, unsigned int size,
+					const u8 *zero_digest,
+					unsigned int digest_size)
 {
 	pos += f2fs_verity_metadata_pos(file_inode(file));
 
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 42dfed1ce0ce..ad4ff71d7dd9 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -50,7 +50,9 @@ static int write_merkle_tree_block(struct file *file, const u8 *buf,
 	int err;
 
 	err = inode->i_sb->s_vop->write_merkle_tree_block(file, buf, pos,
-							  params->block_size);
+							  params->block_size,
+							  params->zero_digest,
+							  params->digest_size);
 	if (err)
 		fsverity_err(inode, "Error %d writing Merkle tree block %lu",
 			     err, index);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index e4503312d114..a5645ec07aa8 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -124,6 +124,8 @@ struct fsverity_operations {
 	 * @buf: the Merkle tree block to write
 	 * @pos: the position of the block in the Merkle tree (in bytes)
 	 * @size: the Merkle tree block size (in bytes)
+	 * @zero_digest: the hash of the all-zeroes block
+	 * @digest_size: size of zero_digest, in bytes
 	 *
 	 * This is only called between ->begin_enable_verity() and
 	 * ->end_enable_verity().
@@ -131,7 +133,9 @@ struct fsverity_operations {
 	 * Return: 0 on success, -errno on failure
 	 */
 	int (*write_merkle_tree_block)(struct file *file, const void *buf,
-				       u64 pos, unsigned int size);
+				       u64 pos, unsigned int size,
+				       const u8 *zero_digest,
+				       unsigned int digest_size);
 };
 
 #ifdef CONFIG_FS_VERITY
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
