Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D238EB64D8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jun 2023 06:21:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qBUjr-0007xB-Uv;
	Tue, 20 Jun 2023 06:21:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1qBUjq-0007x4-F6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jun 2023 06:21:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FLhDuaK+KUTsENCj+dFycBBE3xj46JtEPCzSUFxPqtg=; b=dTlPUGiZtFACfsE6VpqgHrlTGa
 8JSF85g6jOOuT6ba6zZYfappBMITdpIzdBsE9mP6J9btW0ZZKAA8C31nuJ1ZnRP5ku7eOokDUKBAZ
 ktHGvJJP4w3hiWq0vmI7OcYY7weYVg21tpTYzbLdd7QSnjlexjohO5VUlWtTtnnYiS84=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FLhDuaK+KUTsENCj+dFycBBE3xj46JtEPCzSUFxPqtg=; b=ZKxA6HDRuAHGmo5+DyJeVxwC9u
 F+QtFshBRwA5UZY2u07+YgsP9VRULJo+2MH5+20EID+Ph3dIaL0hBHxsRrmVD6kVt6tTYMoXbAP2f
 VnRD7bzrz9xvNep8o1SQG5SbQ0YpCBiZbvgpeI9gb97BKAMCbpso1K1SOuGquRjAYwfc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qBUjq-009KoJ-Od for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jun 2023 06:21:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7EBB560D2C;
 Tue, 20 Jun 2023 06:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E14C433C0;
 Tue, 20 Jun 2023 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687242067;
 bh=sEap7AtmGyj6ny2xcB77NlrkCp0q4sTLn1Jg45n5M8k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hHlr6iiLgaTzT0h0qDFm0ofeichsRQ137PSvtADwNRjz4eHx+fCOYy3UJgHccElyK
 lrnuEpGz6mRdu4zbhNYI9QZyaAtIqKRyd2c6opwWFBm9WSrVBe6TlXZunw2+9B3A1K
 maYU3VLS5r41tNexlaj/K/2qJzZr/2et2c3b7IE0Pq6yaXnj7lswBDhQf3Dz2vts0i
 zKOy1kXF/Ge11JJwtMCIDUI8ZZn9EXPnF4uaELh2H0Oz58mJmkxXwfgF7vuOp86DFn
 D25m2RmvmcolsE/rOTtl/pkfg/ENOXnIdfro8cX7ofz4rXWi6L4hksuCeF5S/FHfE6
 yEMAwc4Xf8Mxg==
Date: Mon, 19 Jun 2023 23:21:06 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZJFFUuB6EemEg/DH@google.com>
References: <20230425165857.29175-1-frank.li@vivo.com>
 <5409930b-4379-b279-886b-a05149436a68@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5409930b-4379-b279-886b-a05149436a68@kernel.org>
X-Headers-End: 1qBUjq-009KoJ-Od
Subject: Re: [f2fs-dev] [PATCH] f2fs: no need test opt for f2fs_issue_flush
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/19, Chao Yu wrote:
> On 2023/4/26 0:58, Yangtao Li wrote:
> > This information can now be obtained from the mount, and there isi
> > no need to print it out every time the trace event is triggered.
> 
> It makes sense.
> 
> Jaegeuk, is it intentional to print mount option in f2fs_issue_flush
> tracepoint?

I don't remember tho, do we have a strong reason to change the tracepoint?

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
