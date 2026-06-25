Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18129CDB466
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S37wdiWc+lrb9j/08a98rZnxDXJ7egdK7VWkFipZYoA=; b=gLGJkmNNmkFo9XVSChlCmJkr9m
	GmJ/AhbYygI/OTdQ/zcTrtXyLDhVI1p2qxuSq7R54Fqgwvn1tKYqhewUaI899iktBNdvEh4RwRYxB
	LslbcXwZNWQNUn0BsO8w3+6mCxgbYLL69HB9toxosdLWkdtQ8ekMxnG7N77GSVnYfkEw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcfXh-0006lp-Cw;
	Thu, 25 Jun 2026 08:34:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wcfXX-0006le-FM
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 08:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7/ngUDxMSEKTE956YLZ/TBybnrL0rEqeKDIz9RiFCIw=; b=dICeU1Gfkoylq4owBX6ZsMuGHn
 Qr5o0VYS+GOfM5EdjaC45Iboqo7IjGVAhrVSMGdXQ/BCZpHoOdb2K8upqoiqedle2LXle2AH3vqbO
 MYiZaY5KxqhoPATm2czyjIT0gngfzIHYCdgTLM6fSpiVZKoiBURVm/yrLzBe7zgjvUqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7/ngUDxMSEKTE956YLZ/TBybnrL0rEqeKDIz9RiFCIw=; b=IqtN9RVhoptdNoAJUdab1SzQX+
 MjpHMLpRVGcWZNoTWlNyI+WHJOsP0jamFkdPTnQMGJf8w10jna1W6i68XAA4xqWmagI1OFyVIZS3l
 bBd9Rt9bTrPWqMzR7lfqudMiRTOZQWcvaPewAtYfGQp4Wq5+K6mxbuPhy672MAXV0MWU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcfXU-0001WH-W6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 08:34:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1DC960217;
 Thu, 25 Jun 2026 08:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AFC1F000E9;
 Thu, 25 Jun 2026 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782376459;
 bh=7/ngUDxMSEKTE956YLZ/TBybnrL0rEqeKDIz9RiFCIw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=SzdmR/43d26jD5vK6vUuxiG4/jFJk3xtoxab0toN+ljBMVtqhYTVu+Zk2gjLuSAtt
 5Xgt+bf+z9GbKvIt7liNqHyRvbX8/2/eP0cQa9ftwyPIqWKg5JDaQrbV8zQr6V+Ans
 F8MI3e3TMUgfkzcixYklobDG81tL9WDDHwBTgSpcGGaomNWXNTcY7degAYcBTlLDXr
 FONs/Yu2oZQffjjcLzqrwvjyQNhOE6s0kfswPgzG0ZktchCtjDxS5LAgjmiTZ8MuX/
 wgPlW/AJo8jREz7JoYnDNTdM54vJAfNO4TfK9liTvkRw34HxPH0t9ED84BU0haqGGB
 uqz6mu9ylPgXw==
Message-ID: <7862f9d0-278f-4bf8-ae6b-9413dc52f841@kernel.org>
Date: Thu, 25 Jun 2026 16:34:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260529085629.2664539-1-yangyongpeng.storage@gmail.com>
Content-Language: en-US
In-Reply-To: <20260529085629.2664539-1-yangyongpeng.storage@gmail.com>
X-Headers-End: 1wcfXU-0001WH-W6
Subject: Re: [f2fs-dev] [RFC PATCH v2 0/5] f2fs: introduce inline extent
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sorry for the delay.

