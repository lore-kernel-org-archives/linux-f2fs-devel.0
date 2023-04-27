Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529F6C77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Apr 2023 09:46:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pryDA-0005RG-NP;
	Thu, 27 Apr 2023 09:46:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pryD9-0005RA-13
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Apr 2023 09:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vwN93UCyAE/H9idQu4OabnuUQFCql1F6iI9eLuzlMqA=; b=cJ3T7I5rVy5GXjpLv2Ig9jKJE3
 G8lMz4UMkc85LLwiDxGS4R+djwZOJZG733B0mRqQyUkXQWa+vaX3rJfd2I6hYb1V/ZHtR5KViFJUx
 XeBVAe4gikawH4Bevyi3LD614eMhSOJenD6hHXBxJuDko3PZQ5pQCrQf6sK/WgXxhXdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vwN93UCyAE/H9idQu4OabnuUQFCql1F6iI9eLuzlMqA=; b=Zt+27F1H8YlQEGWfxDLpplsh70
 hQ1ByrGhqRTusBAiESdvad7OzKHIGe/648kB+BkpMMP+xt+/I7yjN9DMl/0ZDO5LwDr2aOKTXRPWq
 5f8jeRoi5iFiW3lXWAKB+SR9p1mlccN/1aKXQyyXJHrKX9FsmAw5duuLxefitb88ThzM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pryD9-0030rI-9c for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Apr 2023 09:46:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ACA7B637D8;
 Thu, 27 Apr 2023 09:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF1CC433D2;
 Thu, 27 Apr 2023 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682588801;
 bh=faO1Iiushfs5WZXOoTBrEe2Q8A6BFQcPbVG1Q2MeGEQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g8R58B66hbkMv+pphipwP7OoCK6NoAbYBVvkBypg/Ts2a5kqUgkS/ovd/cmy2C2VT
 zdcSKs8cDo9qMw6WYSuI82iBpNYZV6HLTldJqt2BI7dbR/6gjwkyNXIV7fwyKN9xGD
 B2Gk7htoBwg6Fpdm8S+xNJDgaUO15IFjrPbJto3TUiwDLAqZVxHNaXLqkV2pM6j4Xs
 becs6xwX8UwjLL9BhBZT4djDy+9gNUMgY9DJl57ZA0AbmvMiHVGZM1Z9/k/WIzitOU
 WUmRlCkmX/XGLYblF7SnNU5y9ERvux08nWTHxDSUdRgD0n7+xmx6XX0w3V7Qcd8R8L
 FKRip5qFNEaVw==
Message-ID: <1a602371-d9b0-7148-c916-a02c40649d53@kernel.org>
Date: Thu, 27 Apr 2023 17:46:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Daeho Jeong <daehojeong@google.com>
References: <20230425164711.19826-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230425164711.19826-1-frank.li@vivo.com>
X-Headers-End: 1pryD9-0030rI-9c
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: do not allow to defragment files
 have FI_COMPRESS_RELEASED
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
Cc: Qi Han <hanqi@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/26 0:47, Yangtao Li wrote:
> If a file has FI_COMPRESS_RELEASED, all writes for it should not be
> allowed.
> 
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> Signed-off-by: Qi Han <hanqi@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Oh, I just see v2.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
