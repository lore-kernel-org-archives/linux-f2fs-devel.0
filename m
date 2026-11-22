Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8E606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Nov 2026 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DtFi4mHq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YRkm+AnP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S2b0cvE8;
	dkim=neutral header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=ctc+hlCt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=998nzYfFVajN2pEjrmX71soxa+iPLgEj7NAUxRVQVss=; b=DtFi4mHqktigH7x3uXZfgPid1S
	SYhxLdPwhIFbpNh7TB+hx9kiw6UZLbotJEVIkbzmrRwxfIadGlzvtqHiGc/gihV/2uOeV+DPbtl1B
	uHHhC7yrt7FBnso5IYKzqEYe192M7JZIlcJ9E3IM8CXVoXHl2G+VVmwp61pLCYPr+9N0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVFOl-000000001Nr-3iBz;
	Sun, 22 Nov 2026 21:46:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <laveeshb@laveeshbansal.com>)
 id 1xVFOk-000000001Nk-20jP
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 21:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Da26eW8Um/2wSqYK3x7AJPTzG5yvEtwSmXbjg+Qb4E=; b=YRkm+AnPbWaUCWkYRZRfBcI8Gc
 +4SbNgMRILsNqL+WRHlhVOyNBbrXMB+GSSLz8m10nzEQ7gJLDo3a2u6dvTiWRQnf3MIVDhc0u4vxp
 MbEsFRFJMftM3obsDFA9yZBye8+bpfYF8V5VhAJuWQP+/JQyDeQ1J6cl6LgvmauTa6hM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Da26eW8Um/2wSqYK3x7AJPTzG5yvEtwSmXbjg+Qb4E=; b=S2b0cvE8i2ZsNRYCvy/QqMKM51
 RrAvjJ95GMbRWzgHWTXEQ0JvUe9bfdxtLLnojHDfmvoolb0yc/7yzw53PQWAzZ0HSMqO1Xu5fQDRr
 1QYe53xMVNhw6tPImDZm6YSXdAjF8d6QwCOhDfm/cgpQ/wbFpA/tVSF6qprXvNzVUVyE=;
Received: from sender6-op-o15.zoho.com ([165.173.180.15])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVFOj-000000000N4-3Byv
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 21:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1795383091; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F75hLaiX0g07PSKho6TTYeNwZgUiIegt3onfbar6bHrMrW/1SW1xafD/o3odxLnzAjiHgtrzO8g7XAwiJrR1t1nEd2KBQX9Tv9ubyEeDw6gHjX5TfJ46UYPfG6rF+SonloGTICzNYlxs6ZEgNRRqbPqBfyfbdcII7TBGMPNcrNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795383091;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4Da26eW8Um/2wSqYK3x7AJPTzG5yvEtwSmXbjg+Qb4E=; 
 b=fK71F375RdKR0P8UUiLfeyU/zFovBkDjySQCBiRiKJtDLFRGzSLwgqpXQjIicFeISBp4Ox3BHsnM38GyQSHI+RLPe5HfPjUcrLCfHWXuCdWpfkdBF757FFHp1nTxTYLQqzn0uq3m3xa1sEpm+OpndMBnfwxvzoJ+Gdpds6mR84U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=laveeshbansal.com;
 spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
 dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256;
 b=ctc+hlCtD37eGZr3h8/TagiPVPxK6T4HwnnbMauSG/XU5tMq/enEdqh7jtPv4ywC/vufNxzfTYiFPwLA2yjr6IBfGu/EaUu9vvkWZtqU4Qv1/kidodhLqBH9s2rKw9hwvHRTx0A0LbhbQxogvaC9X6sCifJuRlqHHvaxtHBkQq4=;
 c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1;
 bh=4Da26eW8Um/2wSqYK3x7AJPTzG5yvEtwSmXbjg+Qb4E=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795383089229257.78063783334767; 
 Sun, 22 Nov 2026 13:31:29 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Date: Sun, 22 Nov 2026 13:31:20 -0800
Message-ID: <20261122213120.20974-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVFOj-000000000N4-3Byv
Subject: [f2fs-dev] [PATCH] blk-crypto: avoid fs reclaim under profile->lock
 in the fallback
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-crypto@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@lst.de>,
 syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Setting a key in blk-crypto-fallback can deadlock on profile->lock.
