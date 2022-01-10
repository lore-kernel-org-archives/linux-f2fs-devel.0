Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9ACC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jan 2022 11:55:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n6tHC-0007eo-76; Mon, 10 Jan 2022 11:55:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1n6tHB-0007eh-8S
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 11:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yjZd5kveUD3AMmFB1w5qA3XODMeUozdndvAq0LtS4yI=; b=LGcEkE5nWhnGlXE9v1BtP+038F
 /NbJXyQy+tN61EmIuuqo4nkIzZfU1CdMP9OyaXDG+yioHWZ5O3/kYjbcfL+D3A9hDRARGn9f6j/uh
 bSp/FpyPBevIeQrs5n2E+/a9BUO8YsW2kRTG3/Zb6F3zk8tqXWHD0A84TasORW/D3y6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yjZd5kveUD3AMmFB1w5qA3XODMeUozdndvAq0LtS4yI=; b=cgpo3Ni3bVvmeDM9H942POb5Gi
 GliDOEWq8tFGRK+qLGfJfa/G0UAtv7Nh3H1jv28b7p2KES5O+00ZqcNWibnHwDlDInyURPocdi4GR
 g0KcKpKN+wh5hsldh9uegXV61nc2qzILXC5t9L/q6rPo80mgUYqa9HQjFua/G+h5PW5o=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n6tH9-0005Df-SQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 11:55:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DF3DB6127D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Jan 2022 11:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13C0C36AE5;
 Mon, 10 Jan 2022 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641815740;
 bh=rRcag0Wru4htyDyypLq1Ra7PS+1wh1Z6ri+Ua7S+Ajk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=rqcXmrS1sNkJWXHdZ7Nh7IEM1sObBhjx+voP2/KOdLGQEbgOOl9dVe3WnvkSr0cs+
 99w5d5WY81sXY4/vC1wzSp3lSbJPGhzaWix+CCmUFrwugg4Jg37bvUI5UAzy2qlimU
 1HZMKAtKv5wz4DorSePFk1n9nCd2dRps1F/tqthZZTQrTyQqRVEzPD17TXlVJqk4dq
 v3nAA/bImB1NU8D0AndgM4gCAzsogVSdX44NOQVp6gtyRGf1Gz79OhPUhrfVB7PIpR
 hbAN9LLxceZOD6MOBU0fpSggszEyxkqtQuSxXLmAn8o5QBqLIMhfkbfTQmtmZCn2wr
 TTZuaYLoWGqXw==
Message-ID: <e0f8de9e-02f5-acf3-6226-f253c423f57d@kernel.org>
Date: Mon, 10 Jan 2022 19:55:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220108164552.3130085-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220108164552.3130085-1-jaegeuk@kernel.org>
X-Headers-End: 1n6tH9-0005Df-SQ
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not allow partial truncation on
 pinned file
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

On 2022/1/9 0:45, Jaegeuk Kim wrote:
> If the pinned file has a hole by partial truncation, application that has
> the block map will be broken.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
