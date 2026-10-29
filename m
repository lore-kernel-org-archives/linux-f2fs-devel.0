Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45D606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CgGnxrEk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GpX3KqDf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FNuTfBab;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yp3RcGkQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zFoBMdzwG45TKn+4OS8TMyuSvZNyEYhJIiOPV20Yrpc=; b=CgGnxrEkHOX+8P
	BesTsGxtIRlcBAHv+a9m4XllBzapjWwy/9KM799lYk0m80hVjNd7/Un3TAe7IQvykWz1uEHDXB9o/
	P2eHk6dCnaM5wNmJQvyO6JbAIg9ZEIsKrn/MdSMU4A2TdCN4yk86MSwwz4UiwZOigEXyWmHP6L5lw
	CSA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF3q-000000006oN-1VOK;
	Thu, 29 Oct 2026 01:36:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF3o-000000006oG-35dX
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+EevfTZvxcUnKDhE5Yo/ljInYUzK3Fk6rhV6FfGCq+4=; b=GpX3KqDftAbZhy4Vvq2CGvMO5G
 H4uFVhtE1jzWfysTla+CLCnIRExhEgTVU7rfjYCZPjF6CLtW+N78n+UyJEPFezgbeU3aGfZgJrvgK
 R+sloq7MXkeYfPZn5kbG5ZJiOqzxt+LJLMTyrofnPPNlMvvw41mgvZT4hr4iw3+waqGA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+EevfTZvxcUnKDhE5Yo/ljInYUzK3Fk6rhV6FfGCq+4=; b=FNuTfBabj6IY87z1atTCk06KoL
 zVprmIYnXtysDkhIMlYf3ISm60nJqjY391HTDvHbDKbvlEyGaiU6VlHVhFuMBfpqxdYDDdIVUIZJG
 tdcc8kAEKIsokYs6nxupe81FfMjOyhxlWL0NKkAHwhtBh8aC5wG/kULYplJWD0hKm7bs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF3o-000000008Rn-1C1L
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:36:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9506C600D1;
 Thu, 29 Oct 2026 01:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1CF1F01825;
 Thu, 29 Oct 2026 01:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237762;
 bh=+EevfTZvxcUnKDhE5Yo/ljInYUzK3Fk6rhV6FfGCq+4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Yp3RcGkQW8rJgoxNRJ8WdByQwR5CLN68t4LRwM1pmIJr0gvy/3RXxqIP1LoXz3ByD
 fFv3E75y25kSpq372yiTNdLQTknbCw4X2yT+eLSI+ED3kJkWJW/Jh13N7XH0Xj+kez
 VO3LbeMpqTlTl8kg+JxrL7XvwanXxgFHp3i+NxJmxVMZnk8OGe8GBBs3NuUgTGfuns
 ebBWWCONWzuI5TMkToP1H6ZWB8xJ6UesDRctNV/g+MYRpjFshCd03eEqQFmyBi3+7v
 MWgqETE5wMOAkNChjdxVWH4lPm2gH0zRDng749EciZADXjaS94LbqsuUYDiL7peP1+
 Wo2OZXiPyCGSQ==
Message-ID: <b0356de9-4a86-4716-bf06-13842377e0ef@kernel.org>
Date: Thu, 29 Oct 2026 09:35:57 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-14-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-14-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF3o-000000008Rn-1C1L
Subject: Re: [f2fs-dev] [PATCH v8 13/15] f2fs: handle block cloning within
 the same large folio
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:44, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> With large folios, the source and destination block in __clone_blkaddrs()
> can belong to the same folio during same-inode operations such as
> collapse range and insert range.
> 
> In that case, locking the source folio and then looking up the
> destination folio can try to lock the same folio again.  It also copies
> from and to offset 0, which is only correct for order-0 folios.
> 
> Detect the same-inode, same-folio case before looking up the destination
> folio.  Then in this case,we reserve the destination block explicitly.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
