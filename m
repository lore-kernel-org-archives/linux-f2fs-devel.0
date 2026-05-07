Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E518CD3442
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yflDlIxP0z90ysRtNDrq9jFgx6MfXwLEj2iDPN/8lBw=; b=PR6F5xzQu5EvmcONmWKKzIO4Lj
	zbEmOKqdVrhoGV0lquuTHSJYMMoydNtNKgxRMIrbLdUXYTreBNV4t2d4WUrwJP44UbSYRuQUNYi4W
	cA+cV3WisjJz+H1cUq6OdZ3f1oHj3Ls2KiU+0jFPNoyDNfWJYTjAK6Yh8TdLV+ZTwSyE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKx4h-0004bN-J5;
	Thu, 07 May 2026 11:39:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wKx4e-0004bA-AO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=svhJxA7M8e6jSkmMPFhr1zfRIcx4YEYO7pH4BZPvcGU=; b=Qm0OTAjJuZEwernWolcHY5K9Ny
 vI8tB6jZ8sOceAlp5I6bLOxEyfwjfpN+f++8oAhGaU3U9gopCrQNvhJ5uhUECDqUNrQadT0RNzOM/
 G5Yjn2J7Aaad9fQf89P0rQLKlm5NYFA0BauhGpjSOuQevzYOzMmtPROqBXwkA6B+Qcks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=svhJxA7M8e6jSkmMPFhr1zfRIcx4YEYO7pH4BZPvcGU=; b=i
 pTVpInWVUcFjMOj6KlYZquhWwTS9objjJrO9CJ+01qtq/uXmAveMQs5XRXKBxiFbewCiJzamGm8WF
 9a5rXOSWtdj5KhI4hQj3IbZl2voq2mNL/IJQxWyNF6kxQB99EHDaP3auMJAgt+4fzcCUojLV1k99J
 OUWUKTN8dQzeuHd0=;
Received: from r3-18.sinamail.sina.com.cn ([202.108.3.18])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKx4Y-0002kZ-Ns for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:39:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1778153958; bh=svhJxA7M8e6jSkmMPFhr1zfRIcx4YEYO7pH4BZPvcGU=;
 h=From:Subject:Date:Message-ID;
 b=OwyXfgjYW8GyQPS3Y3VcTdQG9nUgzkdtw02l0L8qOP3IQFog5+EXbnVf6lOfwPjxs
 IoJlwN9MudR/6oIhv1641T1RyNvAdUNwVkVIfoT/8/cpZ0lH3c8Zu6kzPexJNREYKF
 LKIQIjjrPDO62ZtjYtIwOAZjFmGhvL8k6Jquf+qA=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.32) with ESMTP
 id 69FC79D6000021A4; Thu, 7 May 2026 19:39:04 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 8635804456680
X-SMAIL-UIID: 96D5AB7D6EEC42CBB7EFCDCE2F5CFC89-20260507-193904-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  7 May 2026 19:38:37 +0800
Message-ID: <20260507113840.1353304-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wKx4Y-0002kZ-Ns
Subject: [f2fs-dev] [RFC PATCH 0/4] f2fs: introduce inline extent mapping
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

This patchset introduces an inline extent mapping mechanism for f2fs.
Instead of storing individual block addresses in the inode's data block
address area (i_addr[]), this feature packs contiguous block ranges into
compact extent entries, significantly reducing the number of entries
needed and enabling faster block address lookups via binary search.

The inline extent format is identified by magic numbers in the inode
data area and is transparent to the rest of f2fs -- when the extent
area is full or cannot represent the mapping efficiently, it
automatically converts back to the direct block address format.

Patch 1: Preparatory refactoring -- replace raw pointer arithmetic
         with f2fs_data_blkaddr() to abstract block address access.
Patch 2: Core implementation -- data structures, extent operations
         (lookup, insert, merge, split, truncate), format conversion,
         and integration with f2fs data/node paths.
Patch 3: ioctl interface -- allow per-file enable/disable of inline
         extent format via F2FS_EXTENT_FL flag.
Patch 4: sysfs interface -- runtime enable/disable toggle and file
         extension list for automatic inline extent activation.

Test setup and results:
=======================

Platform: Xiaomi smartphone, UFS 4.0 storage

  # Enable inline extent
  echo 1 > /sys/fs/f2fs/<dev>/inline_extent_enable
  echo 'mp4' > /sys/fs/f2fs/<dev>/inline_extent_extension_list

  # Prepare data: write with 4K offset stride to create fragmented
  # extents, then overwrite sequentially so inline extent can cache
  # all mappings in compact form.
  fio --name=test --filename=data.mp4 --rw=write:4k --bs=64M \
      --size=8G --ioengine=libaio --direct=1
  sync
  fio --name=test --filename=data.mp4 --rw=write --bs=64M \
      --size=8G --ioengine=libaio --direct=1
  sync
  echo 3 > /proc/sys/vm/drop_caches

  # Benchmark: 64K random buffered read, 1GB total IO
  fio --name=buffer-read --ioengine=libaio --rw=randread --bs=64K \
      --size=8G --io_size=1G --numjobs=1 --filename=data.mp4

Results (64K random read bandwidth):

  +---------------------+------------+
  | Configuration       | Bandwidth  |
  +---------------------+------------+
  | inline extent OFF   | 284 MiB/s  |
  | inline extent ON    | 321 MiB/s  |
  +---------------------+------------+
  | Improvement         | +13%       |
  +---------------------+------------+

The improvement comes from eliminating direct/indirect node page reads
during block address lookup -- all mappings are stored directly in
the inode page and found via O(log n) binary search.

Yongpeng Yang (4):
  f2fs: replace raw dnode pointer arithmetic with f2fs_data_blkaddr()
  f2fs: introduce inline extent mapping for inode data blocks
  f2fs: support setting inline extent flag via ioctl
  f2fs: add sysfs interface for inline extent management

 fs/f2fs/Kconfig    |  18 +
 fs/f2fs/Makefile   |   1 +
 fs/f2fs/data.c     | 149 +++++++-
 fs/f2fs/debug.c    |   4 +
 fs/f2fs/dir.c      |   9 +
 fs/f2fs/f2fs.h     |  23 +-
 fs/f2fs/file.c     |  93 ++++-
 fs/f2fs/iextent.c  | 826 +++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/iextent.h  | 170 ++++++++++
 fs/f2fs/inline.c   |   7 +
 fs/f2fs/namei.c    |  48 +++
 fs/f2fs/node.c     |  81 ++++-
 fs/f2fs/node.h     |   4 +
 fs/f2fs/recovery.c |  17 +
 fs/f2fs/super.c    |  13 +
 fs/f2fs/sysfs.c    |  51 +++
 16 files changed, 1500 insertions(+), 14 deletions(-)
 create mode 100644 fs/f2fs/iextent.c
 create mode 100644 fs/f2fs/iextent.h

--
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
