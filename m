Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299F7C5DF88
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XAeBo00cKrYbZPnlIj0ioTsdq4456v4Q0RaHfs9/U/k=; b=OtH2+T5srqPTOU6BrEiM7T8sFM
	egz/N7ruL9N+XAi0TVR4ILSRkQBjZGFSMCLkMTu67t5yAc7ESiMHWviQMGN5A7l3iLbPMFKJy+F1Z
	sYfyrrp9IPuB0FlzXZH/edMmsfG2hrSbZyv4Q5O0lotzrZzKClYnl89nB2cpca7cDfjY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxJC0-0001QF-IC;
	Fri, 21 Aug 2026 06:57:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wxJBz-0001Q8-C1
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 06:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5V0VzT/sbPp81WOsoRh/gL7qeXgYnHQ6fVL1S1d7dYs=; b=CTOcPuPfsixgI+XkdCu+g8x6J8
 jswmTbKSG6SFVKx3+avLnRNE/QaH+rIv5fakxoEa8cVzbPBSX2WMwoX2sey9NaIPemZRRJeUoHFdf
 BMVpE2WJEJV2sKm68Cow6n0H9abz38s0Cjl+XNLVtaBSMVEVkpXRGYelZt91z1VDGuVU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5V0VzT/sbPp81WOsoRh/gL7qeXgYnHQ6fVL1S1d7dYs=; b=AdxAexN6+wZtqlvXBlCrY1n/7B
 9kcrraQJRl0Q/qySZP6+kmclZ8gu7Lgszxrym4ZEQnSPCkraHQrqq0kDWTZiRofia91n9kEX1D0De
 OrajmYE0d6U0AGnvjBTcLzUmbzgVyATK2YH1IH6OoiPPMHnRQ87QyM396TKH9J2qakDw=;
