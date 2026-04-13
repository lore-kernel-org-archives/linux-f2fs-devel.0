Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E37F34C47
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0pj9Ey06xkl3/V+anVsFcwp2hcemnIttI7omt05FMFg=; b=GxQwozJPfjZhpMiU+/Lwvhkeg+
	kXb0pJccFhydH8hWIB/53Zr7m/+yaNWXcsIWJAvWEGEMyplhbgUNbu5SRZpj8maPwJytExWKERUKG
	fkaoZQdAvQovANOm+PZRKLk/H2hplV0FRxX2pqtbRUjA5pPW0VVjw8XIgj9Sc5prlTGo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCFv7-00049Z-FQ;
	Mon, 13 Apr 2026 11:57:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wCFv5-00049L-W0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 11:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O/PfnZBTOdR83/I3kpEtBSksB2yb6HenuGFQKpneogc=; b=B2mMG2OlA2TmzGJyYVz59vug+u
 q6lcMDsub8rchO1H9mj+Sw9BJUW/TGbmNQBhwv6lWoasr6KemEReek4dhK6vNIcthAeRTorbwoQKW
 +BCdDT/yb6DuTq6v/gYbaDRzolo1/gFkn7Yz6ZbwvrcZFTgMhArOQJthl3NSSKv7CEgg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O/PfnZBTOdR83/I3kpEtBSksB2yb6HenuGFQKpneogc=; b=f1xhGml3SmXOqgmHKUjWrisfKG
 DNKCwZ/7C243bJy4Ypr7p7GOSRNlG67nrH79KiIZZa2GUdaH1tbmg0f0u2rqhtuUvX6YzkuVRuWp2
 pu4VnuIRjkpnZRlBYxuHo1suOQJmPPqpcTISs4SPvbWbJTr3EntMDlZH2k8WfD6zEdNQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCFv6-00053i-CN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 11:57:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B4A2A60172;
 Mon, 13 Apr 2026 11:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F3EC116C6;
 Mon, 13 Apr 2026 11:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776081450;
 bh=ZbpZGimKZ8TuH/bod+RImrwQF3exPqJv9+ZmXtAijb0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=SNlyBBcAPpq+kbgYLfw5u3spcG2iL7nq0oQ2IDPcyjHtM/ZIlDQ3/li0mmN2V04yX
 fqHcorJZUsVuf+jhsl8+lfQas/cX5pXBh/oTkWgoS73xYZ+Gn+N8gaLK9o1aJXqOPq
 6CM7YfC6ETKgjnEO64uWt/yGuZ/qGaDq95U7pTsrKIeA109mLu1AI1Rt/EvB6Z8UwA
 QGAs+t2BnaICJmbPram+5r7qQG12R2skQvpVuRO2kJDXUPUTfe+Fx/fRcvQwMvKqWA
 hdBCTxt0PLmSd3PGIFI7Xp4ZvrLB+NxtghOLZqqJMUmU1pafnvQ0F5C9Ru6NTjQyiU
 pZ5kDGH75LX7g==
Message-ID: <067cb47e-40e1-47b2-8b03-f070830f5c64@kernel.org>
Date: Mon, 13 Apr 2026 19:57:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260410150537.1683974-2-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260410150537.1683974-2-monty_pavel@sina.com>
X-Headers-End: 1wCFv6-00053i-CN
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: disallow setting an extension to
 both cold and hot
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/10/2026 11:05 PM, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> An extension should not exist in both the cold and hot extension lists
> simultaneously. When adding a hot extension, check whether it already
> exists in the cold list, and vice versa. Reject the operation with
> -EINVAL if a conflict is found.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
