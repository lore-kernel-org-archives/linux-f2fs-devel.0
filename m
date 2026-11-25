Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE519606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S4eGui8s;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iU2CEmzo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Rv3DnPpZ;
	dkim=neutral header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=QFwOPcgo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=J3c5IIrxHt66qB0uryKo+dk121T5LLB/LEnB2jUGxVM=; b=S4eGui8sYSLGEDIPCT9BBIHOkF
	H/OTezFol+RTnJ/MmlBsejzDtPwVyXu4WorKAyczMfOgulSnDRKf0RrrbKADIuDGRnXhgbYcUha7O
	W4/RKHnl3wR5jS4s1dEB6LlLTFT4iTFcjuHpzSJWoTG9FRnW6nXb49YQYO54lzIilLGk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xW8A5-000000000Gg-1sa6;
	Wed, 25 Nov 2026 08:15:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <laveeshb@laveeshbansal.com>)
 id 1xW8A4-000000000GI-0qY4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 08:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FwOH1coY3t+CInoErN4iF+FEJuHEHV4tRRrKkiX0plk=; b=iU2CEmzo3XNJwA9kUbuy3WqSKF
 9aeKbEMzQ0Ed+IHMYV/Q1NVKprUYyPsb49EVD3b/FZk8R5mwbV8GqJw1I5kE1NvzbC97SxPfkvf3e
 1u1KfODuC3ozjjO5hK/djUkrkDCDudP6uDmynnyR3LSDORodDcP0+xBAWoJr0L/Jy3wQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FwOH1coY3t+CInoErN4iF+FEJuHEHV4tRRrKkiX0plk=; b=Rv3DnPpZEdiDAZS+c8dJZEq4FC
 M2IdYErM5efNWwdRYpFkFbH21W/aWjOYhUtsv3L2GMF5APTt3NsPSEmBluC3pUEGBZTAH6fnd+oyl
 Eeq6HX7O6ku9Q0oRF3xiV3LNzZszqDl4F9QL7upsAETRWao9LKlNNq1RZ+7TCt5Yx9FA=;
Received: from sender5-op-o15.zoho.com ([165.173.182.15])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xW8A2-000000001lN-22jF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 08:15:28 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1795594507; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HgzvLvmJANJ8tARFLpD3JsBXnYgagq2m6hMajdqNq32tgtDZXA+jqFSt0fh4BGoneX0kf6PecA1SRrFkwDNqka+gugpDcCf5poa8JCksabotHlLIf/vNWwr3/LeqAx+Baa5wx8wQHsVCPHaehl5qAxbDZnS+ZrzhJ6T3e+VRGa0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795594507;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FwOH1coY3t+CInoErN4iF+FEJuHEHV4tRRrKkiX0plk=; 
 b=avt+Y70OQvpTmtSTkUMixuqOnMmoFaM1/e/ec345pSXcbGKkKgih3TuVTpA/fzMEKW0dQvFmU/jJyMeOYRhm2yk6xIgptalCw3gAaSLXrhO4ZzCwK6glL4GcWhvHlt8fPQ0kCf/EiR+/7a7R1Fnqb3ml6r1omMzfFnwL8BxIVN8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=laveeshbansal.com;
 spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
 dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256;
 b=QFwOPcgo7F/ry7PxjI/smDrFMmSFFJmYj6OOFLciioUBEdyupfxwaNH1tICJBkIXiPKu1Svw/nSIpGaVyJNXPuCAlxSkN5U7HrMK7YuciG+1Pr7ogd5JcRf7fONNvXZNgmE5fQLeCek+8hacfRG1PcklbuGWUuT4Omg3bWpdCVc=;
 c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1;
 bh=FwOH1coY3t+CInoErN4iF+FEJuHEHV4tRRrKkiX0plk=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17955945042631020.0162038637695; 
 Wed, 25 Nov 2026 00:15:04 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Date: Wed, 25 Nov 2026 00:14:17 -0800
Message-ID: <20261125081417.77674-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xW8A2-000000001lN-22jF
Subject: [f2fs-dev] [PATCH v3] blk-crypto: use a NOIO scope while holding
 profile->lock
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

Enter a NOIO scope in blk_crypto_hw_enter() and leave it in
blk_crypto_hw_exit(), so allocations made under the lock, by the
fallback or a hardware driver, can't recurse into I/O or fs reclaim.
blk_crypto_reprogram_all_keys() takes the lock directly, so it gets the
same scope.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Cc: stable@vger.kernel.org
Reported-by: syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6a9b25c3.b5d4176b.238c3e.0004.GAE@google.com
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---
I used an LLM for the analysis, the patch and the test runs.

Changes in v3:
 - blk_crypto_hw_enter() now returns the saved flags and
   blk_crypto_hw_exit() takes them, instead of keeping them in the
   profile; comment reworded (Eric).
 - Dropped the version from the stable tag (Eric).
 - Did not carry Christoph's Reviewed-by from v2, since the code changed;
   Christoph, please re-add it if you are ok with this version.
