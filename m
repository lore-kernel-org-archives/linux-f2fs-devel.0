Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD86EC55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 06:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7Y9UIBfcEr0A8C5yhSH8xGO3PwahRffiUD7OFVzPmg=; b=DQS/gcEYL5nEq52E7oNOTzdZ55
	3lXbwe+ituEjdFTmId//nTrIw+JPoPVlUg9VrYGjiLe6URwmYghjPLstVbDssE6GQTO3IhDzw5pQN
	SK/AzGje0BwvGNdML/otcmo3irzNKyyVRx+gOBMgEiOIv8zwuhg4IWjBS9aULLaSqmMo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqmGD-0004lE-IF;
	Mon, 03 Aug 2026 06:34:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqmGC-0004l1-8J
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 06:34:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1xo3QhVa/3N9gRoVOTnoKB8qxDMTYOzjDluERd6gZBU=; b=MKelzuVGRJhm1sP+6zZq738qWJ
 sBIYcbNfBMVkLViSaSSyd+E47Wa/ibWcDBHufMCEYEBgXgjiUrCM2P8ro6xn/pwlMTyyKiDLLv/M5
 D2dZlnMRhh6vMcpz3oRwORcLtdMkgNoF8m19seOnhhqEl9/hJEeaNLq+ZW8YThHsYob4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1xo3QhVa/3N9gRoVOTnoKB8qxDMTYOzjDluERd6gZBU=; b=XSgKWU2NKf5U1gXILxL59CLAWQ
 StP13NlLKkF86bOtDBLNDCVO2S+ClgkcR2sClXLr2UwN03Ii7vJxb0T1DqRqD5ANfaWKq1MlCwv47
 ds6MPoFBP9ifCDOtdnBc8Pe6GjCJn2OfjW1OSFJlJLX7kq8u97uEHCuZnT/SQiNbDuJc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqmG8-0004sT-P6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 06:34:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5976643F45;
 Mon,  3 Aug 2026 06:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6BD1F000E9;
 Mon,  3 Aug 2026 06:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785738883;
 bh=1xo3QhVa/3N9gRoVOTnoKB8qxDMTYOzjDluERd6gZBU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=EFKnAWgOtmuT+4QF3+nakc7y7eOiN2UZDdvKWVwyy1UzWcS/Ni1vMTBXa5uxbKDV6
 ZhQ2ttGIBL5RhJDaZPO27DB7T1C9iZIG/lzp6mhcTztSh9wcqjSP2f6Y0KMb245/YR
 jxdl1TsoaLaYpawiNzMAZtuRytY1zThgtbKDlaex/ri27PJrbV0nUnv3Vv6UqTUjHQ
 dUYSoTYmp1zj/0kcwK8rtd0Uhp8J+zIOzmZfZHaJsRDkXP6WVqq+N7JTzONvpjR/uV
 9aSZoq4qfK3dPTGljTAnhmYOiBpq1LPzwGGuceUDP/Pn+Y5mAkKgknp3RhxWWeWVQx
 GxKdCfiRAjNDA==
Message-ID: <2405e513-c1be-4281-8ab8-bb1ed48bbf14@kernel.org>
Date: Mon, 3 Aug 2026 14:34:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
X-Headers-End: 1wqmG8-0004sT-P6
Subject: Re: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner
 check in f2fs_xattr_advise_set()
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
Cc: Christian Brauner <brauner@kernel.org>,
 Zhan Xusheng <zhanxusheng@xiaomi.com>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Pedro Falcato <pfalcato@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/16/26 10:59, Zhan Xusheng wrote:
> f2fs_xattr_advise_set() calls inode_owner_or_capable() with &nop_mnt_idmap
> before allowing the "system.advise" xattr to be set, instead of the idmap
> that the VFS passes to the ->set() handler.
> 
> f2fs supports idmapped mounts, so on such a mount this checks the caller's
> fsuid against the unmapped on-disk owner rather than the mapped owner: the
> actual owner can be wrongly denied with -EPERM and an unrelated caller
> wrongly allowed.  Pass the handler's idmap instead.
> 
> Fixes: 01beba7957a2 ("fs: port inode_owner_or_capable() to mnt_idmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
