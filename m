Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489E6C021A1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2025 02:19:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ti2Lw-0004KG-5m;
	Wed, 12 Feb 2025 02:19:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ti2Lv-0004KA-9l
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 02:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b7sgtyZTcl4uffClR2KEtxoUWKI7Z1y71gB6+MoLXJs=; b=McwB+kfgvM3sKESOoMQMHa0GbC
 7zSHdcQ1mtSetm5rG8A7Tgw9H3O/5glepOf756ywQTtDV9CY1C0AhQipPdHALtfaCml3ycn1Woef+
 ba3eNiGheQmvdsnlCOqETtuFxVDyWX5gX11zT4opatPvGTTUmOUCJToXixkfjdRi4X6c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=b7sgtyZTcl4uffClR2KEtxoUWKI7Z1y71gB6+MoLXJs=; b=HEyUaY5wIeR2Qd1E6e9HM+Fd9d
 MR8Shtd6In6g8LJkrcDRzFmajQMUoCM72zzricqn627GE5SsVemcqx3jAI1XioJ4K5XhmOVyjpHmj
 7/DQaOQsrUUiBC6jiXaigShMSKwAMlgZEyQz6+cn61lUnEFYNX8EGPuZNr+omhY5uBVk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ti2Lt-0007vV-OU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 02:19:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D2B485C5A33
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Feb 2025 02:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C1C4CEDD;
 Wed, 12 Feb 2025 02:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739326779;
 bh=G3DyCsWA6hOD7ERSraNbl8ymdQssGhj7+YKacyKvS34=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=oElwa8av0mZa6n0uOiIzT/A2Yhe5awzpcaeI9UjrWgNfoNVBGzs0PRDsXQZgmcE/q
 jTH64t9uWY29GGPmEj6ZdLGFBOiFMWihL4EU8ahKNGZP/sWkHRcEP4bKrnAXQE/jJ4
 hU14ddTaHL2/fuCG9vapBoLnLwqn2/EPxEf2lIvj2VSLC34R8vLMlrLqGgu07PZLOx
 mU4V5xM2Jk/oUJZTgiMy+nBWYl/P7q1j2/zf5DMx/m0JCFSdGIGlT5JyzB73I9+0mc
 IBBP8IOxbxgS+Tyad5iQnJcZ5VqVqEIfH4rBIWwFihllova1DXax44fNt3X0sFxEiI
 yLeZfBGqBrxuA==
Message-ID: <31caadac-f56f-469b-bb5d-f58b3ab5e309@kernel.org>
Date: Wed, 12 Feb 2025 10:19:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250205214014.3270585-1-jaegeuk@kernel.org>
 <Z6u6qN2ATQKlfmRQ@google.com>
Content-Language: en-US
In-Reply-To: <Z6u6qN2ATQKlfmRQ@google.com>
X-Headers-End: 1ti2Lt-0007vV-OU
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add ioctl to get IO priority hint
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/12/25 05:01, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch adds an ioctl to give a per-file priority hint to attach
> REQ_PRIO.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
