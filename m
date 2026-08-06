Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA13C5AC7A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pUf0SbTgfeaR0r86b7xwT6Rz0G8xc9N0ORDL7xBwvsI=; b=hcYpqFvQUtxsRm880ApWpQg+zl
	Urd47X03itdHbSzUuCK+2ktsJtGSqtaUWZZ12f76TOR3QOYyU0PiHynHsew08OgOyBxou6bd6unji
	VsUPOclaW8jXZicTziTlvHUwKxme0pnrxGulYjDCRtXe+FvFqsB0kiTDuFcskGCNj6pU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wry0V-0001qd-Tg;
	Thu, 06 Aug 2026 13:19:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wry0U-0001qN-0Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:19:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qH6NFT0tYuJsdVJLEgEW/19IUCowEEcb5ZeoR1Zxho=; b=NUT3dDnrlQa/n9vmTcSnPVba+F
 mZo/ymKIqxlG/Jeiixm+3Gk3SdGEWDFFDSg1DxDcA1YQKzdmUpGttLRUForwagmsJIBm1NmUL20yZ
 HQSSFGJpX4KzVjoyOLYUmxJZroC7UdX6YMjdOl98BVEmV8t1s7CYKOx/1SXLuDHICmGg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4qH6NFT0tYuJsdVJLEgEW/19IUCowEEcb5ZeoR1Zxho=; b=C
 WYVEZQpv536vGxKznKk7AaYRQOH0lN/1IAbjnc7uQOfIPiL2xUOirNabHQ63r28j6qdkynkZ9vrmZ
 HsVDFK5V7uUFXr0212BufMTvsqLdkkfEPbcGAWPAnvNfEnKBQrQYXrIZSJ7Qjn7dEYqQSMz4Uf/+v
 cZET2X+Smdyeq3ig=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wry0V-0005ue-Nx for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:19:34 +0000
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso21030245ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786022366; x=1786627166; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4qH6NFT0tYuJsdVJLEgEW/19IUCowEEcb5ZeoR1Zxho=;
 b=k/mNFhX61wrfQ6yhfxtTujl2JUlryezFuwDXmf7MZXg0QnlubempoPnz8rmx3gG/WY
 fsLazIuJ6JlixYd/rhsweHKyHN/5pYUIPz86ALHle1wzlMe2e4kIXv6J5I5ApmqOkN7X
 Sx04i9XO9wI1W1VgOS7PCeCCysHVSSNo6NlbNiXaNGg/CwRctSpuMhbZthHDVI+uf7yt
 b+GRV+h8czadVfi0oeitBa6agiIFBL5Bpy/XxMP1OgdVozFQ/nE6TiLxPE35lzfGJiAU
 PgjCUQ1dczKHkqdM22HzN0mWYB0vL3fnI3PfVDT15s3h3bbmQvG+Rb3eZqLLCzziPsig
 RVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022366; x=1786627166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4qH6NFT0tYuJsdVJLEgEW/19IUCowEEcb5ZeoR1Zxho=;
 b=EkXPXeLHAJAunVapU1+OCwOiFHWXyCWTwwPcfPo7dDjJsOB1ANOI26ectR/KqOlWVe
 RINWDR2DbI/VBSDjXGZXyI6jcjpGq5XzsnLQDQErEhiwld8qu/5m1IJmEP/nRyP2mb4+
 UnSxNAPJenS1AXOYStJ6SczikHeMkUDBiFM4wW1ymm3gvd0obLcXRrHWkgo+GSbYrknF
 d+IGqbTdg/WjG2218hZCs7orvwn8TwbpR2lWUumYIRKzXdguxPAE5Y2EwOMM0EcghYY/
 7NqrMQJnskjdurZkqBTuL+RCbjCaAYxDiGINsouUtJQ3BK4T4Ds4ohd8s5Kc+XGuQb9N
 nmXw==
X-Gm-Message-State: AOJu0YxKet3t6ZWbUqqW+gyF8sBLKuYZVhUYTUIdX2c5T0TFklUQXf9l
 ABVM1b2IN8o+bvHAsDUm0gNplPZg2y98c6kzvSATL6nElSGPg6FPyJtIlCIfFZoA
