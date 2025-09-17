Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4565CAC598
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Sep 2025 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGDZ2pFUpBQ9Pi0xfhqbznN59N5iPidExn4nGwvS3Ao=; b=F+Y6iLJ71rpICT9lkMqgWRnTnX
	5J4aehkIuDBW7Ee3COaJBRm9TpbzvinU8kqd+eC5fGmwMu2KV4VAhkellOHPtIEuxLhfSSw+/nDSG
	rpL28EIWn7EB9Av02A60IbXrqNq+KrP7rKitsjxni3ZGN11f4azAYahB4pssO/j+18D0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uylyB-0002Xo-Pm;
	Wed, 17 Sep 2025 06:48:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uylyA-0002XX-5n
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Sep 2025 06:48:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M113r3At4kRBgcFq9bXymZ5ebSJ7+naGb2IGtE+OBfM=; b=fD4ZYA3ahNcxvmSoIAvu8zsbcY
 T8OCy+xMbM0hYRgd9KR58dEG7qtIkqnkZ1fIKInDZUWGGmm+qWGTcHgzNRVRGQbKLOzXJaTUV0bAt
 MAziN6KpL+EUecJUoZlOT3CSk3RU3TbDr2JsSETDbaMH5asf2VQ0Jdu95p36+fsyW4tA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M113r3At4kRBgcFq9bXymZ5ebSJ7+naGb2IGtE+OBfM=; b=KCcyOu/j4SYqDBlHK7lIIlsxLm
 4g5obuSK0n+zMcOlbOqpMjUBQE4WmCi3q5D03UlPeUF7Fv0Az0GRjDYRbjjyIVQHZ14Dvo8n0xXK8
 fPEJin+75lZNvunGfwQZBRdAk2+myuw8NIHERgQ+Q2SCyv9cxpEGmvrJfOaKU2wKUgy8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uylyA-0005Dm-Hw for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Sep 2025 06:48:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D0733601DA;
 Wed, 17 Sep 2025 06:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5379C4CEF0;
 Wed, 17 Sep 2025 06:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758091715;
 bh=iTstyyfCiGsfuRaBINTgbE7P5G52Z1XmAqxvblvR3BU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=KXd15VlymOXUj2cCehgceb0CPdWS4+egvZbP2DPqny28s31RuHIgsaqHiyfgQesCJ
 iql1xsPQl43bPLva3+LqwgQRhW9IGayHxuUx/zEtjxRnRrwme/slbwdDIBQDcW4vbZ
 HSNWHFnjClIwnVMUMtXLzDens3ADMI935BzyzdOk6EHHn+EaEflmqJDhsFozHKFQqO
 Zp1v7oUefdF4xagDw1iYd4c/he2rMChRlcpoFM0jWx5zylGt3xh1fnhEsooxh8dZQZ
 ljf669u09s2MyWeRZu71WIyuSTjxSFHDkWX4qP2Qw7Kpmutni0hTpk7enH9TI8Dzxk
 9oNcVaBDlSrbQ==
Message-ID: <a625f1dd-ec3b-4e2c-9b3f-8a772cdc69dc@kernel.org>
Date: Wed, 17 Sep 2025 14:48:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250917023622.516052-1-wangzijie1@honor.com>
 <20250917023622.516052-2-wangzijie1@honor.com>
Content-Language: en-US
In-Reply-To: <20250917023622.516052-2-wangzijie1@honor.com>
X-Headers-End: 1uylyA-0005Dm-Hw
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: fix infinite loop in
 __insert_extent_tree()
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
Cc: linux-kernel@vger.kernel.org, feng.han@honor.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/17/25 10:36, wangzijie wrote:
> When we get wrong extent info data, and look up extent_node in rb tree,
> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
> return NULL and print some kernel messages in that case.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
