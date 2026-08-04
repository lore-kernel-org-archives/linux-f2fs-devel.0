Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF58FC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 00:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tX/TNaRD2CrhCEsalpacFwY1gsviL5Nz+76WPQH9VYY=; b=muErQSbkP8i3WPr6kM4H65T8jV
	liW1QF+5XlcF5ACkucuo98J7KtY0MLWnyktWItmX2nscEaoJ+pJ7c+TrKiPW7oXCje41CNM06pOO+
	exTWE1zE4Sl5lIJmsmOB3CLGMJDlxEObaU7N+mQ1TUxdLLVUoFPxlgeHjUOIRsBzP/IY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr3Fe-0005GW-U8;
	Tue, 04 Aug 2026 00:43:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr3Fe-0005GQ-FO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eYsTvoAEEjsByji5T3PRqZGf1eZFMaygK6FFAz/nLUk=; b=PZHRutMhj8AB/GBhJvMT6ojEn1
 Yl4VIoefdJKpg8XRuUPOkgisNjj9h6e2d/jvIMDfZSVHUxs+2SsFZMFul2FzM7QosYivKgXiduDMh
 5uB50rK76ZBkxi9UClamMfG9u69GS/lzhdHeNFSd/Lfj9CZdZKr802wD+I4Gf2qQv8rU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eYsTvoAEEjsByji5T3PRqZGf1eZFMaygK6FFAz/nLUk=; b=Qm5CUzbMsnrqKkSnJ9E67iINvH
 QxDhl2ZrgGSWhLQ3f1LeZunZMEfcMujV60J6hZePnfuO0X+TdpUpeEJN3P8PnbPst7DmGyIaE8p00
 VPKFnaWFW4mLH/NwvWSYkqEq2SkwE1UcKV7wpkRpt/HMnQpBGPkKzsc0bt4/+cF03zBE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr3Fe-00038X-Pf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:43:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 413E6416E9;
 Tue,  4 Aug 2026 00:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8FE1F00A3A;
 Tue,  4 Aug 2026 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785804201;
 bh=eYsTvoAEEjsByji5T3PRqZGf1eZFMaygK6FFAz/nLUk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=RH/3EIIzAp5pXH6g2QQ6BBFp6+jj7fjMplFePcodUE+ScdhTC0Eh/2xa7T8jVOFk7
 +7Ll7+tlgCZqClG1PrVLovv9P3vjMzLKG4h2zUKeQkW60cDAd6Oxh3vZJUqaUoihhz
 ArS25xj8KQl9nREiYY5x591FZWv5pLLhEgIVC8zyGf8Ej3iVFITx2t5EfoiZbK/0AO
 6KYIIjI3sfOUz1r/iU0WKOlZuZBMf1RE1eesiIZPVrV1FUgO4WWmT5kw9fE5GN0sRd
 Yjnokj0NjLuaY4hH+gUDkq0aTLqPLB6kxsl2FBNBrkIqd9lZYB4Bn3CS7yGp6Mv7I9
 0jaDqk7pHEzwA==
Message-ID: <205a9c8e-9067-41f6-ab76-7d7c39cc4dd4@kernel.org>
Date: Tue, 4 Aug 2026 08:43:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260803162935.2056391-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260803162935.2056391-1-daeho43@gmail.com>
X-Headers-End: 1wr3Fe-00038X-Pf
Subject: Re: [f2fs-dev] [PATCH v3] f2fs_io: add dev_alias command for
 dynamic device aliasing management
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

On 8/4/26 00:29, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> This commit adds a new 'dev_alias' command to f2fs_io tool to support
> dynamic release, reservation and status querying of device alias ranges.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
