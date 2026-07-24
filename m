Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A5CC531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UT8lYwHje4PVUV0ZLpKZmMbCI/EMhipRia9ppK2gF6k=; b=DRj/uuhSMe9+qQRu11k0WL1wh+
	gBmB76TEhFtbQF0rIcZB/67o+SWEKJVJS/e91lTxBJYNouPxEOHkLzOSwYjYP2xLRty+bB89DNLuI
	YqDzK0xJGskU2HjopqjwXJj5hh3Ql54SWHGVzfzWhqEzPM2dBHJjjTBaSmw3c7VjXXfc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnHyb-0006Y8-Jv;
	Fri, 24 Jul 2026 15:38:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wnHya-0006Xy-36
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:38:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qsmLhMuXoVzNlk4bQ/7bqAn6Yi2fslBw1ZmXsjLrQyA=; b=DebWiD4qq7GRjDBnjr26gWUuSi
 t2lllmg9lsvf/sQp246Hqhnnkb6C4zWNAn9J4/2ADpqdzTvsfA+KDB1GdllT63RH8QivGaT9rhbWe
 rrFdU0a/CP5bfLUC/c4X+rhzKOc2U8zwXxhTpGtOQnCyeoDPW4J/zIsujuT6Ve5AFCmQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qsmLhMuXoVzNlk4bQ/7bqAn6Yi2fslBw1ZmXsjLrQyA=; b=h
 2YCKJAJKy4yUoRwjsHtFYqlS3GS/ZybKWato0VLGTbFrozeGjd3N+tsGKXNtYvhW3yvSKxXpa04No
 rViQpzy5d52UTu7Q85wiZxOYCzRtg1564xnTwoSLuKdHRW+vmpiQYEkZDf/i9inu+BFxGYWdzxz/V
 n7s5Io8HDWcBs2hA=;
Received: from mail-ua1-f53.google.com ([209.85.222.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHyZ-0007q0-EF for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:38:16 +0000
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-966e7380109so327086241.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784907489; x=1785512289; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qsmLhMuXoVzNlk4bQ/7bqAn6Yi2fslBw1ZmXsjLrQyA=;
 b=Rx5fGYAtUZAucE5lbI+nDr4kFIVuSNx/gRZvbvnqy+ldwzQEoM1yeL4aWJTY+xL1aM
 iXX5Up75oxH8eiwGSu7YHeKFSniScy+IcrFvDUIf2k+GoPwSNo6vOfwycKohAeKgDVu5
 ZPbY5yqlfTG13ZNrzDNn2RsyKeJffDzmTCiG1kN4QtaG3yHqdTD08omqcCfUmUGujkFn
 WI3E3YuiVBEZw5HNcWdHpMPiwNrMmk17GmzD8QbxA+N0/HFZAVAJmEPSQd8KB9CTtfLR
 nE8hpZXzDfEUJqngPb2CjFxSLX36WlbozUoy4fiRb6HdQDvFamzbzZ4AnUM4tKiW5X4C
 3vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784907489; x=1785512289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qsmLhMuXoVzNlk4bQ/7bqAn6Yi2fslBw1ZmXsjLrQyA=;
 b=H2/tFR0w476xi2k0I87ZYN28zX9nUzGdw7PLZ+5KagG/+eA75t5ZqbfE7zOc7krurB
 Q8oN0vvL5P33nstqwl+t3jFe0xtpNxdhtp3QBnB0tP6f+lmepOVpISmU6silVkFTxFAo
 /hJM8X72uDHdc8DKlbdH3YwQ7JWjRFTWoC35Vrvt2kDq5QdBl7Gb7w8eLgZZEeSHQhJp
 Lkho0jaUocsTSFr3ba5Ip4ERlS1K46KfINYKJE7pY5vbrTcn/siuJXfzI5HZC3Pwb8op
 E0PG0C5tOl2ZWidPIHQTHRFIoJhI5aINmXIoAKG0e96yNDOCxZrp5feEan0eKy5CQkMw
 pNdA==
X-Gm-Message-State: AOJu0YwlV8Yy+2ZQ1ef7gRLiHUGLBN436+ZyoocjhnQoOU7sDRwCdojP
 30WAsX7yb46g116ro/e+0vYDuq3w135JKPEfoqcgquhMQr59bR9kELV1gL7LHQ==
X-Gm-Gg: AR+sD12jPHI737Rlic3HVHQtazmoagik4gKSQ8V3ZLh5DjWtKYJNC8gNFm9Xghmyg62
 o6ooGzx6EXtKJT0pZi3F6fNRdF7hEI5cAIbDLUoZVCjBDbcG/AFEHrJ/YBnqcGfjKVmD2hcD+Yi
 ixxGjIDlFFabgwgIrYr+2F8sSn4JbT1s6rgS465EOJVFawGClWl+YR03iUo9xq1xU4npPn70Aon
 CvuRKZZb9SXu6qrYBXdXCuhS442K9MbLD1468KM+RENOFOtARC5Wfc8jlZ5IGc5k6snh9XddLjt
 Kb6LxyifOv3PKB5vL+1/fs037S1BbvplzIeNEqCURlmWgV5ELw6546d7U+nI8PNLv07ae+Jis5w
 a/hlkJvIeqGw7cBARMIgz6+fr3GmDhWjwnKKOJAsg+F2W/jn7fvUGjaUf6j7u0ejHb6+TxkzDL0
 Fp6Q9YUPB3AtjxOM+LB8ECKlc3AJzaLV2d2pWFr4tGDWg1du2C
X-Received: by 2002:a05:6820:813:b0:6aa:cce3:ab5e with SMTP id
 006d021491bc7-6aad4163563mr3791019eaf.50.1784897944807; 
 Fri, 24 Jul 2026 05:59:04 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45767486cf6sm7359957fac.15.2026.07.24.05.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:59:03 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 24 Jul 2026 20:58:19 +0800
Message-ID: <20260724125847.3928772-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wnHyZ-0007q0-EF
Subject: [f2fs-dev] [RFC PATCH v3 0/3] f2fs: introduce inline extent mapping
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

 fs/f2fs/Kconfig             |  18 +
 fs/f2fs/Makefile            |   1 +
 fs/f2fs/data.c              | 148 ++++++-
 fs/f2fs/debug.c             |   4 +
 fs/f2fs/dir.c               |   1 +
 fs/f2fs/f2fs.h              |  44 ++-
 fs/f2fs/file.c              |   1 +
 fs/f2fs/iextent.c           | 759 ++++++++++++++++++++++++++++++++++++
 fs/f2fs/iextent.h           | 166 ++++++++
 fs/f2fs/inline.c            |   1 +
 fs/f2fs/inode.c             |  41 +-
 fs/f2fs/namei.c             |  67 ++++
 fs/f2fs/node.c              |  38 +-
 fs/f2fs/node.h              |   4 +
 fs/f2fs/recovery.c          |  15 +
 fs/f2fs/super.c             |  29 ++
 fs/f2fs/sysfs.c             |  91 +++++
 include/linux/f2fs_fs.h     |   3 +-
 include/trace/events/f2fs.h |  79 ++++
 19 files changed, 1489 insertions(+), 21 deletions(-)
 create mode 100644 fs/f2fs/iextent.c
 create mode 100644 fs/f2fs/iextent.h

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