v2: https://lore.kernel.org/r/20261123181408.62972-1-laveeshb@laveeshbansal.com

Tested on arm64 and x86_64 (QEMU, base c44104f3642d, KASAN and lockdep):
f2fs with an Adiantum policy, creating encrypted files and reading them
back with O_DIRECT under a memory hog, about a minute per run. Runs
showing each symptom:

                                              base      v3
  lockdep cycle warning, arm64                2 of 2    0 of 8
  lockdep cycle warning, x86_64               6 of 6    0 of 6
  task deadlocked on its own lock, arm64      0 of 2    0 of 8
  task deadlocked on its own lock, x86_64     5 of 6    0 of 6
  lockdep cycle warning, x86_64 as uid 65534  2 of 2    0 of 2
  task deadlocked, x86_64 as uid 65534        1 of 2    0 of 2
  profile->lock -> fs_reclaim edge in
    lockdep's dump (runs that got to it)      3 of 3    0 of 13

No KASAN reports. With the hog using up memory, one of the 6 x86 runs
stalled and never finished, and one of the 2 uid 65534 runs had a
hung-task report but finished. In both, the task holding profile->lock
was in reclaim from the setkey allocation, with kswapd waiting on the
lock in key eviction, and lockdep reported nothing: NOIO stops the
allocation recursing into key eviction, not a wait for free memory.

fstests -g encrypt on arm64 passes on f2fs and ext4. The deadlock did not
reproduce on ext4; fstests not run on x86_64.

 block/blk-crypto-profile.c | 53 ++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 53126c091b0b..62d3eaa4e186 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -29,6 +29,7 @@
 #include <linux/atomic.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/mm.h>
 #include <linux/wait.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
@@ -42,7 +43,8 @@ struct blk_crypto_keyslot {
 	struct blk_crypto_profile *profile;
 };
 
-static inline void blk_crypto_hw_enter(struct blk_crypto_profile *profile)
+static inline unsigned int
+blk_crypto_hw_enter(struct blk_crypto_profile *profile)
 	__acquires(&profile->lock)
 {
 	/*
@@ -53,11 +55,15 @@ static inline void blk_crypto_hw_enter(struct blk_crypto_profile *profile)
 	if (profile->dev)
 		pm_runtime_get_sync(profile->dev);
 	down_write(&profile->lock);
+	/* Avoid recursing into I/O or fs reclaim while holding profile->lock */
+	return memalloc_noio_save();
 }
 