blk_crypto_get_keyslot() holds it across keyslot_program, whose setkey
allocates with GFP_KERNEL (Adiantum); direct reclaim can evict an fscrypt
inode, and blk_crypto_evict_key() then takes profile->lock again. syzbot
reports it as an fs_reclaim vs profile->lock cycle. Since
commit 5acc6f649a68 ("fscrypt: Always use blk-crypto for contents on
block-based filesystems") hitting it no longer needs -o inlinecrypt.

Use memalloc_noio_save() around both setkey calls (keyslot_program and
the blank-key clear in evict_keyslot), as blk_crypto_alloc_enc_bio()
does.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Cc: stable@vger.kernel.org # v7.3+
Reported-by: syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6a9b25c3.b5d4176b.238c3e.0004.GAE@google.com
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---
I used an LLM for the analysis, the patch and the test runs.

A scope in blk_crypto_hw_enter() would also cover hardware drivers (qcom
ICE allocates under the lock); I kept this to the fallback.

Tested on arm64 and x86_64 (QEMU, base c44104f3642d, KASAN and lockdep;
patched runs and fstests include comment-only revisions): f2fs with an
Adiantum policy, creating encrypted files and reading them back with
O_DIRECT under a memory hog, about a minute per run.
Runs showing each symptom:

                                              base      patched
  lockdep cycle warning, arm64                2 of 2    0 of 6
  lockdep cycle warning, x86_64               6 of 6    0 of 16
  task deadlocked on its own lock, arm64      0 of 2    0 of 6
  task deadlocked on its own lock, x86_64     5 of 6    0 of 16
  lockdep cycle warning, x86_64 as uid 65534  2 of 2    0 of 2
  task deadlocked, x86_64 as uid 65534        1 of 2    0 of 2
  profile->lock -> fs_reclaim edge in
    lockdep's dump (runs that got to it)      3 of 3    0 of 21

No KASAN reports. Some runs, base and patched, hit unrelated stalls under the
hog (f2fs and page allocation); none has a blk-crypto frame. fstests -g
encrypt on arm64: f2fs passes; ext4 passes except generic/435, which ran out
of space on a 1 GB scratch device and passes on 2 GB. Could not reproduce on
ext4; fstests not run on x86_64.

 block/blk-crypto-fallback.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 12e0b487e23a..2df418f16932 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -89,17 +89,24 @@ static struct bio_set enc_bio_set;
  */
 static u8 blank_key[BLK_CRYPTO_MAX_RAW_KEY_SIZE];
 
+/*
+ * setkey can allocate while profile->lock is held, and reclaim takes that lock
+ * to evict a key.  Use NOIO so those allocations can't recurse into the fs.
+ */
 static void blk_crypto_fallback_evict_keyslot(unsigned int slot)
 {
 	struct blk_crypto_fallback_keyslot *slotp = &blk_crypto_keyslots[slot];
 	enum blk_crypto_mode_num crypto_mode = slotp->crypto_mode;
+	unsigned int memflags;
 	int err;
 
 	WARN_ON(slotp->crypto_mode == BLK_ENCRYPTION_MODE_INVALID);
 
 	/* Clear the key in the skcipher */
+	memflags = memalloc_noio_save();
 	err = crypto_sync_skcipher_setkey(slotp->tfms[crypto_mode], blank_key,
 				     blk_crypto_modes[crypto_mode].keysize);
+	memalloc_noio_restore(memflags);
 	WARN_ON(err);
 	slotp->crypto_mode = BLK_ENCRYPTION_MODE_INVALID;
 }
@@ -112,6 +119,7 @@ blk_crypto_fallback_keyslot_program(struct blk_crypto_profile *profile,
 	struct blk_crypto_fallback_keyslot *slotp = &blk_crypto_keyslots[slot];
 	const enum blk_crypto_mode_num crypto_mode =
 						key->crypto_cfg.crypto_mode;
+	unsigned int memflags;
 	int err;
 
 	if (crypto_mode != slotp->crypto_mode &&
@@ -119,8 +127,10 @@ blk_crypto_fallback_keyslot_program(struct blk_crypto_profile *profile,
 		blk_crypto_fallback_evict_keyslot(slot);
 
 	slotp->crypto_mode = crypto_mode;
+	memflags = memalloc_noio_save();
 	err = crypto_sync_skcipher_setkey(slotp->tfms[crypto_mode], key->bytes,
 				     key->size);
+	memalloc_noio_restore(memflags);
 	if (err) {
 		blk_crypto_fallback_evict_keyslot(slot);
 		return err;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
