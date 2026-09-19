Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB8C982CC
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 19 Sep 2026 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JZHnQoCQQ/SWouWmCqSErnL2ERHaMF2NtW3X691zJ54=; b=P9NT2Q8chUEl3gkvy8z6XY++VR
	LgrKzM/1fv7tg8DcFPzV0A8MJCiDpyXXx0yxXIEXB5fVXiX+tWKuO4n3c9JBpigDHabhNYirShmgy
	pMK3JWJ2EyOwDcerV6SgAHdISV/7AYo7AXGgk/RRmCT8R8vaHUDdF6pR6OhqhF49ZEAc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7upK-0000cc-OW;
	Sat, 19 Sep 2026 13:09:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kaixuanli0131@gmail.com>) id 1x7upJ-0000cV-Mf
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 13:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y5Tjh3GexCBzXdpLVPsyPNiT6yr4CdLK794OeNiom9k=; b=ag/53ztPHhSPJoXVD599XGf6rF
 ePubxE529St7RJYCyjDPjWeLoFXJQ/QiBXpzJO/SPbqXxc7v2HTePLhMDVqB15+jbGc+wTuoLGLzB
 fGfB493BGbyKOKUEIfCjaxZmCjnz0zxvLXXjhBA2UifjKkbTig+T97vDmFgO7X2gpX2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y5Tjh3GexCBzXdpLVPsyPNiT6yr4CdLK794OeNiom9k=; b=f
 V3YAOaubzkx9ls9NIMAztyq15C4woCv7+AIEO7t09tgmB1XK1k8E8Q7gRzNZFdwjWd8Iy0L2rXOxY
 VSAFOljdlDsYgFloqWmrPj8xvm7lZVsAquL6SU1h3r95jPRKRvtB0aNTvvzJlbPFa1G+Ofx8TmJ+w
 hQSmIXkxXhGme24o=;
