Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F84BC2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2024 02:33:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sOTL2-0004pS-8W;
	Tue, 02 Jul 2024 02:33:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sOTL1-0004pM-If
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 02:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rqtTndCz8d1hQzDqwHFLCKiqT9lQiwuWfxic0PAIrkE=; b=bP4UBdmPzfPG1IcwS10jga03Bx
 5j6uHJtL477D6JJZSroxgOY7sqjjd7E4NShadgYQ3lG5zbVwvPXDSq7lGwN4ZzzDz9EYAlUayZ0p7
 oBeDeoqA2iWCgSjozcuacVCeiitvG+Vz771jLgabvgc3Pv/JoTNAfm71++zBXAHSoYys=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rqtTndCz8d1hQzDqwHFLCKiqT9lQiwuWfxic0PAIrkE=; b=ftW8HBmDb5hwoxpOKvCmrPAXIo
 H9qpNPubSEMfhga/faucplCRgGA+ben+IZ2fRMhdxHYNJCpfzxRceMmFdWkSBazuyTNftFIhDc28q
 2DdvkPCTkfyfqUOknkJbCZrkQ+aCYiPDEscmYKcMfXl8rlbHLLfsMahfwLUjzh2+CfSk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sOTL2-0007hI-Pe for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 02:33:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5BCB5CE0B31;
 Tue,  2 Jul 2024 02:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6EFC116B1;
 Tue,  2 Jul 2024 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719887620;
 bh=WIaylUeyWMquueBHcy55ySZAVTQji6MPduf3DyKipBs=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=eQSI0fF18EZ2n6Y0MMfk2Rlle/l5PvlWkb09zmIGSqzrgdUtROl63pVEzuHyLyGhK
 3pBdbCJeeMQHuk7YM1jj1Jbh3cpjch+UAxk2k6kGH6yML1E/Fx3VMFPqfm9m9ePLUd
 nogg15ezSBG6Xw+CBmKCBQs0OpZltZ52oz+RbJVNn97EiyuPiPpfJ+NY4tGK1G721N
 ROA/66a4qpNGcVPWSp55hPPRWBrn3F4Qtqhx+t8riSoet/DovO/LZoH7015hC1RrOj
 NZcvufp6c7YdcR0HjDTHnNO1OHHY1ihEKvp3vLHMe+IZhRpOsDvqvjYVf9jAa3G6vY
 H7sszC7rhQ0sA==
Message-ID: <f035b71f-741d-495e-a516-99e0b0ee250a@kernel.org>
Date: Tue, 2 Jul 2024 10:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <e7e1d63e-b6d2-495d-ac1f-28d87d56ca09@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <e7e1d63e-b6d2-495d-ac1f-28d87d56ca09@redhat.com>
X-Headers-End: 1sOTL2-0007hI-Pe
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unreachable lazytime mount
 option parsing
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/6/29 12:38, Eric Sandeen wrote:
> The lazytime/nolazytime options are now handled in the VFS, and are
> never seen in filesystem parsers, so remove handling of these
> options from f2fs.
> 
> Note: when lazytime support was added in 6d94c74ab85f it made
> lazytime the default in default_options() - as a result, lazytime
> cannot be disabled (because Opt_nolazytime is never seen in f2fs
> parsing).
> 
> If lazytime is desired to be configurable, and default off is OK,
> default_options() could be updated to stop setting it by default
> and allow mount option control.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