On 5/29/26 16:56, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
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
> This patchset introduces an inline extent mapping mechanism for f2fs.
> Instead of storing individual block addresses in the inode's data block
> address area (i_addr[]), this feature packs contiguous block ranges into
> compact extent entries, significantly reducing the number of entries
> needed and enabling faster block address lookups via binary search.
> 
> The inline extent format is identified by magic numbers in the inode
> data area and is transparent to the rest of f2fs -- when the extent
> area is full or cannot represent the mapping efficiently, it
> automatically converts back to the direct block address format.
> 
> Patch 1: Preparatory refactoring -- replace raw pointer arithmetic
>          with f2fs_data_blkaddr() to abstract block address access.
> Patch 2: Core implementation -- data structures, extent operations
>          (lookup, insert, merge, split, truncate), format conversion,
>          and integration with f2fs data/node paths.
> Patch 3: ioctl interface -- allow per-file enable/disable of inline
>          extent format via F2FS_EXTENT_FL flag.
> Patch 4: sysfs interface -- runtime enable/disable toggle and file
>          extension list for automatic inline extent activation.
> Patch 5: Tracepoints for inline extent lookup and update operations.
> 
> Test setup and results:
> =======================
> 
> Platform: Xiaomi smartphone, UFS 4.0 storage
> 
>   # Enable inline extent
>   echo 1 > /sys/fs/f2fs/<dev>/inline_extent_enable
>   echo 'mp4' > /sys/fs/f2fs/<dev>/inline_extent_extension_list
> 
>   # Prepare data: write with 4K offset stride to create fragmented
>   # extents, then overwrite sequentially so inline extent can cache
>   # all mappings in compact form.
>   fio --name=test --filename=data.mp4 --rw=write:4k --bs=64M \
>       --size=8G --ioengine=libaio --direct=1
>   sync
>   fio --name=test --filename=data.mp4 --rw=write --bs=64M \
>       --size=8G --ioengine=libaio --direct=1
>   sync
>   echo 3 > /proc/sys/vm/drop_caches
> 
>   # Benchmark: random buffered read, 1GB total IO
>   fio --name=buffer-read --ioengine=libaio --rw=randread --bs=$BS \
>       --size=8G --io_size=1G --numjobs=1 --filename=data.mp4
> 
> Results (random read bandwidth, MiB/s):
> +---------------------------------------------------+
> | BS     | baseline | inline ext | improvement      |
> |--------+----------+------------+------------------|
> | 4K     | 35       | 36         | +2.5%            |
> | 8K     | 60       | 62         | +3%              |
> | 32K    | 179      | 191        | +6.8%            |
> | 64K    | 284      | 321        | +13%             |
> +---------------------------------------------------+
> 
> The improvement comes from eliminating direct/indirect node page reads
> during block address lookup -- all mappings are stored directly in
> the inode page and found via O(log n) binary search.
> 
> Yongpeng Yang (5):
>   f2fs: replace raw dnode pointer arithmetic with f2fs_data_blkaddr()
>   f2fs: introduce inline extent mapping for inode data blocks
>   f2fs: support setting inline extent flag via ioctl
>   f2fs: add sysfs interface for inline extent management
>   f2fs: introduce tracepoints for inline extent lookup and update
> 
>  fs/f2fs/Kconfig             |  18 +
>  fs/f2fs/Makefile            |   1 +
>  fs/f2fs/data.c              | 157 ++++++-
>  fs/f2fs/debug.c             |   4 +
>  fs/f2fs/dir.c               |   9 +
>  fs/f2fs/f2fs.h              |  23 +-
>  fs/f2fs/file.c              |  93 +++-
>  fs/f2fs/iextent.c           | 873 ++++++++++++++++++++++++++++++++++++
>  fs/f2fs/iextent.h           | 187 ++++++++
>  fs/f2fs/inline.c            |   7 +
>  fs/f2fs/namei.c             |  48 ++
>  fs/f2fs/node.c              |  66 ++-
>  fs/f2fs/node.h              |   4 +
>  fs/f2fs/recovery.c          |  17 +
>  fs/f2fs/super.c             |  13 +
>  fs/f2fs/sysfs.c             |  52 +++
>  include/trace/events/f2fs.h |  79 ++++
>  17 files changed, 1635 insertions(+), 16 deletions(-)

It's quite a large number of change (including f2fs-tools change) to support
this new feature, it causes the performance price ratio a little bit low.

About inode disk layout, as we discuss offline, maybe we can add 4 or 8 ...
extents in i_extra_attr area of f2fs_inode structure, it can reduce the
change line and code complex, however, not sure how will it affect the
benefits.

To Jaegeuk, please share your thoughts on this feature.

Thanks,

>  create mode 100644 fs/f2fs/iextent.c
>  create mode 100644 fs/f2fs/iextent.h
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
