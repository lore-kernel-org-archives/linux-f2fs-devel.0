Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0ECEE01FA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:03:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1soChg-0003QU-Ho;
	Wed, 11 Sep 2024 02:03:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1soChf-0003QO-6H
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 02:03:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p2IHqIMnUZ3twPlVjfMYLVczCOBIKkfikjAKK80cXvM=; b=W+sfGw5oiP84ELketaIJrB8FXE
 35dnAL9QD96SuNrrTzUL7M6pD1adPbarzxLGZXkJxIjqqJRha2wsE8DEaEUYHeg5yGMkyBQwD/fWR
 tJzUN23C/xQVSTTl2nQmbfdkFpnFAENYh8ewGsQp5tVy3NBjIG5ZVOqsLVTF4xyv9EGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p2IHqIMnUZ3twPlVjfMYLVczCOBIKkfikjAKK80cXvM=; b=Wlz7rAwx4bDQXxbjN4aAhP5/4e
 sbL/7M7I8QJoxKX70Z+MoSmNFmeNfyV1CKRNDP5xeZtKCFnjpll3EoXJr7hX0pbi5qM4sxb7+8Hkh
 KACkgfze/ZBMGSUFkGhmnqcgWJVrv2Mh4kiB/izrjSzjZPjBNa80LAHJiyxSI3Vwat90=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1soChe-0004Jn-IX for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 02:03:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1D14BA416FE;
 Wed, 11 Sep 2024 02:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6045C4CEC3;
 Wed, 11 Sep 2024 02:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726020199;
 bh=jEG7713sqb5Gi1BH++FRmvAljhsg6dp6U1sIkfuhhtA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=B07cAy3mJ/BVCJURSXgmGhvypgkzrz+rdtup6KUPVnPraI25wAshQ8sevtEWEUdXb
 3PBnkOwmYmWUcE3YJ68zAqdqVX8RReIoEkC3wh0StYYW/mJMsmMzrtKNzw9tn9bRsZ
 muWlF12OxhLOe35KyJESxG6KJDM/JKrInpxjyykjJStwnOVxg3I9jgjSx3jAkSvoYc
 sfytQbVvmfeCNBrkH/hEurfVCPkd8Ct58ba/VvdcWXlyrpTknuHyYOlantWV8VJbXH
 Qgd72zLQNQAGcU0U3erH4fH9LHbM9wdpEFfPR4SCsdO26ovZxqOy3+e6YX9vlVTfAz
 V45D0fsUUbBSA==
Message-ID: <b98143c0-fec4-4d58-a230-05317dab577e@kernel.org>
Date: Wed, 11 Sep 2024 10:03:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20240909221946.2004046-1-daeho43@gmail.com>
X-Headers-End: 1soChe-0004Jn-IX
Subject: Re: [f2fs-dev] [PATCH v2 1/7] f2fs: make BG GC more aggressive for
 zoned devices
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since we don't have any GC on device side for zoned devices, need more
> aggressive BG GC. So, tune the parameters for that.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Daeho,

What about collecting all last reviewed-by tags for each patch of this
patchset? if there is no change when version updates.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
