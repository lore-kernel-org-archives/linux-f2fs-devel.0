Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81566C79FB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 06:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GVPL++OPOYWUMXnP2oUf1ShL3gS1qvy6Nd3Gw/iuvUQ=; b=UonpYwAFL5U/i5CSUjQIC6vFFc
	qaBjk/AR4aCqa+aKG5toctrUA1lzcV8FxPxTn7DM7d2rGDAAN4kTd+Hl8Vqi/GLWG5HbsR3jDc1l4
	53AyeRGZMuoPh9dyTKarvQX6xI32khm/YLJUDtEG9ZxF3Nd4FVnEKrw9aEvHy8Nz1iko=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4YPF-0003rr-J3;
	Thu, 10 Sep 2026 06:37:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4YPE-0003rk-D5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 06:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ULSOjoxc9C4LAIJYFZvWWrEYRpEvNKnRn1S91Ea0S+g=; b=UAmdCgK1VDe0gWTYHacOdkF+7N
 c5CpWCKF1DpWgLRXFlJLHN+Lg7DUa/DBtdOwg/iLsQNip/eAZKDcaQl1tdiWsEjAa9SEgFcHGj7Ub
 LSqjQmGUpBvXc8HkSRrtRCilowhI2UfaRfqzW06YSQfasJu0hm4hFeeSPxGSlNm53jO0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ULSOjoxc9C4LAIJYFZvWWrEYRpEvNKnRn1S91Ea0S+g=; b=Ng60aojy+39ObU9Ua3mwh8OHxp
 1xvmfZCsk5zlpJD987RgmILHUazB4AzF/mNRLhNmFK2P6ZTOwlpszOVqoTwnL/C/JY4rv1K/fEC8U
 7fcYLNxVrCg+Cp9RaHdrqvcvhzwcicC56p6ZEqgrjhqyOkmTm9GAPMxF6CUcVOQPfvNg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4YPA-0004f0-C9 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 06:37:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0BD140644;
 Thu, 10 Sep 2026 06:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB38D1F000FF;
 Thu, 10 Sep 2026 06:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789022218;
 bh=ULSOjoxc9C4LAIJYFZvWWrEYRpEvNKnRn1S91Ea0S+g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=gAa1EU1Y78m/qKj0lQHmMj9PZMe6jZ75qmcHpuYIeCiU8DunX/EFLyYH22xdCsL6k
 NQ3ScUXTNIsl7KoEPdDCHjla8Xn1CTuvL1/i/zGbQ8NkHQHI0y96lFlmzovLbkxCMk
 6YMVioco8bjlhFIHsKH+MoriJWB4lv71szyYzDXa792kN1e0QP2RVKZr/8HrJzwG6y
 Rcxn8/4pWSOwxpAz1POAsbjserEbHBZO/hX7T+j8aj8gj76+Gcy/Jf2Ad4ZGV4VSoX
 16TiaNQkiMXdWwB7t8Juck359uexW2PTdirJn/YGa+r/gv47r4HdBIC+9JDU1v/SxI
 MMkvb93vpIJ/g==
Message-ID: <ee7e034f-82ac-4de6-a368-4ff5e42eac65@kernel.org>
Date: Thu, 10 Sep 2026 14:36:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <20260910030243.3005578-1-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <20260910030243.3005578-1-zhiguo.niu@unisoc.com>
X-Headers-End: 1x4YPA-0004f0-C9
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to record both APPEND and UPDATE
 ino entries
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/10/26 11:02, Zhiguo Niu wrote:
> In f2fs_post_evict_inode(), record_bits is assigned with BIT(APPEND_INO)
> and BIT(UPDATE_INO) respectively, so the second assignment overwrites
> the first one: when both FI_APPEND_WRITE and FI_UPDATE_WRITE are set,
> only the UPDATE_INO entry is recorded.
> 
> The two flags are not mutually exclusive.Once the APPEND_INO entry is
> lost after the inode eviction, the shortcut in f2fs_do_sync_file() can
> take the flush_out path in the next fsync(), skipping f2fs_fsync_node_pages().
> As a result, the dnodes holding the newly allocated blocks are not
> fsync-marked, and after a sudden power loss, the data appended before the
> eviction is silently lost.
> 
> This restores the previous behavior where the two ino entries were
> added independently.
> 
> Fixes: 314c9e476ffc ("f2fs: call __add_ino_entry out of the eviction path")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