-static inline void blk_crypto_hw_exit(struct blk_crypto_profile *profile)
+static inline void blk_crypto_hw_exit(struct blk_crypto_profile *profile,
+				      unsigned int memflags)
 	__releases(&profile->lock)
 {
+	memalloc_noio_restore(memflags);
 	up_write(&profile->lock);
 	if (profile->dev)
 		pm_runtime_put_sync(profile->dev);
@@ -252,6 +258,7 @@ blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
 	struct blk_crypto_keyslot *slot;
 	int slot_idx;
 	int err;
+	unsigned int memflags;
 
 	*slot_ptr = NULL;
 
@@ -269,10 +276,10 @@ blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
 		goto success;
 
 	for (;;) {
-		blk_crypto_hw_enter(profile);
+		memflags = blk_crypto_hw_enter(profile);
 		slot = blk_crypto_find_and_grab_keyslot(profile, key);
 		if (slot) {
-			blk_crypto_hw_exit(profile);
+			blk_crypto_hw_exit(profile, memflags);
 			goto success;
 		}
 
@@ -283,7 +290,7 @@ blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
 		if (!list_empty(&profile->idle_slots))
 			break;
 
-		blk_crypto_hw_exit(profile);
+		blk_crypto_hw_exit(profile, memflags);
 		wait_event(profile->idle_slots_wait_queue,
 			   !list_empty(&profile->idle_slots));
 	}
@@ -295,7 +302,7 @@ blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
 	err = profile->ll_ops.keyslot_program(profile, key, slot_idx);
 	if (err) {
 		wake_up(&profile->idle_slots_wait_queue);
-		blk_crypto_hw_exit(profile);
+		blk_crypto_hw_exit(profile, memflags);
 		return errno_to_blk_status(err);
 	}
 
@@ -310,7 +317,7 @@ blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
 
 	blk_crypto_remove_slot_from_lru_list(slot);
 
-	blk_crypto_hw_exit(profile);
+	blk_crypto_hw_exit(profile, memflags);
 success:
 	*slot_ptr = slot;
 	return BLK_STS_OK;
@@ -345,18 +352,19 @@ int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
 {
 	struct blk_crypto_keyslot *slot;
 	int err;
+	unsigned int memflags;
 
 	if (profile->num_slots == 0) {
 		if (profile->ll_ops.keyslot_evict) {
-			blk_crypto_hw_enter(profile);
+			memflags = blk_crypto_hw_enter(profile);
 			err = profile->ll_ops.keyslot_evict(profile, key, -1);
-			blk_crypto_hw_exit(profile);
+			blk_crypto_hw_exit(profile, memflags);
 			return err;
 		}
 		return 0;
 	}
 
-	blk_crypto_hw_enter(profile);
+	memflags = blk_crypto_hw_enter(profile);
 	slot = blk_crypto_find_keyslot(profile, key);
 	if (!slot) {
 		/*
@@ -382,7 +390,7 @@ int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
 	hlist_del(&slot->hash_node);
 	slot->key = NULL;
 out:
-	blk_crypto_hw_exit(profile);
+	blk_crypto_hw_exit(profile, memflags);
 	return err;
 }
 
@@ -397,6 +405,7 @@ int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
  */
 void blk_crypto_reprogram_all_keys(struct blk_crypto_profile *profile)
 {
+	unsigned int memflags;
 	unsigned int slot;
 
 	if (profile->num_slots == 0)
@@ -404,6 +413,7 @@ void blk_crypto_reprogram_all_keys(struct blk_crypto_profile *profile)
 
 	/* This is for device initialization, so don't resume the device */
 	down_write(&profile->lock);
+	memflags = memalloc_noio_save();
 	for (slot = 0; slot < profile->num_slots; slot++) {
 		const struct blk_crypto_key *key = profile->slots[slot].key;
 		int err;
@@ -414,6 +424,7 @@ void blk_crypto_reprogram_all_keys(struct blk_crypto_profile *profile)
 		err = profile->ll_ops.keyslot_program(profile, key, slot);
 		WARN_ON(err);
 	}
+	memalloc_noio_restore(memflags);
 	up_write(&profile->lock);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_reprogram_all_keys);
@@ -466,6 +477,7 @@ int blk_crypto_derive_sw_secret(struct block_device *bdev,
 	struct blk_crypto_profile *profile =
 		bdev_get_queue(bdev)->crypto_profile;
 	int err;
+	unsigned int memflags;
 
 	if (!profile)
 		return -EOPNOTSUPP;
@@ -473,10 +485,10 @@ int blk_crypto_derive_sw_secret(struct block_device *bdev,
 		return -EOPNOTSUPP;
 	if (!profile->ll_ops.derive_sw_secret)
 		return -EOPNOTSUPP;
-	blk_crypto_hw_enter(profile);
+	memflags = blk_crypto_hw_enter(profile);
 	err = profile->ll_ops.derive_sw_secret(profile, eph_key, eph_key_size,
 					       sw_secret);
-	blk_crypto_hw_exit(profile);
+	blk_crypto_hw_exit(profile, memflags);
 	return err;
 }
 EXPORT_SYMBOL_GPL(blk_crypto_derive_sw_secret);
@@ -486,6 +498,7 @@ int blk_crypto_import_key(struct blk_crypto_profile *profile,
 			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
 {
 	int ret;
+	unsigned int memflags;
 
 	if (!profile)
 		return -EOPNOTSUPP;
@@ -493,10 +506,10 @@ int blk_crypto_import_key(struct blk_crypto_profile *profile,
 		return -EOPNOTSUPP;
 	if (!profile->ll_ops.import_key)
 		return -EOPNOTSUPP;
-	blk_crypto_hw_enter(profile);
+	memflags = blk_crypto_hw_enter(profile);
 	ret = profile->ll_ops.import_key(profile, raw_key, raw_key_size,
 					 lt_key);
-	blk_crypto_hw_exit(profile);
+	blk_crypto_hw_exit(profile, memflags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_crypto_import_key);
@@ -505,6 +518,7 @@ int blk_crypto_generate_key(struct blk_crypto_profile *profile,
 			    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
 {
 	int ret;
+	unsigned int memflags;
 
 	if (!profile)
 		return -EOPNOTSUPP;
@@ -512,9 +526,9 @@ int blk_crypto_generate_key(struct blk_crypto_profile *profile,
 		return -EOPNOTSUPP;
 	if (!profile->ll_ops.generate_key)
 		return -EOPNOTSUPP;
-	blk_crypto_hw_enter(profile);
+	memflags = blk_crypto_hw_enter(profile);
 	ret = profile->ll_ops.generate_key(profile, lt_key);
-	blk_crypto_hw_exit(profile);
+	blk_crypto_hw_exit(profile, memflags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_crypto_generate_key);
@@ -524,6 +538,7 @@ int blk_crypto_prepare_key(struct blk_crypto_profile *profile,
 			   u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
 {
 	int ret;
+	unsigned int memflags;
 
 	if (!profile)
 		return -EOPNOTSUPP;
@@ -531,10 +546,10 @@ int blk_crypto_prepare_key(struct blk_crypto_profile *profile,
 		return -EOPNOTSUPP;
 	if (!profile->ll_ops.prepare_key)
 		return -EOPNOTSUPP;
-	blk_crypto_hw_enter(profile);
+	memflags = blk_crypto_hw_enter(profile);
 	ret = profile->ll_ops.prepare_key(profile, lt_key, lt_key_size,
 					  eph_key);
-	blk_crypto_hw_exit(profile);
+	blk_crypto_hw_exit(profile, memflags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_crypto_prepare_key);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
