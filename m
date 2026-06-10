Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3087CD8CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KcHK93c/pLLVKyyVX/TBcOHJI427CIKTNKH9dOsllh8=; b=D1SA9F+WnLXx0gGcQCK4S+S/Qa
	lNPSQOS0PyRct5RIwcyLxVlu+14X/uQ5/V3H/vWOqWDw/KvIuntAUDdyrQajV1MRonJVYObqn79qD
	GnBq4MHrONczaJ1SU8rd79rANg4Q/X/zvEspiBEE7y95wHA1gRaTah8LpkSMHAN+ushY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXHmL-0003l6-Pu;
	Wed, 10 Jun 2026 12:11:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXHmK-0003ky-Dn
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:11:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hSNicDTYfl8U3UmvTaaeH8VyyQMvggeU829q0X18bno=; b=I7F62Ls2n/3usXF9tecPFi0qXn
 DOWrBOOkmgcA/5yS/+JtDSQ3f1kWD9Q+/Ybx1U9SeW1P0Z8alH/Tn9Lfcqre6Stcn6roX/v6c9/kz
 jVyi8k8mXQEaufuXYpXHsr/yKVhkYtpUHmOIa1MnNbgMZyVi0hKk8tgxP7RBMgOk7nLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hSNicDTYfl8U3UmvTaaeH8VyyQMvggeU829q0X18bno=; b=Jw7sKe4dQGHt5UBPSQnLsBXA4k
 7NE6g+2N9gj4QK8OtLE25p61iLSlYCPP3gl4OVIFOwGuHs/MKCujucZIGXz6/fX+bSeHoE8v/OpSM
 SyrJu+dECQmIzvFT8KzoCYLNB8FaDLSRRWMATFA3ZsX7s9OaARYx1dDTC+8PlHLyBQAk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXHmG-0004Pn-WA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:11:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1708143D58;
 Wed, 10 Jun 2026 12:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186631F00893;
 Wed, 10 Jun 2026 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781093474;
 bh=hSNicDTYfl8U3UmvTaaeH8VyyQMvggeU829q0X18bno=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Z8oiM+P572x9zZ4Uo/O43RTwVLg/WcYJM2PZgXxFnyeQfMH6Rg6gRAO0MoEzHZp/+
 eYGjP97qvkyCAVjyl4vmVAyscHFeBMpFf2M0fcRtHmG/jXZInMCy9W63TvpHc/jqNw
 tojXLwnxScfc9nOprvVSifnF4Pz/FBx5aZM9qBgpOkLTGIOrhMv1dxf17Zw4ASUEL8
 gSdrdttxd/xRxWQxMqdfHtp/3X+qL4Y7GcgRECxvPLwFJHxnPCYEIjvV7pk1CjNqa1
 snHMdqddwOkmaBidTGTCJv83g0WLuoMRbQeWlqYHb/E61cYIvsS/gsJ091viCgGxjC
 1WJStbSRQ293Q==
Message-ID: <4b337c7f-2fbd-47b6-9c8c-587e7b5513f1@kernel.org>
Date: Wed, 10 Jun 2026 20:11:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bart Van Assche <bvanassche@acm.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1780003055.git.bvanassche@acm.org>
 <7e756908a2b43b403ae9006b260b4889f64ee42a.1780003055.git.bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <7e756908a2b43b403ae9006b260b4889f64ee42a.1780003055.git.bvanassche@acm.org>
X-Headers-End: 1wXHmG-0004Pn-WA
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: Split f2fs_write_end_io()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/29/26 05:20, Bart Van Assche wrote:
> Prepare for running most of the write completion work asynchronously.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
