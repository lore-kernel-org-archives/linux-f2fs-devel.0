Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CB7CD98C7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tliXCXQ+EK5+4h2HJvOnKS5S2j0cXm40pZ3i8VRrRWI=; b=Td69vidvwQ/ABSmGYOenwzKL08
	Cm6eq4EjMN1PGTzzHCHzq/tPsESiz8xN2XJGnWYh9UhTZpl7ILFHmofVLkJw39wy6IhxVa9f0Tyju
	SwW6a+0G0L9MarrZKoA0AoDh2dguFtE+6BrIEpcqPeXTNCgUYDPqzyJYBF0lb6PG2l2s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ4nS-0002fD-VI;
	Mon, 15 Jun 2026 10:44:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ4nR-0002f6-H5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 10:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3epWikBLnKvL0xfba2AN4mFxD0a92PCzLmZobS6U4tc=; b=jf7coO1Mwk+p4lBUH9LMLcLgTw
 VDwk7kw3RjzaP2cJ1J+q4TLTJiIt64o/XmVIQlpnMi3vKM8hPh+w4TyyipsMBo5Fu6ALYCA1mAPp0
 At0qrX6dH1lO/zjpEAbtzcdRuc/aFJpTTHcsrI/qaiV5W7cxTQr7ARmP1R9Hu9YtOtHE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3epWikBLnKvL0xfba2AN4mFxD0a92PCzLmZobS6U4tc=; b=O/fAj0gWCqZ+FzJDKNeMDl+z7W
 4XQ/XbDzbud92qoaudcCr/ru4EvpUtNxaKUtEnS5QgAR/25ouRuN86oj7gdO6qg8UX4OdOr5kHZpz
 wOTUyR6GyLfsKc1CJtRrzeR04CxlRLzsRBwXIgfqgIuJsJDn24veJ+sjQMDfTKdEvk5Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ4nR-0005XT-5f for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 10:44:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 110DA4360C;
 Mon, 15 Jun 2026 10:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0FC1F000E9;
 Mon, 15 Jun 2026 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781520230;
 bh=3epWikBLnKvL0xfba2AN4mFxD0a92PCzLmZobS6U4tc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=YdQicPmKLzODTRb4v4UUOXFNR3uXYe9mGfoHjJeD/dDZsFCdDOp+DfqBRvIi4GScU
 GJaYb+5DpJQ1/RlUQejZqOFSY62J3emmyNZqJLx/cPXIveQ9FSfp5Re6W0hQJUL0N4
 i7Alvz6D5kEB+P74uHIn8x4qvCN96CX44JHg29UI2jyueTGdUOypiYgOiGiwnDHaJb
 3dX4WwpRQ/rNdbCnkWc+hLhI+RldfR89ofiTzoyGzyvLbVTwkrop/eM9412bn7b0Ng
 ics4mnmrofniW5K4tJZbY0BKJZ1m/CkFasGtNRcIctNKVrC+F9oEv6RZur0mePDxYv
 BHptGAToDDbAQ==
Message-ID: <a7b36a47-0556-4805-8934-c57def57c3d2@kernel.org>
Date: Mon, 15 Jun 2026 18:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260529022924.3655519-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260529022924.3655519-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wZ4nR-0005XT-5f
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip inode folio lookup for cached
 overwrite
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/29/26 10:29, Wenjie Qi wrote:
> prepare_write_begin() first gets the inode folio and builds a dnode,
> then checks the read extent cache. For an ordinary overwrite of a
> non-inline and non-compressed file, an extent-cache hit already gives the
> data block address and the following path does not need to allocate or
> update any node state.
> 
> Check the read extent cache before fetching the inode folio for that
> narrow case. Keep the existing paths for inline data, compressed files,
> and writes that may extend past EOF, where the helper may need inline
> conversion, compression preparation, or block reservation.
> 
> This avoids a node-folio lookup in the buffered overwrite fast path when
> the mapping is already cached.
> 
> In a QEMU/KASAN x86_64 VM, using a small buffered overwrite workload on
> an existing 1MiB file, median time improved as follows:
> 
>   64-byte overwrites:  1724.93 ns/write -> 1560.24 ns/write
>   256-byte overwrites: 1713.38 ns/write -> 1577.85 ns/write
> 
> Function profiling of 20k 64-byte overwrites showed
> f2fs_get_inode_folio() calls drop from 20004 to 4.
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
