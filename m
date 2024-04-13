Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E27C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 13 Apr 2024 09:53:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rva4G-00009M-7F;
	Sat, 13 Apr 2024 09:53:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rva4E-00008y-PV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Apr 2024 09:53:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OT0WF9ptpCCk6PinIrKBfiglmciPrzBVfIXXLOzh3xo=; b=WpyAGeBd0bvgVaS5eBkhmhUjWQ
 HmVpkVS3sZAwqB/Jc+nRMHeX7rtDjYUM+D6OiF4OApYwv3QsUas3WRHcKeUpfxhMc+p66yCc6Nx8M
 ZGMb4UqmgL0YLKUd6jY4OD3aLMJpPvST+5WtaykjPsOWqXQ6j2oYahXlUbnfXm8D53Uc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OT0WF9ptpCCk6PinIrKBfiglmciPrzBVfIXXLOzh3xo=; b=LxOLrc2JKHCVKuA7OBwnVvD2kE
 K4hjdxruwlpCCh4jmM/UPs8CV4+5PLF30QvFVPTMZqVFQcFm9onexpjOsecroOWGA2wPm+NzQrm8X
 K6q1S/c5oE4Yuc4HXnvZK0RNHoMPVQVwquiPLrlORhr0tvnCWlTwHCg594CPck5oS0xc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rva4E-0005bs-22 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Apr 2024 09:53:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7E599CE3C43;
 Sat, 13 Apr 2024 09:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6179DC4AF13;
 Sat, 13 Apr 2024 09:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713001969;
 bh=Mp/k7oxUFkv2UFyK/q+jMiwjME21YAKpLNPyj5vic3M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H/baFDjrcnsD3y0M27D9f32q5FfOaxBaVIKAp+xYLOxz/I28hP1axDTkLF3+b4BUR
 pHDKate8WfXYlB8PpFy/Mhx4j4pvg3rcv2DOpluoWAtCaum7Nk1dnms9ASGebOg0tZ
 JP6DnHDWXSyz/bNTO+wsZ9qKBeeJWCXCyBaBKnpQRubOg4QOqPyG+wwrDH31JY9Bop
 qyI29Hzi1K27JKKsV/WhtE4IyvFgYB9Sd2xW4B3k+pK08Fk0eA6JtKMX7r2XZSSk27
 TkuLbNbxLav25m9JcS8iPuWzyozeoJIeZuOl1oraabPg5rc/rK7utHM/GyFzadD6G2
 VVplByDUV7TRQ==
Message-ID: <ede7ad82-29af-4bc1-946a-d47b59de8e46@kernel.org>
Date: Sat, 13 Apr 2024 17:52:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240411175410.2406710-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240411175410.2406710-1-daeho43@gmail.com>
X-Headers-End: 1rva4E-0005bs-22
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: prevent writing without
 fallocate() for pinned files
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/4/12 1:54, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a case writing without fallocate(), we can't guarantee it's allocated
> in the conventional area for zoned stroage. To make it consistent across
> storage devices, we disallow it regardless of storage device types.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
