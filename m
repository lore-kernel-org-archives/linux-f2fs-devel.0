Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0DC001DE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jul 2023 00:50:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLYv6-0007Eh-G3;
	Tue, 18 Jul 2023 00:50:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qLYv3-0007EW-Lx
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jul 2023 00:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QYiaMV5DhSvbtMurocMaC8W4p/gSEbAyUEWdW4FLWXM=; b=Qxz1WT5qRrIcg2lwowd259PYr4
 7OCZHxh2HGn63i50lF0NOC0DNRmSK67S41T51GZj0AVENdTC8rKqQYpJiFjwlhNfV6y/xGZPwyXqw
 BJowAJADY7etPD4u1phcEySeIt6mw9PspRRi8+ssGkc53+5gsNHzzcRNbItygZeqODWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QYiaMV5DhSvbtMurocMaC8W4p/gSEbAyUEWdW4FLWXM=; b=E5ZT726x22Kgas8iFxBFCpiCIO
 ldOytvyDePSc+D/7bmJ8UlK1FNF3NceROHmgqjFctG1sfG6KPD5Wc8zl5uBEuW0zCP2Zcv6zZuWK+
 iCdFUEodiFJDbVTjlQuBBtNaklZ4jFqeve8Xt+F0OUT1O4+8TvAJfc21hOpFmICHazWE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLYv3-0000wJ-Uw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jul 2023 00:50:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4856C6134B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Jul 2023 00:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7D5C433C7;
 Tue, 18 Jul 2023 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689641417;
 bh=oi0P5Z1z3e5pzyK9cu5qK0GfiD7NuaDR71W7Q+a65Jk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=oMzLKQEVnVw0XAYge6OvtxePsHW0WLXe9CMi5BeIdrhUoyo/FI4t3CQvvUe8m47+Y
 Gu2oTnm868k1y7d0en6kx2EVKRJLYSSrprY7t4yo3Efx59u+0kk+KA+SVx8mF/X+3M
 N5zgrzCJljNazxbqMBMgx6dPmcUKDtukqLavRzOo1p9vzuNxXYyTieSNWduIUANDTm
 X1sSrsbvzWvYDnZYSceNROQlg6O0r4S/EBWbd1oUBE7Ev8Gp41SPRx5DvkuwUyzcWM
 uD0LI727s4knXDyUNDbfBHNofP3Pjb2ZGhUeXUqEx8SlQLxqcxVHQ1+cVc7qvdQPnJ
 T3pESM1nHv54Q==
Message-ID: <50c3e421-3426-c06c-7ef5-ac74da475729@kernel.org>
Date: Tue, 18 Jul 2023 08:50:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20230717181805.285894-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230717181805.285894-1-jaegeuk@kernel.org>
X-Headers-End: 1qLYv3-0000wJ-Uw
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: quick fix for Android build
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

On 2023/7/18 2:18, Jaegeuk Kim wrote:
> In file included from external/f2fs-tools/lib/nls_utf8.c:29:
> external/f2fs-tools/include/f2fs_fs.h:1781:44: error: call to undeclared function 'S_ISDIR'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>          raw_node->i.i_current_depth = cpu_to_le32(S_ISDIR(mode) ? 1 : 0);
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
