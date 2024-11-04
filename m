Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D120D111A0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Nov 2024 03:43:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t7nze-0002qP-Ei;
	Mon, 04 Nov 2024 03:43:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t7nzc-0002qG-Hn
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Nov 2024 03:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NdBW5sDXSEBxIjTzdtMzeYR6muRJJBg5wbVZRMvCsBM=; b=iXRjox/kHtWHC5f6bPK0bxN3N8
 HVT7lAB+X9rD0+BJVPeqJJhUgUBK5txaTROFTCgCZGLSykzodwPqahjDEYqZmcwAMFnaqSGR4AbvE
 dn2SVr3BqJGPv56l+vkGNGRv7bG7sH5VpEt4/FRzDEXGRznv/YBxZUQ59dkQJVSG1Dx0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NdBW5sDXSEBxIjTzdtMzeYR6muRJJBg5wbVZRMvCsBM=; b=W9ZhoPRRnir53m85fAerWbUBft
 93ipeV5/0V540XZJlQ//12i9+vEpokAtBOVWphEdYgKm0AHbhqwcrsb5zVenFylhganXgGP3xwlwN
 kPPjooCE+cZUbBpSVSR/EoznalJGvi2HUOF8UI6x4NVtEf8b7h9cQwZmaDgOWyBjUlRs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t7nzb-00063w-3A for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Nov 2024 03:43:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DF1185C402C;
 Mon,  4 Nov 2024 03:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80936C4CED1;
 Mon,  4 Nov 2024 03:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730691777;
 bh=fA9BibhTIvtfZ7hQv6x0ESZlNxG0NIUbGVMlHwehJ7M=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=tYGrmBBgfd/mWUV0TO1MAGHeYj8rXv1OGG+3cCf5Ps8KVJeFIW9o4e6DbMRwGfKfj
 XfPyJqUX3RWi1LeyUYpWRQnZQzAPH1f5fVQhtLaloTIzv5Bowxn0iCRxqqkT4WzoNK
 1YAFehSe++0JPviHAR/WI4lXS0TXq2fQ+36TNA5fMtJ/C11JehOJ4mcRM07bownGRy
 R2ODeyPiK9Qh5UYbkFixG4NFJCsd1r/IbOqTP4Cpa9t0XOECx7aDYZPApFoLqri6ql
 3tGWIThRjHE9wW2zkk8qdblE7x/rKoEIovhWTkjRqJfxzuUYKhiFtvKIwhI/u/MFcE
 s6h0XXeP8zsxQ==
Message-ID: <26f4a60a-31ef-4af2-af57-0a0ec679cfab@kernel.org>
Date: Mon, 4 Nov 2024 11:42:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20241029061535.2676673-1-xiuhong.wang@unisoc.com>
Content-Language: en-US
In-Reply-To: <20241029061535.2676673-1-xiuhong.wang@unisoc.com>
X-Headers-End: 1t7nzb-00063w-3A
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix fiemap failure issue when page
 size is 16KB
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
Cc: ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com, hao_hao.wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/29 14:15, Xiuhong Wang wrote:
> After enable 16K page size, an infinite loop may occur in
> fiemap (fm_length=UINT64_MAX) on a file, such as the 16KB
> scratch.img during the remount operation in Android.
> 
> The condition for whether fiemap continues to map is to check
> whether the number of bytes corresponding to the next map.m_lblk
> exceeds blks_to_bytes(inode,max_inode_blocks(inode)) if there are HOLE.
> The latter does not take into account the maximum size of a file with 16KB
> page size, so the loop cannot be jumped out.
> 
> The following is the fail trace:
> When f2fs_map_blocks reaches map.m_lblk=3936, it needs to go to the
> first direct node block, so the map is 3936 + 4090 = 8026,
> The next map is the second direct node block, that is,
> 8026 + 4090 = 12116,
> The next map is the first indirect node block, that is,
> 12116 + 4090 * 4090 = 16740216,
> The next map is the second indirect node block, that is,
> 16740216 + 4090 * 4090 = 33468316,
> The next map is the first double indirect node block, that is,
> 33468316 + 4090 * 4090 * 4090 = 68451397316
> Since map.m_lblk represents the address of a block, which is 32
> bits, truncation will occur, that is, 68451397316 becomes
> 4026887876, and the number of bytes corresponding to the block
> number does not exceed blks_to_bytes(inode,max_inode_blocks(inode)),
> so the loop will not be jumped out.
> The next time, it will be considered that it should still be a
> double indirect node block, that is,
> 4026887876 + 4090 * 4090 * 4090 = 72444816876, which will be
> truncated to 3725340140, and the loop will not be jumped out.
> 
> 156.374871: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 0, start blkaddr = 0x8e00, len = 0x200, flags = 2,seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.374916: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 512, start blkaddr = 0x0, len = 0x0, flags = 0 , seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.374920: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 513, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> ......
> 156.385747: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 3935, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385752: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 3936, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385755: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 8026, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385758: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 12116, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385761: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 16740216, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385764: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 33468316, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385767: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 4026887876, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385770: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 3725340140, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385772: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 4026887876, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385775: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 3725340140, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 
> Commit a6a010f5def5 ("f2fs: Restrict max filesize for 16K f2fs")
> has set the maximum allowed file size to (U32_MAX + 1) * F2FS_BLKSIZE,
> so max_file_blocks should be used here to limit it, that is,
> maxbytes defined above. And the max_inode_blocks function is not
> called by other functions except here, so cleanup it.
> 
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
