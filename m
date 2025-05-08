Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FAFC3ABBE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 May 2025 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9E3knw7lGCbAyLJzMMmigVErjUnKRPSnc/gYd8zmwX8=; b=YgZ75Eo9kBjizw4kRE9ge9bQZt
	uY71wLZCjfUeR1G3gBJczL2R1rFUOjZmUL/NpifzwYsTCZ8i3UZw6bGRZMepzMwNx5L7dxCDOOt4c
	J9MQDiIt6laL4KvW9p6to9XfE+YNOQSQyoC7W4WpLYd+trHR7tsB3a7+3SMDkbdxefKw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCwOo-0000K4-84;
	Thu, 08 May 2025 08:14:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uCwOm-0000Ju-7I
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 08:14:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D0ZTKGIxr8QdnfFyHpKet7p38w03Pg7RDpNdhJvtiD0=; b=h9KFTTGE2uKZaOxI29qb3oKL/i
 905FDw6ZP7h1rt4AaLJ3q6cceuefvyCJwBxHETyEzGsCidGUtmSm6ThzWMpsi26MpqJ+MqrMUZkma
 2DVct00YmRPZulRoX19gMqGbbAtCEvaEDrf+YYAuEM4Zye/h+O8ZH5TG3lJc5BhoYa1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D0ZTKGIxr8QdnfFyHpKet7p38w03Pg7RDpNdhJvtiD0=; b=RRa9CYibdGYq+Q5bqQ3B6Cpx+a
 +MFrDI41Rxg2zwLz3HF5mjk3B5KoBL2AbbryojHklVOr8v34QjqAF/nQ1aEw2cgVPxnomaozfRMut
 mPqvAH38ICkO8AbYAGjWRAQmPUQfw067gntgtEI+vRh7fOzgE1n6WMPNu+ui+tnIWobQ=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCwOl-0003l9-N3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 08:14:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1D83AA4DA53;
 Thu,  8 May 2025 08:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AE2C4CEEB;
 Thu,  8 May 2025 08:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746692060;
 bh=AUsNBvqE0HbYXGTJ2WDhpfpO9QGEzenpsghdER8zNx0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=EtpiOV/fyk1ZoEAIhopBuBS8SDHdUtuUUZJtBVUT5Qz5uoswLbuD15vDzBhODHy+9
 ET6Hj62ObUmO0/M3eFGRY5B2AVXB8UDQ4FbvSok3Kc9a3Av3j0sGuKbxKWypWcQIQo
 ca9HTIAOBZZcgQ/p4PuUR9wXOvhIZC9BafCtnKEuZA1Fp5DUMKv8S3Jx5surqvgblN
 YvciQZs6zesqrkChqJdZcMEyK/beXmuicoRzDSg7MFSugJJWzTRZdfJ2LZAYgDY6Nf
 MpucAFyPrQqfRsGo9A6BbxpvJ0NLg4ys0yc3yi0mezgdl6l6irvQn7j6KeDUDicsgy
 kMWUSyUZ/RwSg==
Message-ID: <a856fb64-f55c-4ffa-a457-fdbb094a2797@kernel.org>
Date: Thu, 8 May 2025 16:14:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-7-sandeen@redhat.com>
Content-Language: en-US
In-Reply-To: <20250423170926.76007-7-sandeen@redhat.com>
X-Headers-End: 1uCwOl-0003l9-N3
Subject: Re: [f2fs-dev] [PATCH V3 6/7] f2fs: introduce fs_context_operation
 structure
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
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, lihongbo22@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/24/25 01:08, Eric Sandeen wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> The handle_mount_opt() helper is used to parse mount parameters,
> and so we can rename this function to f2fs_parse_param() and set
> it as .param_param in fs_context_operations.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> [sandeen: forward port]
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
