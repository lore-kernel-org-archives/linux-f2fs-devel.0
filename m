Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0EACCF2E3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DaUZcUNIzxNFGcM7Sf67qj0nTzgU3WZ+0MiqLny+U7A=; b=bE78VDYVd1CrcmHS9pymjZf/60
	Y5O/OoL1UB+09lTd8NCsQ1O99Yr0XDyJlMRgbAYx+Dxe6AnZaCf0T7GjCBylBrIPq/s3NSvewUgXl
	8ovvjt2pIybp7LPsRTZnebwbJvx5zoAbsqmmYMCCcHKV6OIuSN8A0kh6lIOaqxZgchjQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xImzL-0005rD-Gu;
	Mon, 19 Oct 2026 13:01:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kaixuanli0131@gmail.com>) id 1xImzJ-0005r7-Nk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:01:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uF0K/ISANlcRJVgbX3KWpFeOAEFaBPifEi/Tk1Z5Lrk=; b=OJaPLI9GddxT4chnake1UDDEhv
 1LF0IAedKeORphUjEgc8ybQdWb1GlNtw3VY5EElvFWOYRnYvLbUpALZgdvt5p2lonJaKHzvltGFnu
 fggv7hn42QDlJsmYKp46F1fCXgKBbI8DGc88IiflULwYtsbg7ZRMHiJjYmCr6YzqX0wM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uF0K/ISANlcRJVgbX3KWpFeOAEFaBPifEi/Tk1Z5Lrk=; b=ENbdrzQWfz87f6A46zEiV1cFtB
 AiPvI9vmwxK6DAgNy/HMdwGd3E2l3o9yiHMAd1HC3GH4/RGPhrMk+nU5szm0FtuigvcItLVh9Y6ZU
 IhvrPIGmV81c2380aaAbut35uIEEs9/s4k/zeBcJwXnb7Y3MLdv2H7+yLfRuSkn4jQaQ=;
Received: from mail-dy1-f175.google.com ([74.125.82.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xImzF-00026Y-S4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:01:11 +0000
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso6056795eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792414864; x=1793019664; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uF0K/ISANlcRJVgbX3KWpFeOAEFaBPifEi/Tk1Z5Lrk=;
 b=sw9SVHza3BUgR2TmaJ0DGpOO3YLUq4fappBk9+sWShijXy8wB7lmsV3red7pT7uZWp
 yUZ+Fw+Hp8EtyMQXmUbOIBGkfz68LNKKZdp9CV4l4Js5wuNV5ZBL82NyQNxRmrg1vgam
 j1jG86Xo89/WXm6323S2AomlOPAZFhV3FxmyNL+FTbj5P4+J0NISApuAq1oKTiehGu6z
 olut4P/cWMfzE7heztGymglv6Zg1uOHMgrF6bLlD0b1mJX5p62QXyQYrRhQ8x4PItfK9
 0BJOd0NiuNiWEDVTvBEeUP3W9Sv+hX+2+9/DaP3lDNH3MBcVEdFQuKsT7aPmANR4GRUk
 GgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414864; x=1793019664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uF0K/ISANlcRJVgbX3KWpFeOAEFaBPifEi/Tk1Z5Lrk=;
 b=Vvt81I+XAa+0OEahuwiQnTU2uUdyAO58sY9qY3EFyWhjaIuU63S6lZxfQFEmry2fjS
 yiONQKgwvkHg2tM1Zk+wkti6jIzHLvzUyaX9bmL5Qfz9vtdHdvNc1SD7RqDalbcEgC7a
 GuNTYKv0D6WisWNo0IVVNymB/RODpYfNDuEZvzjfErrnXVfI+3ChzXFX+hG1ulfTrNYn
 7MgITAI0dPRoB4FH4bqbTqJQvqxCBpxaYFGcXF8l6Zwg66rTr2/xpWYzbapCa7Asaav0
 dSm2FoCtxNZ5KWdF4EOkNtWmdgegL7tTNNmaXdskPJg2fZVFQ2oZlp1UetJ/D80wgYf0
 Fl5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWxZ9mUHVJzfDAdjHY1ys8IfHWRfaskW2KAphejbaThjkIlMjh7TuvYbem72RLwXfYOejGX2pi0gLa3Q6yrhng@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI8rTUfhG6IeOdEbC+/HIsKmLUtpXm0UE5UjdEyTG8UXS2oBKky
 0wv1z8i74SBnZFKexqGPTEcA1iHh5T7dXPdatqwLIkxzrESlVuV9naC0
X-Gm-Gg: AYBFou2rDk3jmshAWXbF0wbdlSUJdfoX5FOeL2Ry1nxB3Sk+rsI06NNQnRGj3REcZQ/
 X3ueweDgu9KiT8VfxKAlUDIMuzD4VcwmSt3m+++PvRWEc4NRVcftRdDDNk8xyUG5DOIGOdnPmkJ
 aa4F2ijRlV/L5Q6vtUJahgURuNYP71RRx8C2sd6T8Tqse2Ce5Y134v9M5wZczzaWHFPWizLAoIP
 DaRRy33Mn/zsYO9x738Pn9vZzNNHRcpEOOkuttDfPPhBh+VpVKCM970GctSu23lpPwrP9/spxBM
 AUAJGUS4AV3QHjdWHh8sv53slgcXeddWNWfKN5Vy2/6Kh4k45rZCvYnELJrMmrOZAZKImWQISRj
 VxtsIgroVC8FxMCXArO7Lp94t92+pNRXOo5r+i2FdTfwaqeeBt4ilGXij4TSUm+ZZWElmrZvFcb
 rps8fuPIBXTytROu9DxhuBxmL6oALxI0ActKY0nmNF82NRMwuK5J4aCu84H4oXZe/k9jWCLmAlt
 iUVT/eNjoQguKkimu6uSoJJLUVZRFqL12k=
X-Received: by 2002:a05:7300:ce16:b0:351:45a4:7dd8 with SMTP id
 5a478bee46e88-361a2843701mr10814906eec.34.1792414863570; 
 Mon, 19 Oct 2026 06:01:03 -0700 (PDT)
Received: from csl-conti-dell7859.ntu.edu.sg ([155.69.199.57])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b684dsm32263303eec.10.2026.10.19.06.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:01:02 -0700 (PDT)
From: Kaixuan Li <kaixuanli0131@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 19 Oct 2026 20:59:22 +0800
Message-Id: <20261019125922.2568859-1-kaixuanli0131@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919130925.1899994-1-kaixuanli0131@gmail.com>
References: <20260919130925.1899994-1-kaixuanli0131@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xImzF-00026Y-S4
Subject: [f2fs-dev] [PATCH v2] f2fs: bound the SIT/NAT bitmaps by the
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
Cc: Kaixuan Li <kaixuanli0131@gmail.com>, stable@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
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

Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
Cc: stable@kernel.org
Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
v2: Fixes now points at 39a53e0ce0df; nothing bounded the two lengths
    against the allocation before c77ec61ca0a4 either (Chao Yu). Cc
    stable. Add Chao's Reviewed-by. No code change.

v1: https://lore.kernel.org/linux-f2fs-devel/20260919130925.1899994-1-kaixuanli0131@gmail.com/

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