X-Gm-Gg: AR+sD10YOCkUze9iUcLaU8bAqZP9R5tilmDHUGoU3E2MAk0QWdyQdxE6AFkLByZlEKr
 H8Qc5q4FcJwVVXl7QYD7KZgoN5VR2sJEcaKXLIADSRhOGcpudRVPyttbkOeGhMLAUOo1IKYygCx
 lBvs3dlKhFfHM2VX0aBHAP4taX685RTexNJeIJ5pIiXCpLlJXZpuUYb3lb+dx5Al9mAUFvIHbUr
 i6Zk/hO6BKlYDAU80Aguqj1FJ47vW+jHKCDOUBpIhHZ/Mjb3tGhhca+tfcxPmWXb9B3qnS4pqzX
 ROnC7x+SN+O/2BEpbNjL2fORhmRprDmGGVvIcwexIqXiEWkewEqi0G++i5qI27PeTMqThKQ+4WH
 gOuc29w3JKDXCq0dPgsq1t4AVjaS3ARF+vFTk4NeVp/uk5pwQk1uN3MmIM2txqz/bU2THw0KnD8
 IFrG0/nyLH29daeAcx3VvW1gOLBYg8emcOZanIGKoZvyIF1Fp91n+w+jRjhjbC+OnlIxGc9TgrX
 6r/39HOsWQEW1ea1vqFyGuxJfccvHesvYc=
X-Received: by 2002:a17:902:f60c:b0:2cc:aa36:c04c with SMTP id
 d9443c01a7336-2d0ca7afcabmr175964785ad.1.1786022366364; 
 Thu, 06 Aug 2026 06:19:26 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9ffb2f7sm31736355ad.29.2026.08.06.06.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:19:25 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  6 Aug 2026 21:19:00 +0800
Message-ID: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wry0V-0005ue-Nx
Subject: [f2fs-dev] [RFC PATCH v4 0/3] f2fs: introduce inline extent mapping
 for inode data blocks
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

Changes since v3:
- Do not cache NEW_ADDR in the inline extent area. A NEW_ADDR write is
  now handled exactly like NULL_ADDR: it only unmaps the block.
- Simplify the insert path. A single-block overwrite is now expressed as
  four small steps:
  1) reserve room for a possible split.
  2) unmap the old mapping of the block.
  3) insert the new mapping.
  4) try to merge the inserted mapping with its left and right.
- Remove the inline-extent code-coverage statistics.

v3: https://lore.kernel.org/all/20260724125847.3928772-2-yangyongpeng.storage@gmail.com/

Changes since v2:
- Inline extent no longer covers direct block mappings. The inline
  extent area is now placed after struct f2fs_inode->i_extra_end,
  inside the i_extra_isize region. This removes the need for format
  conversion and for f2fs-tools to understand/modify the inline extent
  on-disk format.
- Split struct f2fs_inode->i_compr_blocks (was __le64) into __le32
  i_compr_blocks + __le32 i_inline_ext_capacity, where
  i_inline_ext_capacity records the per-inode inline extent capacity.
- Dropped [RFC PATCH v2 1/5] "replace raw dnode pointer arithmetic with
  f2fs_data_blkaddr()": f2fs_truncate_data_blocks_range no longer needs
  changes to accommodate the redesigned inline extent.
- Dropped [RFC PATCH v2 3/5] "support setting inline extent flag via
  ioctl": format conversion between inline extent and the direct block
  address array is no longer needed.
- Re-ran the performance tests (see updated numbers below).

v2: https://lore.kernel.org/all/20260529085629.2664539-1-yangyongpeng.storage@gmail.com/

Changes since v1:
- Introduce tracepoints for f2fs_iext_update_data_blkaddr and
  f2fs_iext_lookup_blkaddr to aid debugging (new patch 5/5).
- Bypass inline extent lookup for F2FS_GET_BLOCK_PRECACHE to ensure all
  mappings are loaded into the read extent cache.
- Unify the check for fofs exceeding direct_blocks range to use
  "fofs >= direct_blocks" consistently.
- Remove support for caching NULL_ADDR in inline extent area. If a fofs
  within [0, direct_blocks) is not found in inline extent, it implies
  NULL_ADDR. This simplifies merge and split logic.
- Fix f2fs_iext_enable_inline_extent to use PTR_ERR instead of -ENOMEM.
- Change f2fs_iext_convert_to_inline_extent return type to bool.
- Add benchmark data covering 4K/8K/32K/64K random read.
- Rename __is_extent_mergeable to __is_iextent_mergeable to avoid
  naming collision with extent cache code.
- Remove inode parameter from f2fs_iext_sanity_check (always NULL).
- Reduce #ifdef CONFIG_F2FS_INLINE_EXTENT nesting in node.c.
- Code style fixes to comply with kernel coding style.

