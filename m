Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EE0C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bO9wHbaysloXT5sR264MB5tolvlslE3NYmF4AUt4TXM=; b=cWyj0UQ+IqIoz1hedFRu3fS9An
	GpDScDYgzBpFrgIWmN0UbRHGDzYzPLaEBaMuGyxUOOlsNL3B4xvFSAp93w+fT3VqoaqZZ5FUeRsPC
	lQPWk8V/w/wNi8nt2TDv9uQd2Z2caCQB7nir+bpDMUl6MFr/av7X0nJ8LIIEoBwYiRUE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrQIx-0005b6-6B;
	Wed, 05 Aug 2026 01:20:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wrQIw-0005au-4z
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LPLi41NYUxsS1gkBzemRFdLPQS6JHH/k3xndcb8xmGU=; b=bK4wphPqUFTlKVDTrlBqh+Isb6
 gkbPW9VQ8oiPMt/R6AhTPp3ZwRNrjw+qLuvH85WnPxbVhyqZaqvW6nzBrCPrklv+MUXIW83fhDvnV
 sfp7GgK+qpb7giJk8N0311Kahhd5KOCQYGMlS7ib1X/EXL16rslDjuOns/Q21/8B2K9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LPLi41NYUxsS1gkBzemRFdLPQS6JHH/k3xndcb8xmGU=; b=XpguwcDgqlqpDXPTMkPhlmzZF2
 ixJ62CbvdAjyqCh1R66z0FspSjqbxZ4i/kEPbyHszQyt3B6nJK6dJgEiawKWBnBvlN6HIzm/pwG0z
 56z3AfVhMgG1rHLgj05LwIcE8MnuBiQ8N1NPv3HYp+eLKDxAmTa3nlpzqMMA8H25U2SY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrQIy-0005lo-WE for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:20:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 109714096F;
 Wed,  5 Aug 2026 01:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEE61F000E9;
 Wed,  5 Aug 2026 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785892815;
 bh=LPLi41NYUxsS1gkBzemRFdLPQS6JHH/k3xndcb8xmGU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jGmsDcKo/s39+SOjtTpJ0P5uOQWF6nLg4j14TjN/y2ilBcYEm3j53fOJJR7hwIAJR
 xbzkEaHO8A3daET9aoC4vteXiqmVcAz8b10vZcGeQLMMojVcVP04meMUIi4MRykNoU
 L3GK3blTNoUmqvo6wGuOG4dY7lGOlsZj0tj7R8EeWB6jt+P2RBt6V60H1qHHDoXrhU
 FXTDmW6a18rOHagmeDAmikZvF9hIafoSYF12lHuRCSjyorO2cDrTx6q+WS5Bko0Sfb
 DedNNhlfj8JXtB10MsJ9A0whQbVCgDhv/XlT8kAG3x9MYEf8ZCkM53lQUo4KQiVxFT
 f2l40GZQ9V4Ig==
Message-ID: <8b643643-17d5-4c80-9548-c8dc461c9d2d@kernel.org>
Date: Wed, 5 Aug 2026 09:20:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260730154618.2166947-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260730154618.2166947-1-daeho43@gmail.com>
X-Headers-End: 1wrQIy-0005lo-WE
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: support dynamic reserve/release for
 device aliasing
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/30/26 23:46, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> This patch adds a dynamic management feature to the existing device
> aliasing functionality. It allows users to dynamically reserve or
> release specific devices from the filesystem's free pool at runtime
> through new ioctls.
> 
> To support this, three new ioctls are introduced:
> - F2FS_IOC_RESERVE_DEV_ALIAS: This reclaims the space occupied by a
>   device aliasing file. It first performs a capacity check, resets GC
>   victim information for the target range, marks the segments as in-use
>   to prevent new allocations, and then triggers GC to migrate existing
>   valid data out of the range. Finally, it reserves these blocks in the
>   SIT to effectively exclude the device from the usable capacity.
> 
> - F2FS_IOC_RELEASE_DEV_ALIAS: This releases the reserved space of a
>   previously reserved device aliasing file. It truncates the blocks
>   associated with the file, which makes them available for general
>   filesystem allocation again.
> 
> - F2FS_IOC_GET_DEV_ALIAS_STATUS: This retrieves the current aliasing
>   status of a device aliasing file, returning whether the file is
>   released (inactive alias) or reserved (active alias, with blocks
>   fully allocated on the device).
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
