Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CED1606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gU3dBu6h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V3oqQANF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QwoZVomw;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqXiwurU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yC5kxjPL4+0NcEGDugQMMrELOxMAOzIry6FhI2cdtyo=; b=gU3dBu6h4AfG/A
	Q0Kh1KaBFDVgCTe+mXSbSGsyg+oD53aLzCmShliIeAgIzytlIb+dsnmuZrR5h+RuRqfJazpYE8bSF
	GRcbSGJ7sMLJZAaqnGeX5dU5DDuPTnSgDWG2bxqcbgWixH2ndPPpwOalrh50pdbUgCL5ElLSrHSwf
	q0s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTHWH-000000001sN-24E0;
	Tue, 17 Nov 2026 11:38:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTHWF-000000001s7-24H9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=27ze6YgxGXZ8hOfykcrg0qapM0urNweeGBFd8wX9DPo=; b=V3oqQANFes7u5RzTRQNko+xgiG
 KJNDPm7fhFlXsP2jJtzPk13pOO2c8umRw7tUsy9zfPF0ZZtYnAQZRtIc9CHXhMKPizBX3WLnRjN0H
 kCd8+RFSOwBBGvWEpy/n5Df7Nz8Rug6aTryBD0JSn/cOa6zIcTPYHAzef2I1IrJ5syss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=27ze6YgxGXZ8hOfykcrg0qapM0urNweeGBFd8wX9DPo=; b=QwoZVomwsqE0jJd6GczpbeJPpu
 WAPpl2aplPHCYHwQzecqc5xvcZ+3qnhHHG4ipMW6a03kZ1KTuBk1neN0UuHT43BVCG7SPVGILHPcM
 5Eiw/MguNq5G4Tyy87nkWZc1HOYslmCMYHH61lKmZh/v/oPD+JYWSaVCxI7U7InQ692g=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTHWD-000000003fs-3apN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:38:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 401C660D8E;
 Tue, 17 Nov 2026 11:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077EC1F000C4;
 Tue, 17 Nov 2026 11:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794915508;
 bh=27ze6YgxGXZ8hOfykcrg0qapM0urNweeGBFd8wX9DPo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bqXiwurUZP7C2FcYUpebuO/ra1c7R8n6k0+QhvUCcN8WqC0FnoiYI7VLTjOaoxKIs
 AjwokGAAH4XpSSXZdRIstgTHkHDmZkCL8SAzCz++68PcqQ6p+dYMCj613Hj50ii5co
 g6TepxnKV1FUYwTOIjTz8kC0vtw4O4e4/Xwobn49mUZwXfIW589PcbONLvRlEKd1KY
 wzFNFUlP2N6dR7tzE6UTzb+fhOxMLTCMDoKaQ1U4ucZAVivxF+0sXTqjDMTwPEWFF9
 znM+upqOVFeDQ6Rmy3EWWoGUGL05VicXarDdNhQb5+AH3ZZmymd5QrnsGgB23WrhhS
 +w+gcshczg62w==
Message-ID: <f480bac1-51d8-4f3e-b6fc-dea754d78eb1@kernel.org>
Date: Tue, 17 Nov 2026 19:38:25 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-15-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-15-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTHWD-000000003fs-3apN
Subject: Re: [f2fs-dev] [PATCH v2 14/20] f2fs: support subpage blocks in
 fs-verity enablement
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Check verity per block. While enabling verity, dirty and write back
> only the data blocks below i_size in the folios before the verity
> metadata. Do not zero the blocks past i_size on read while enabling
> verity, since GC can read a folio of the verity metadata that is already
> written. Remove the -EOPNOTSUPP checks. The changes for enabling
> verity also apply to large folios when the block size equals PAGE_SIZE.
> 
> Stop the data reads of a verity file at i_size in
> f2fs_read_data_large_folio(), so that the blocks past EOF in the folio
> that spans EOF are zeroed instead of read. A pinned file can have such
> blocks allocated without being zeroed, and fs-verity rejects non-zero
> data past EOF. The reads of the verity metadata still go past i_size.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