v1: https://lore.kernel.org/all/20260507113840.1353304-2-monty_pavel@sina.com/

This patchset introduces an inline extent mapping mechanism for f2fs.
Instead of storing individual block addresses for indirect-node blocks,
this feature packs contiguous block ranges into compact extent entries
stored directly in the inode, reducing indirect/double-indirect node
page reads and enabling O(log n) block address lookup via binary search.

Design overview:
- The inline extent area is placed immediately after i_extra_end in the
  on-disk inode, within the i_extra_isize region. Its size (number of
  extent entries) is determined by the new field i_inline_ext_capacity.
- On-disk layout:
    [i_extra_isize .. i_extra_end] [f2fs_iext_header | f2fs_extent[cap]]
    |<------------------ i_extra_isize (in bytes) ------------------->|
- Inline extent only caches mappings for indirect blocks
  (fofs >= ADDRS_PER_INODE). Direct block mappings continue to use
  i_addr[], so no format conversion is required.
- Per-inode capacity is decided at file creation time based on the
  configured file-extension matching rules (see sysfs below).
- Mutually exclusive with compression.

Patch 1: Core implementation -- data structures, extent operations
         (lookup, insert, merge, split, truncate), and integration
         with the f2fs data/node/inode/recovery paths.
Patch 2: sysfs interface -- runtime enable/disable toggle and the file
         extension list (with optional per-extension capacity) for
         automatic inline extent activation.
Patch 3: Tracepoints for inline extent lookup and update operations.

Test setup (Xiaomi smartphone, UFS 4.0 storage):

  echo 1 > /sys/fs/f2fs/<dev>/inline_extent_enable
  echo 'mp4:256' > /sys/fs/f2fs/<dev>/inline_extent_extension_list
  fio --name=test --filename=data.mp4 --rw=write:4k --bs=64M \
      --size=8G --ioengine=libaio --direct=1
  sync
  fio --name=test --filename=data.mp4 --rw=write --bs=64M \
      --size=8G --ioengine=libaio --direct=1
  sync
  echo 3 > /proc/sys/vm/drop_caches
  fio --name=buffer-read --ioengine=libaio --rw=randread --bs=$BS \
      --size=8G --io_size=1G --numjobs=1 --filename=data.mp4

Results (random read bandwidth, MiB/s):
+---------------------------------------------------+
| BS     | baseline | inline ext | improvement      |
|--------+----------+------------+------------------|
| 4K     | 31.6     | 32.4       | +2.5%            |
| 8K     | 55.4     | 58.5       | +5.6%            |
| 32K    | 155.3    | 166.8      | +7.4%            |
| 64K    | 229.8    | 255.3      | +11.1%           |
| 128K   | 337.8    | 388        | +14.9%           |
+---------------------------------------------------+

The improvement comes from eliminating indirect/double-indirect node
page reads during block address lookup -- indirect-block mappings are
stored directly in the inode page and found via binary search.

Yongpeng Yang (3):
  f2fs: introduce inline extent mapping for inode data blocks
  f2fs: add sysfs interface for inline extent management
  f2fs: introduce tracepoints for inline extent lookup and update

 fs/f2fs/Kconfig             |  18 ++
 fs/f2fs/Makefile            |   1 +
 fs/f2fs/data.c              | 146 +++++++++-
 fs/f2fs/dir.c               |   1 +
 fs/f2fs/f2fs.h              |  44 ++-
 fs/f2fs/file.c              |   1 +
 fs/f2fs/iextent.c           | 535 ++++++++++++++++++++++++++++++++++++
 fs/f2fs/iextent.h           | 136 +++++++++
 fs/f2fs/inline.c            |   1 +
 fs/f2fs/inode.c             |  41 ++-
 fs/f2fs/namei.c             |  67 +++++
 fs/f2fs/node.c              |  38 ++-
 fs/f2fs/node.h              |   4 +
 fs/f2fs/recovery.c          |  15 +
 fs/f2fs/super.c             |  29 ++
 fs/f2fs/sysfs.c             |  91 ++++++
 include/linux/f2fs_fs.h     |   3 +-
 include/trace/events/f2fs.h |  79 ++++++
 18 files changed, 1229 insertions(+), 21 deletions(-)
 create mode 100644 fs/f2fs/iextent.c
 create mode 100644 fs/f2fs/iextent.h

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
