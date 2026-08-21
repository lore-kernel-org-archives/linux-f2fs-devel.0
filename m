Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF3FC5DF87
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 01:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RY04hVHluh87e5kQrpqAyizRLOyv/ghkV4fLkmNu5Vw=; b=DogASs8Ewu1D8uNyJNeZYTROnt
	KItRpOMS8abBl1mbtHYJQdVuD5/QCqgrxlYBJIixif4Dg0OWlz3vYbufI5TNUr4EzRKrGnK/yqVmM
	fmduyF6dF3ACRgPVmLjCgyEO4gPuljWd0dKyNv7zFWsW1pcG4wfpSPnGLDkyOCqipOzc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxE6X-0003aj-Pz;
	Fri, 21 Aug 2026 01:31:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wxE6W-0003ab-J8
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 01:31:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IY6G8JaoRbiuxH+olJlgFfR3MVeyH9MEMa+6auNiERI=; b=hrRaWPvJAvxRROgGjE3EzBFtzl
 UuxT/G92l5EGrSxeA2A77QcyPSwEg7xI2+ZBzCWE+S+7IWxeFapEoDukVPAmpf8fRGlt4ZggUj2ON
 Mjg2ZBphaY/wkWl4L+CDrHYg3zjTpHVBtWkjKxusU8pQqr1eqWVIaiDqt5snbth/jzuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IY6G8JaoRbiuxH+olJlgFfR3MVeyH9MEMa+6auNiERI=; b=G7mtBPL9h0qSGdw1/AtAU9o2Sv
 Uqjm7hdFOU4Wtvvj/JovLJ5PxDxMDFFe/r8Ob2TNfqRTvSNMApevFE/ZkPdwEiqfAXS5VnLGCzW6o
 mwthxc6Od+50w05pKQPVwhh3CkCH+OOBrzKQlLG3cMiB8FO8uxmZLnDt1Ubua+L3GB3c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxE6W-0002N8-QA for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 01:31:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D81560A58;
 Fri, 21 Aug 2026 01:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6323C1F000E9;
 Fri, 21 Aug 2026 01:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787275886;
 bh=IY6G8JaoRbiuxH+olJlgFfR3MVeyH9MEMa+6auNiERI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=dPUP2Om4SNO/ESPxV3AsD64bh97ig9fhECuI8KuvYCTusBshn7tDVarcSyW9jKLew
 Jqv3WvbVS5S3lDt/ITElUoGGTLuclTswut7uIsCdwHBhA/b3CuTgeBYA9uci2ldo4D
 /xN4d/9i024LQvXHETRTKOzdCii0L2wESZdD0kEJF4Y9PxF/vgD98SU2bOOUt5oCUa
 ELYEGBCo9LEsr2chgv3/0XjGoI/As1lyiXJ+P702/V+v5u/k/Onow71kLQZgW6EZHY
 Y+P9mp/XriNEbswvCwjsJWEQPauciZwXkAFNQFDtukqAbz7iIMlceFpHCWkEUVwxvV
 Z/a1+5rVOCRtA==
Message-ID: <574ad500-a254-4430-925b-c1f8275d0a42@kernel.org>
Date: Fri, 21 Aug 2026 09:31:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260821011812.2938998-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260821011812.2938998-1-daeho43@gmail.com>
X-Headers-End: 1wxE6W-0002N8-QA
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error handling on device alias
 check in rename and unlink
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/21/26 09:18, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In f2fs_rename() and f2fs_unlink(), directly returning -EPERM when
> encountering a device aliasing file bypasses the cleanup path.
> 
> Fix this by setting err to -EPERM and jumping to the proper cleanup
> labels (out_dir and out) instead of returning immediately.
> 
> Fixes: a737e409a3d6 ("f2fs: support dynamic reserve/release for device aliasing")
> Cc: stable@kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
