Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C88C3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Aug 2024 00:54:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1seOlK-00047k-4T;
	Thu, 15 Aug 2024 00:54:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1seOlI-00047d-Q0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Aug 2024 00:54:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UI0GYpGP6bVCLm6aahMBO1g5CYBUTfP5SvmiltHA5dc=; b=KnSL1FvBGkxXEZuwWCQC2Pbg61
 dsO68v7a8QsLEEAfb3HU1Q9dlb5aAEQuoCh9K420nTlUVbj72RBNjgHW9DkxfLKNedCJHo8k3AiWk
 fHHiO6A2ZwZbAoZWarNTkM+9oj5be2Bz/ulW/92YqkAF496DKxDz0AXcUr1L6yEd/uLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UI0GYpGP6bVCLm6aahMBO1g5CYBUTfP5SvmiltHA5dc=; b=Nt+IICeNZ2zjnPSlzEpoWs3NiZ
 XzxPVpZai4g881U1myKbL4d6WldpbCsix67ajdaXkNrbYtRoJbtJmfnzmJMWvHFnLpqXS4IVn2t6r
 UsR6vZGncgfTHEQVWyQTV2l6U7o4zhtvX9LyFq+7ZKgOGvpM0t4fmAbT18CA62uoVPUQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1seOlH-0002Qk-IX for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Aug 2024 00:54:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3B09761D24
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Aug 2024 00:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCABC116B1;
 Thu, 15 Aug 2024 00:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723683277;
 bh=AMmgmvHw2duJ7/lByrYy1Zcx/4w/GMr0h9iKkc9JjlQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=YEhx7V2jdtQ/nfBRyqvIVpItEknq1Trj/jFLtnMOHozHeKuzf1UcLXYAIBIapGiTf
 nZSGMCdDHwi+B30F3zkshWMsJ0IOtyFK3qN2G+h3B16kQbtvjQcfHm5mb0Kv9O1R86
 RofXDWzOM+9OtZXXXBSSdRmPloDREU1L9y+zbGPSSJTeDnqKZ4oFw/4sxJDOBotDa7
 DdqRqk/GeFaojAT8y+ofsNUV0Kj8urnGrOIvdcAJFibP5180r/8GIz9I6AuFUZ4CPT
 O7HgqEZa6faNnrcPLA6tmXRZWpX/zKjGgxc8tw3n0hrCJhbje9Lmb65qHf4ac+snXC
 Y4qXswwpTo3eA==
Message-ID: <6e5d7fe9-4c5b-4467-840a-6511be4a77d4@kernel.org>
Date: Thu, 15 Aug 2024 08:54:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20240808205732.292600-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240808205732.292600-1-jaegeuk@kernel.org>
X-Headers-End: 1seOlH-0002Qk-IX
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: don't finish zones if it's not
 open
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

On 2024/8/9 4:57, Jaegeuk Kim wrote:
> Should finish zones if they are open.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