Received: from smtp153-171.sina.com.cn ([61.135.153.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxJBy-0006ea-4D for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 06:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1787295450; bh=5V0VzT/sbPp81WOsoRh/gL7qeXgYnHQ6fVL1S1d7dYs=;
 h=Message-ID:Date:Subject:From;
 b=cpadGZ0UR/Hi7gRi6uVQCJ94KSy1IxN9chbQBqR33Tyl+LJzpi46cgiwO2+fzCJP9
 ua52Q2Eu/91cHOiPoTyfSviieRR+DzwoS3Ry99vuFD/3FnsyJq0DGXeokMU8K3nGF4
 YyX+6mOpwRK/XOasQokweqqSsSs55C/MU4EIbsW8=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
 by sina.com (10.54.253.34) with ESMTP
 id 6A87F34B00006EB7; Fri, 21 Aug 2026 14:42:21 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 5848836292232
X-SMAIL-UIID: 6A0000C3C663496F973DA34E6E99D1A6-20260821-144221-1
Message-ID: <d7d15ee9-302f-49f2-b4d3-d997ffe4a233@sina.com>
Date: Fri, 21 Aug 2026 14:42:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>, Chao Yu
 <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
X-Headers-End: 1wxJBy-0006ea-4D
Subject: Re: [f2fs-dev] [RFC PATCH v4 0/3] f2fs: introduce inline extent
 mapping for inode data blocks
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
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/6/26 21:19, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Changes since v3:
> - Do not cache NEW_ADDR in the inline extent area. A NEW_ADDR write is
>   now handled exactly like NULL_ADDR: it only unmaps the block.
> - Simplify the insert path. A single-block overwrite is now expressed as
>   four small steps:
>   1) reserve room for a possible split.
>   2) unmap the old mapping of the block.
>   3) insert the new mapping.
>   4) try to merge the inserted mapping with its left and right.
> - Remove the inline-extent code-coverage statistics.
> 
> v3: https://lore.kernel.org/all/20260724125847.3928772-2-yangyongpeng.storage@gmail.com/
> 
> Changes since v2:
> - Inline extent no longer covers direct block mappings. The inline
>   extent area is now placed after struct f2fs_inode->i_extra_end,
>   inside the i_extra_isize region. This removes the need for format
>   conversion and for f2fs-tools to understand/modify the inline extent
>   on-disk format.
> - Split struct f2fs_inode->i_compr_blocks (was __le64) into __le32
>   i_compr_blocks + __le32 i_inline_ext_capacity, where
>   i_inline_ext_capacity records the per-inode inline extent capacity.
> - Dropped [RFC PATCH v2 1/5] "replace raw dnode pointer arithmetic with
>   f2fs_data_blkaddr()": f2fs_truncate_data_blocks_range no longer needs
>   changes to accommodate the redesigned inline extent.
> - Dropped [RFC PATCH v2 3/5] "support setting inline extent flag via
>   ioctl": format conversion between inline extent and the direct block
>   address array is no longer needed.
> - Re-ran the performance tests (see updated numbers below).
> 
> v2: https://lore.kernel.org/all/20260529085629.2664539-1-yangyongpeng.storage@gmail.com/
> 
> Changes since v1:
> - Introduce tracepoints for f2fs_iext_update_data_blkaddr and
>   f2fs_iext_lookup_blkaddr to aid debugging (new patch 5/5).
> - Bypass inline extent lookup for F2FS_GET_BLOCK_PRECACHE to ensure all
>   mappings are loaded into the read extent cache.
> - Unify the check for fofs exceeding direct_blocks range to use
>   "fofs >= direct_blocks" consistently.
> - Remove support for caching NULL_ADDR in inline extent area. If a fofs
>   within [0, direct_blocks) is not found in inline extent, it implies
>   NULL_ADDR. This simplifies merge and split logic.
> - Fix f2fs_iext_enable_inline_extent to use PTR_ERR instead of -ENOMEM.
> - Change f2fs_iext_convert_to_inline_extent return type to bool.
> - Add benchmark data covering 4K/8K/32K/64K random read.
> - Rename __is_extent_mergeable to __is_iextent_mergeable to avoid
>   naming collision with extent cache code.
> - Remove inode parameter from f2fs_iext_sanity_check (always NULL).
> - Reduce #ifdef CONFIG_F2FS_INLINE_EXTENT nesting in node.c.
> - Code style fixes to comply with kernel coding style.
> 
> v1: https://lore.kernel.org/all/20260507113840.1353304-2-monty_pavel@sina.com/
> 
> This patchset introduces an inline extent mapping mechanism for f2fs.
> Instead of storing individual block addresses for indirect-node blocks,
> this feature packs contiguous block ranges into compact extent entries
> stored directly in the inode, reducing indirect/double-indirect node
> page reads and enabling O(log n) block address lookup via binary search.
> 
> Design overview:
> - The inline extent area is placed immediately after i_extra_end in the
>   on-disk inode, within the i_extra_isize region. Its size (number of
>   extent entries) is determined by the new field i_inline_ext_capacity.
> - On-disk layout:
>     [i_extra_isize .. i_extra_end] [f2fs_iext_header | f2fs_extent[cap]]
>     |<------------------ i_extra_isize (in bytes) ------------------->|
> - Inline extent only caches mappings for indirect blocks
>   (fofs >= ADDRS_PER_INODE). Direct block mappings continue to use
>   i_addr[], so no format conversion is required.
> - Per-inode capacity is decided at file creation time based on the
>   configured file-extension matching rules (see sysfs below).
> - Mutually exclusive with compression.
> 
> Patch 1: Core implementation -- data structures, extent operations
>          (lookup, insert, merge, split, truncate), and integration
>          with the f2fs data/node/inode/recovery paths.
> Patch 2: sysfs interface -- runtime enable/disable toggle and the file
>          extension list (with optional per-extension capacity) for
>          automatic inline extent activation.
> Patch 3: Tracepoints for inline extent lookup and update operations.
> 
> Test setup (Xiaomi smartphone, UFS 4.0 storage):
> 
>   echo 1 > /sys/fs/f2fs/<dev>/inline_extent_enable
>   echo 'mp4:256' > /sys/fs/f2fs/<dev>/inline_extent_extension_list
>   fio --name=test --filename=data.mp4 --rw=write:4k --bs=64M \
>       --size=8G --ioengine=libaio --direct=1
>   sync
>   fio --name=test --filename=data.mp4 --rw=write --bs=64M \
>       --size=8G --ioengine=libaio --direct=1
>   sync
>   echo 3 > /proc/sys/vm/drop_caches
>   fio --name=buffer-read --ioengine=libaio --rw=randread --bs=$BS \
>       --size=8G --io_size=1G --numjobs=1 --filename=data.mp4
> 
> Results (random read bandwidth, MiB/s):
> +---------------------------------------------------+
> | BS     | baseline | inline ext | improvement      |
> |--------+----------+------------+------------------|
> | 4K     | 31.6     | 32.4       | +2.5%            |
> | 8K     | 55.4     | 58.5       | +5.6%            |
> | 32K    | 155.3    | 166.8      | +7.4%            |
> | 64K    | 229.8    | 255.3      | +11.1%           |
> | 128K   | 337.8    | 388        | +14.9%           |
> +---------------------------------------------------+
> 
> The improvement comes from eliminating indirect/double-indirect node
> page reads during block address lookup -- indirect-block mappings are
> stored directly in the inode page and found via binary search.
> 
> Yongpeng Yang (3):
>   f2fs: introduce inline extent mapping for inode data blocks
>   f2fs: add sysfs interface for inline extent management
>   f2fs: introduce tracepoints for inline extent lookup and update
> 
>  fs/f2fs/Kconfig             |  18 ++
>  fs/f2fs/Makefile            |   1 +
>  fs/f2fs/data.c              | 146 +++++++++-
>  fs/f2fs/dir.c               |   1 +
>  fs/f2fs/f2fs.h              |  44 ++-
>  fs/f2fs/file.c              |   1 +
>  fs/f2fs/iextent.c           | 535 ++++++++++++++++++++++++++++++++++++
>  fs/f2fs/iextent.h           | 136 +++++++++
>  fs/f2fs/inline.c            |   1 +
>  fs/f2fs/inode.c             |  41 ++-
>  fs/f2fs/namei.c             |  67 +++++
>  fs/f2fs/node.c              |  38 ++-
>  fs/f2fs/node.h              |   4 +
>  fs/f2fs/recovery.c          |  15 +
>  fs/f2fs/super.c             |  29 ++
>  fs/f2fs/sysfs.c             |  91 ++++++
>  include/linux/f2fs_fs.h     |   3 +-
>  include/trace/events/f2fs.h |  79 ++++++
>  18 files changed, 1229 insertions(+), 21 deletions(-)
>  create mode 100644 fs/f2fs/iextent.c
>  create mode 100644 fs/f2fs/iextent.h
> 

ping

Thanks,
Yongpeng



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
