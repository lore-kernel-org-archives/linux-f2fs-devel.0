Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32F7C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fDKQOaPodKhEynXG4s9B3Ipbsc8XfB9soem3prlFLts=; b=i1aXi7DxUOBK6niFvwQurVKnGZ
	etBGwhGe0PrXYdaK1QOP+Qr4qidUcHkZUf53zrB9oYhUAycwJfPhgVsL+UiBvk7070vNOIPQr+BbA
	STo29lKJx/khZ/ATc8p10TodGKWjU/IVJRpCOG/VGYjFWp/o9ZY1aTKibUjj3NVWC8rI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz1FG-00085Q-L7;
	Wed, 26 Aug 2026 00:11:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wz1FE-00085I-Ft
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 00:11:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2PS5KY70aNJyYqPvv5fmig/NRtw70HPD+C2S9bEerrI=; b=UwzCxZ7IAnav2k0zWL/nJ1AS2Q
 apNffIAoVhb2t4ufHoko7PMUmz8vzrNSNALTTnnvFpn/6wQBk0oPJ3MqOrUHIb6NF84rwMmXsEhLH
 Pm/srf4o98EORlfHQBkyLyMQZu9tEL6l+jqD+oYUrQ/en/TpoaXtPxpbNoGt+jIlDaqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2PS5KY70aNJyYqPvv5fmig/NRtw70HPD+C2S9bEerrI=; b=mfo2X+RDc5ZHZQ/7w9+Gb13DdB
 1sZs/H98WoYxNUjVHlrxzBfVCsqwbJt24gQZFwtPk4GZitfrGdlnr2QQK+PQ35YZgYKubuHmTfCx/
 Ea+m0VSFVQXg0jYlPQJL+KTUkgOVyk7jUOce1JAfrGR3rTyzqzI7d0j+pwSc4/SOUeXM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz1FE-0007j6-GF for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 00:11:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F234541B67;
 Wed, 26 Aug 2026 00:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F2B1F000E9;
 Wed, 26 Aug 2026 00:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787703110;
 bh=2PS5KY70aNJyYqPvv5fmig/NRtw70HPD+C2S9bEerrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=N5fpd6Rf/upogpV5TCcxunEhA+S5ObAt1XTZvsaXFujQMe796bLGj03+5vZ53o+ol
 kfCOV5jrhDU8WYEjQy2p4CVCKrik93hh8+n/KRuTIJJszYawuVdy4pYVbsK/vii4I6
 yqcmnt+zrAfY7V9OL+2CXbEqUSngxfLh9EkkQcTDZtp1zz9FxaaPr0sCpSUK7GY3n4
 eafGgYM92ImotfYIfpl2X15IgGPpkV4Px/suGCwKj1xAyUupSlykqfMHOZkr8PjNx4
 Tqh2nm3aGAARvV0/XTFARe15xFP7SkREkRGggloDWg8r8+cKehAdTdpje/K6UvOD85
 HKsoo2zikrhAw==
Date: Wed, 26 Aug 2026 00:11:49 +0000
To: Wenjie Qi <qwjhust@gmail.com>
Message-ID: <ao4vRT_SbvNfSUTD@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com> <aoylp9llX9zlKm-g@google.com>
 <20260825023925.230986-1-qiwenjie@xiaomi.com>
 <ao20zq7Qy8hUnM_g@google.com>
 <20260825173111.1151141-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260825173111.1151141-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wz1FE-0007j6-GF
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't leave the hashed inode while
 it's unlinked
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/26, Wenjie Qi wrote:
> Hi Jaegeuk,
> 
> Yes, that's true for the normal path.
> 
> What I meant is the rollback case: err is non-zero, but __do_unlink()
> may still return ret == 0. If the preceding f2fs_add_link() has already
> been checkpointed, a crash before the rollback deletion is checkpointed
> could expose the incomplete symlink again. Should we run f2fs_sync_fs()
> for !ret && IS_DIRSYNC(dir), while preserving err?

I get the point, but I feel that we don't really need to guarantee unlink, since
we're going to return an error anyways?

> 
> Regards,
> Wenjie
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