Received: from mail-pz2-f41.google.com ([74.125.228.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7upJ-0004Rd-Rh for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 13:09:58 +0000
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469b355ffso1025853b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 19 Sep 2026 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789823392; x=1790428192; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y5Tjh3GexCBzXdpLVPsyPNiT6yr4CdLK794OeNiom9k=;
 b=WAFtchpJhdh9hzGbCgNArvkxHZ9ADN59TUdgaYilptZ4ouGBEDHS+dY3hPzttmZAkw
 IO1QKhtHy2kLR7pWEjy+jFCS8Je9HJz6h2aBkhOz7HApvvyVr56/iAh+AvGFlXh2Q3VI
 kNt2DdC5u5M4x/LANgMxjO9Lofq2X1ssWR3HSoLZ6xCh9TPtPfwnQinvCY8qLEvgVa47
 ULg5eoT4cTAMEnEYn7gIWuSWzpQCayG6/K5n0YOmWP8n6dM29ydmW/MbhZzk0uLwDFS0
 /Y66j6JgOmFM20zthNFBZ7nTqWpdSYI7crXLF0r3MvLwnN+yLCMgMruwwK+3SS2cTbwt
 seVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789823392; x=1790428192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y5Tjh3GexCBzXdpLVPsyPNiT6yr4CdLK794OeNiom9k=;
 b=ZMbEUYmosx07gvR8wDNmn/hd2Jr0wRaUTR+JaHNVmCcB3xLKDyPn54YnzH6n7y1sRT
 qN0Gf7M8RuXMv6sWHLophIz9GbE0AKcMGM9XN+p+POSE3UWvpX1md4uJEXw3leXPqTXP
 dTaEXScsoQs4zx5Hqz08Go4a5BHDOMIVBe2g3sgK5s64gyyBKTU2NYevMqQ8VUcvjMhz
 JAoIeYkwevcR5kzjvtY5RNXZHw9NGy1rH/ht1DsQ2JY3mSJ3zRq/sq+KM68XZskDYNCj
 d12CqKBpWogcQzycTwaXlOZkSHGUcKjGOVOo2ZCLZrVtveb/sI5J4nwYhzuos7Cot5de
 tOqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKeqKPQkfC/163o+3NoJJxWY3GR96rb+YLRSYmJ8tAvJy9P0x1zuk27gGL+vU3eMMbdamOMSM89rUbTFlsjKLo@lists.sourceforge.net
X-Gm-Message-State: AFuF++lpqAm5ykG0RmWbVd2+luBzP0K+bRXEQNbB5nHryYS+3hDdeXim
 /6O/O6Bo2d8I227VvOexiTa5YiRxl5SJuuwNF1S3KplPN8iPkz/3W0ya
X-Gm-Gg: AYBFou1J70Prph8H9Nu0WVJfu4I6yl11V27ifdQGsmZ/rcMQwjK3wqxnHE2F+ccPYsm
 D+o7eZlpQ1+GaE6mCy5hO9hapJb5C9fkdtaDiOuXxdUFR7pEpu1O/PAOo8ZjU/hA78SOoIcrZX9
 kI78l4cmjD46xexeddJRRU6wQRhXRRtK8kn+dSwKZ8XM+7C777sj7Uz+VqXzbEouf3865OoQr5/
 EUoGjesfwiuIDY22EpdSm3of1mtsmnH0yZCdt/QOqpaqpLiztT5wgFyLhX+pjmJwkRfkPm2uqb9
 y3AXiTcz9E7wOlpMSyOoTgEzaTlK5n0odt5SUp506qpB2P9UJxLWCVhcOn835Bg4FXWfQ29dUSt
 tfpu4E8tyXcBXs6y+ySW7/WRz+6PJcpAcy0K8T7LuSLWpzkUyXf6a5/SQgHeu5riG3Hf8Zc/go+
 VW0K1SEPE3lJjWtQ/EiX4dZz/Jrpq6Hp3PEWyj5VpBIlW/a9i5+9UCO6ht3yw7aSvYRAPoCQcTa
 ik4vZhfXybzVYNZSgyGrW1ZQe/Z9REgsBC8
X-Received: by 2002:a05:6a00:94e7:b0:878:34d7:6997 with SMTP id
 d2e1a72fcca58-87834d76dcfmr1434910b3a.39.1789823392057; 
 Sat, 19 Sep 2026 06:09:52 -0700 (PDT)
Received: from csl-conti-dell7859.ntu.edu.sg ([155.69.199.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877aa6fd3ecsm1025493b3a.59.2026.09.19.06.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 06:09:51 -0700 (PDT)
From: Kaixuan Li <kaixuanli0131@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sat, 19 Sep 2026 21:09:24 +0800
Message-Id: <20260919130925.1899994-1-kaixuanli0131@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1x7upJ-0004Rd-Rh
Subject: [f2fs-dev] [PATCH] f2fs: bound the SIT/NAT bitmaps by the
 checkpoint pack
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
Cc: Kaixuan Li <kaixuanli0131@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

sit_ver_bitmap_bytesize and nat_ver_bitmap_bytesize are used as memcpy
lengths into and out of sbi->ckpt, which is sized from cp_payload alone,
and nothing compares either length against that allocation.

sanity_check_ckpt() has checked these two fields since c77ec61ca0a4, which
added them after a crafted image overran build_sit_info(). That check ties
each length to a segment count; it never compares either against the
allocation, which is the half this adds.

Mounting over-reads in build_sit_info() and build_node_manager(), and the
first checkpoint writes the same lengths back through the same pointers,
so the over-read's contents reach the on-disk checkpoint. An unmount is
enough; the filesystem does not have to be used.

Bound both ends the way __bitmap_ptr() lays them out. The three branches
differ, so a single sum of the two lengths would still admit a small
overflow when cp_payload is non-zero.

Fixes: c77ec61ca0a4 ("f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize")
Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
---
Reproduced on v7.2.4 x86_64 with CONFIG_KASAN=y. Two crafted images from a
plain mkfs.f2fs 512G volume, with segments taken off the SSA area so
main_blkaddr does not move:

	cp_payload 0, segment_count_sit 20 -> 220
		sbi->ckpt 4096 bytes, SIT bitmap at +192 for 7040, NAT at
		+7232 for 3200, ending 6336 past the allocation
	cp_payload 2, segment_count_sit 20 -> 520
		sbi->ckpt 12288 bytes, SIT bitmap at +4096 for 16640,
		ending 8448 past

	case                    kernel    result
	crafted cp_payload=2    stock     mounts and unmounts
	crafted cp_payload=0    stock     mounts and unmounts
	pristine mkfs.f2fs      stock     mounts
	crafted cp_payload=2    patched   rejected
	crafted cp_payload=0    patched   rejected
	pristine mkfs.f2fs      patched   mounts

with the patched kernel naming the numbers:

	Bitmaps do not fit the checkpoint pack: sit ends at 20736, nat at 3392, pack is 12288 bytes
	Bitmaps do not fit the checkpoint pack: sit ends at 7232, nat at 10432, pack is 4096 bytes

Setting sit_ver_bitmap_bytesize to 7040 while leaving segment_count_sit at
20 gives "Wrong bitmap size: sit: 7040, nat:3200" and the mount fails, so
the field is read and the only thing checked against it is the segment
count.

KASAN does not flag the copy: with cp_payload 0 the allocation requests
exactly 4096, so there is no in-object redzone, and at 12288 it went
unreported too. What the cp_payload 2 image does produce, on one of three
runs with a freshly built image each time, is the corruption landing at
unmount:

	BUG: KASAN: slab-use-after-free in kthread_stop+0x23/0x390
	Write of size 4 at addr ffff88800a329fa8 by task init/1
	Call Trace:
	 kasan_check_range+0x39/0x1c0
	 kthread_stop+0x23/0x390
	 f2fs_destroy_segment_manager+0x176/0x9b0
	 f2fs_put_super+0x635/0x10e0
	 generic_shutdown_super+0x13e/0x440
	 kill_f2fs_super+0x24e/0x500

Which neighbour it lands on varies.

Mounting a crafted image is not a Linux kernel vulnerability
(Documentation/process/threat-model.rst), and I am not reporting it as
one.
---
 fs/f2fs/super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4180,8 +4180,9 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t user_block_count, valid_user_blocks;
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
 	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
@@ -4308,8 +4309,31 @@ skip_cross:
 			 cp_pack_start_sum);
 		return 1;
 	}
 
+	/*
+	 * Nothing above ties the bitmap lengths to sbi->ckpt, which is
+	 * (1 + cp_payload) blocks. Bound both ends the way __bitmap_ptr()
+	 * lays them out.
+	 */
+	ckpt_size = (unsigned long long)(cp_payload + 1) * F2FS_BLKSIZE;
+	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG)) {
+		nat_end = CP_MIN_CHKSUM_OFFSET + sizeof(__le32) + nat_bitmap_size;
+		sit_end = nat_end + sit_bitmap_size;
+	} else if (cp_payload > 0) {
+		nat_end = CP_MIN_CHKSUM_OFFSET + nat_bitmap_size;
+		sit_end = F2FS_BLKSIZE + sit_bitmap_size;
+	} else {
+		sit_end = CP_MIN_CHKSUM_OFFSET + sit_bitmap_size;
+		nat_end = sit_end + nat_bitmap_size;
+	}
+
+	if (sit_end > ckpt_size || nat_end > ckpt_size) {
+		f2fs_err(sbi, "Bitmaps do not fit the checkpoint pack: sit ends at %llu, nat at %llu, pack is %llu bytes",
+			 sit_end, nat_end, ckpt_size);
+		return 1;
+	}
+
 	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
 		le32_to_cpu(ckpt->checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
 		f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap, "
 			  "please run fsck v1.13.0 or higher to repair, chksum_offset: %u, "


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
